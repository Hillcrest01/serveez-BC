codeunit 50105 "SD Payment Management"
{
    // Caption = 'Serveez Payment Management';

    procedure CreatePayment(
        OrderNo: Code[20];
        PaymentProvider: Option "M-Pesa",Paystack,Other;
        Amount: Decimal;
        Currency: Code[10];
        ProviderTransactionID: Text[100];
        ProviderReference: Text[100]): Code[20]
    var
        PortalOrder: Record "SD Portal Order";
        Payment: Record "SD Payment";
        PaymentNo: Code[20];
    begin
        if OrderNo = '' then
            Error('Order number is required.');

        if not PortalOrder.Get(OrderNo) then
            Error('Order %1 does not exist.', OrderNo);

        if PortalOrder."Order Status" = PortalOrder."Order Status"::Cancelled then
            Error('Payment cannot be created for cancelled order %1.', OrderNo);

        if PortalOrder."Order Status" = PortalOrder."Order Status"::Rejected then
            Error('Payment cannot be created for rejected order %1.', OrderNo);

        if PortalOrder."Order Status" = PortalOrder."Order Status"::Draft then
            Error('Payment cannot be created for a Draft order.');

        if Amount <= 0 then
            Error('Payment amount must be greater than zero.');

        if Currency = '' then
            Error('Currency is required.');

        if Amount > PortalOrder."Amount Due" then
            Error(
                'Payment amount %1 cannot exceed the outstanding amount of %2.',
                Amount,
                PortalOrder."Amount Due");

        if ProviderTransactionID <> '' then
            if PaymentTransactionExists(ProviderTransactionID) then
                Error(
                    'Payment with provider transaction ID %1 already exists.',
                    ProviderTransactionID);

        PaymentNo := GetNextPaymentNo();

        Payment.Init();
        Payment."Payment No." := PaymentNo;
        Payment."Order No." := OrderNo;
        Payment."Payment Provider" := PaymentProvider;
        Payment."Provider Transaction ID" := ProviderTransactionID;
        Payment."Provider Reference" := ProviderReference;
        Payment.Amount := Amount;
        Payment.Currency := Currency;
        Payment.Status := Payment.Status::Pending;
        Payment."Created At" := CurrentDateTime();
        Payment."Modified At" := CurrentDateTime();
        ValidateRequiredInitialPayment(
            PortalOrder,
            Amount);
        Payment.Insert(true);

        RecalculateOrderPayment(OrderNo);

        exit(PaymentNo);
    end;

    procedure MarkPaymentSuccessful(PaymentNo: Code[20])
    var
        Payment: Record "SD Payment";
    begin
        GetPayment(Payment, PaymentNo);

        if Payment.Status <> Payment.Status::Pending then
            Error(
                'Only pending payments can be marked as successful.');

        Payment.Status := Payment.Status::Successful;
        Payment."Transaction Date" := CurrentDateTime();
        Payment."Modified At" := CurrentDateTime();

        Payment.Modify(true);

        RecalculateOrderPayment(Payment."Order No.");
    end;

    procedure MarkPaymentFailed(
        PaymentNo: Code[20];
        GatewayResponse: Text[250])
    var
        Payment: Record "SD Payment";
    begin
        GetPayment(Payment, PaymentNo);

        if Payment.Status <> Payment.Status::Pending then
            Error(
                'Only pending payments can be marked as failed.');

        Payment.Status := Payment.Status::Failed;
        Payment."Gateway Response" := GatewayResponse;
        Payment."Transaction Date" := CurrentDateTime();
        Payment."Modified At" := CurrentDateTime();

        Payment.Modify(true);

        RecalculateOrderPayment(Payment."Order No.");
    end;

    procedure CancelPayment(PaymentNo: Code[20])
    var
        Payment: Record "SD Payment";
    begin
        GetPayment(Payment, PaymentNo);

        if Payment.Status <> Payment.Status::Pending then
            Error(
                'Only pending payments can be cancelled.');

        Payment.Status := Payment.Status::Cancelled;
        Payment."Transaction Date" := CurrentDateTime();
        Payment."Modified At" := CurrentDateTime();

        Payment.Modify(true);

        RecalculateOrderPayment(Payment."Order No.");
    end;

    local procedure GetPayment(
        var Payment: Record "SD Payment";
        PaymentNo: Code[20])
    begin
        if PaymentNo = '' then
            Error('Payment number is required.');

        if not Payment.Get(PaymentNo) then
            Error('Payment %1 does not exist.', PaymentNo);
    end;

    local procedure PaymentTransactionExists(
        ProviderTransactionID: Text[100]): Boolean
    var
        Payment: Record "SD Payment";
    begin
        Payment.SetRange(
            "Provider Transaction ID",
            ProviderTransactionID);

        exit(not Payment.IsEmpty());
    end;

    local procedure GetNextPaymentNo(): Code[20]
    var
        Payment: Record "SD Payment";
        NextNumber: Integer;
        ExistingNo: Code[20];
    begin
        if Payment.FindLast() then begin
            ExistingNo := Payment."Payment No.";

            if Evaluate(NextNumber, CopyStr(ExistingNo, 5)) then
                NextNumber += 1
            else
                NextNumber := 1;
        end
        else
            NextNumber := 1;

        exit(
            'PAY-' +
            Format(
                NextNumber,
                6,
                '<Integer,6><Filler Character,0>'));
    end;

    procedure RecalculateOrderPayment(OrderNo: Code[20])
    var
        PortalOrder: Record "SD Portal Order";
        Payment: Record "SD Payment";
        Refund: Record "SD Payment Refund";
        AmountPaid: Decimal;
        AmountDue: Decimal;
        RefundedAmount: Decimal;
        HasPendingPayment: Boolean;
    begin
        if not PortalOrder.Get(OrderNo) then
            exit;

        AmountPaid := 0;
        HasPendingPayment := false;

        Payment.Reset();
        Payment.SetRange(
            "Order No.",
            OrderNo);

        if Payment.FindSet() then
            repeat
                case Payment.Status of
                    Payment.Status::Successful,
                    Payment.Status::PartiallyRefunded,
                    Payment.Status::Refunded:
                        begin
                            RefundedAmount := 0;

                            Refund.Reset();
                            Refund.SetRange(
                                "Payment No.",
                                Payment."Payment No.");
                            Refund.SetRange(
                                Status,
                                Refund.Status::Successful);

                            if Refund.FindSet() then
                                repeat
                                    RefundedAmount += Refund.Amount;
                                until Refund.Next() = 0;

                            AmountPaid +=
                                Payment.Amount - RefundedAmount;
                        end;

                    Payment.Status::Pending:
                        HasPendingPayment := true;
                end;
            until Payment.Next() = 0;

        AmountDue :=
            PortalOrder."Total Amount" - AmountPaid;

        if AmountDue < 0 then
            AmountDue := 0;

        PortalOrder."Amount Paid" := AmountPaid;
        PortalOrder."Amount Due" := AmountDue;

        if AmountPaid >= PortalOrder."Total Amount" then
            PortalOrder."Payment Status" :=
                PortalOrder."Payment Status"::Paid
        else
            if AmountPaid > 0 then
                PortalOrder."Payment Status" :=
                    PortalOrder."Payment Status"::PartiallyPaid
            else
                if HasPendingPayment then
                    PortalOrder."Payment Status" :=
                        PortalOrder."Payment Status"::PaymentPending
                else
                    PortalOrder."Payment Status" :=
                        PortalOrder."Payment Status"::Unpaid;

        PortalOrder."Modified At" := CurrentDateTime();

        PortalOrder.Modify(true);
    end;

    local procedure ValidateRequiredInitialPayment(
    PortalOrder: Record "SD Portal Order";
    NewPaymentAmount: Decimal)
    var
        RequiredInitialPayment: Decimal;
        CurrentPaidAmount: Decimal;
    begin
        CurrentPaidAmount :=
            GetNetPaidAmount(
                PortalOrder."Order No.");

        if CurrentPaidAmount > 0 then
            exit;

        RequiredInitialPayment :=
            GetRequiredInitialPayment(
                PortalOrder);

        if NewPaymentAmount < RequiredInitialPayment then
            Error(
                'The minimum initial payment for order %1 is %2.',
                PortalOrder."Order No.",
                RequiredInitialPayment);
    end;

    local procedure GetRequiredInitialPayment(
        PortalOrder: Record "SD Portal Order"): Decimal
    var
        OrderLine: Record "SD Portal Order Line";
        Service: Record "SD Service";
        Product: Record "SD Product";
        RequiredAmount: Decimal;
        LineDeposit: Decimal;
    begin
        RequiredAmount := 0;

        OrderLine.Reset();
        OrderLine.SetRange(
            "Order No.",
            PortalOrder."Order No.");

        if OrderLine.IsEmpty() then
            exit(0);

        if OrderLine.FindSet() then
            repeat
                case OrderLine."Line Type" of

                    OrderLine."Line Type"::Service:
                        begin
                            if not Service.Get(
                                OrderLine."Service Code")
                            then
                                Error(
                                    'Service %1 does not exist.',
                                    OrderLine."Service Code");

                            if not Service."Allow Partial Payment" then
                                exit(
                                    PortalOrder."Total Amount");

                            LineDeposit :=
                                OrderLine.Amount *
                                Service."Deposit Percentage" /
                                100;

                            RequiredAmount +=
                                LineDeposit;
                        end;

                    OrderLine."Line Type"::Product:
                        begin
                            if not Product.Get(
                                OrderLine."Item No.")
                            then
                                Error(
                                    'Product %1 does not exist.',
                                    OrderLine."Item No.");

                            if not Product."Allow Partial Payment" then
                                exit(
                                    PortalOrder."Total Amount");

                            LineDeposit :=
                                OrderLine.Amount *
                                Product."Deposit Percentage" /
                                100;

                            RequiredAmount +=
                                LineDeposit;
                        end;
                end;
            until OrderLine.Next() = 0;

        RequiredAmount +=
            PortalOrder."Delivery Charge";

        if RequiredAmount >
           PortalOrder."Total Amount"
        then
            RequiredAmount :=
                PortalOrder."Total Amount";

        exit(
            Round(
                RequiredAmount,
                0.01));
    end;

    local procedure GetNetPaidAmount(
        OrderNo: Code[20]): Decimal
    var
        Payment: Record "SD Payment";
        Refund: Record "SD Payment Refund";
        NetPaid: Decimal;
        RefundedAmount: Decimal;
    begin
        NetPaid := 0;

        Payment.Reset();
        Payment.SetRange(
            "Order No.",
            OrderNo);

        if Payment.FindSet() then
            repeat
                case Payment.Status of

                    Payment.Status::Successful,
                    Payment.Status::PartiallyRefunded,
                    Payment.Status::Refunded:
                        begin
                            RefundedAmount := 0;

                            Refund.Reset();
                            Refund.SetRange(
                                "Payment No.",
                                Payment."Payment No.");
                            Refund.SetRange(
                                Status,
                                Refund.Status::Successful);

                            if Refund.FindSet() then
                                repeat
                                    RefundedAmount +=
                                        Refund.Amount;
                                until Refund.Next() = 0;

                            NetPaid +=
                                Payment.Amount -
                                RefundedAmount;
                        end;
                end;
            until Payment.Next() = 0;

        exit(NetPaid);
    end;

}