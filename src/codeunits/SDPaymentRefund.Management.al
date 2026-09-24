codeunit 50111 "SD Payment Refund Management"
{
    // Caption = 'Serveez Payment Refund Management';

    procedure CreateRefund(
        PaymentNo: Code[20];
        RefundProvider: Option "M-Pesa",Paystack,Other;
        Amount: Decimal;
        Reason: Text[250];
        ProviderRefundID: Text[100];
        ProviderReference: Text[100]): Code[20]
    var
        Payment: Record "SD Payment";
        Refund: Record "SD Payment Refund";
        AlreadyRefunded: Decimal;
        RefundableAmount: Decimal;
        RefundNo: Code[20];
    begin
        if PaymentNo = '' then
            Error('Payment number is required.');

        if not Payment.Get(PaymentNo) then
            Error(
                'Payment %1 does not exist.',
                PaymentNo);

        if Payment.Status <> Payment.Status::Successful then
            if Payment.Status <> Payment.Status::PartiallyRefunded then
                Error(
                    'Only successful or partially refunded payments can be refunded.');

        if Amount <= 0 then
            Error('Refund amount must be greater than zero.');

        if Reason = '' then
            Error('Refund reason is required.');

        if ProviderRefundID <> '' then
            if RefundProviderIDExists(ProviderRefundID) then
                Error(
                    'Refund with provider refund ID %1 already exists.',
                    ProviderRefundID);

        AlreadyRefunded :=
            GetSuccessfulRefundedAmount(PaymentNo);

        RefundableAmount :=
            Payment.Amount - AlreadyRefunded;

        if RefundableAmount <= 0 then
            Error(
                'Payment %1 has no refundable amount remaining.',
                PaymentNo);

        if Amount > RefundableAmount then
            Error(
                'Refund amount %1 exceeds the remaining refundable amount of %2.',
                Amount,
                RefundableAmount);

        RefundNo := GetNextRefundNo();

        Refund.Init();
        Refund."Refund No." := RefundNo;
        Refund."Payment No." := PaymentNo;
        Refund."Order No." := Payment."Order No.";
        Refund.Amount := Amount;
        Refund.Status := Refund.Status::Pending;
        Refund."Refund Provider" := RefundProvider;
        Refund."Provider Refund ID" := ProviderRefundID;
        Refund."Provider Reference" := ProviderReference;
        Refund.Reason := Reason;
        Refund."Created At" := CurrentDateTime();
        Refund."Modified At" := CurrentDateTime();

        Refund.Insert(true);

        exit(RefundNo);
    end;

    procedure MarkRefundSuccessful(
        RefundNo: Code[20])
    var
        Refund: Record "SD Payment Refund";
        Payment: Record "SD Payment";
        PaymentManagement: Codeunit "SD Payment Management";
        RefundedAmount: Decimal;
    begin
        if RefundNo = '' then
            Error('Refund number is required.');

        if not Refund.Get(RefundNo) then
            Error(
                'Refund %1 does not exist.',
                RefundNo);

        if Refund.Status <> Refund.Status::Pending then
            Error(
                'Only pending refunds can be marked as successful.');

        if not Payment.Get(Refund."Payment No.") then
            Error(
                'Payment %1 does not exist.',
                Refund."Payment No.");

        RefundedAmount :=
            GetSuccessfulRefundedAmount(
                Refund."Payment No.");

        if (RefundedAmount + Refund.Amount) > Payment.Amount then
            Error(
                'Refund amount exceeds the remaining refundable payment amount.');

        Refund.Status := Refund.Status::Successful;
        Refund."Processed At" := CurrentDateTime();
        Refund."Modified At" := CurrentDateTime();

        Refund.Modify(true);

        UpdatePaymentRefundStatus(
            Payment."Payment No.");

        PaymentManagement.RecalculateOrderPayment(
            Payment."Order No.");
    end;

    procedure MarkRefundFailed(
        RefundNo: Code[20];
        GatewayResponse: Text[250])
    var
        Refund: Record "SD Payment Refund";
    begin
        if RefundNo = '' then
            Error('Refund number is required.');

        if not Refund.Get(RefundNo) then
            Error(
                'Refund %1 does not exist.',
                RefundNo);

        if Refund.Status <> Refund.Status::Pending then
            Error(
                'Only pending refunds can be marked as failed.');

        Refund.Status := Refund.Status::Failed;
        Refund."Gateway Response" := GatewayResponse;
        Refund."Processed At" := CurrentDateTime();
        Refund."Modified At" := CurrentDateTime();

        Refund.Modify(true);
    end;

    procedure CancelRefund(
        RefundNo: Code[20])
    var
        Refund: Record "SD Payment Refund";
    begin
        if RefundNo = '' then
            Error('Refund number is required.');

        if not Refund.Get(RefundNo) then
            Error(
                'Refund %1 does not exist.',
                RefundNo);

        if Refund.Status <> Refund.Status::Pending then
            Error(
                'Only pending refunds can be cancelled.');

        Refund.Status := Refund.Status::Cancelled;
        Refund."Processed At" := CurrentDateTime();
        Refund."Modified At" := CurrentDateTime();

        Refund.Modify(true);
    end;

    local procedure UpdatePaymentRefundStatus(
        PaymentNo: Code[20])
    var
        Payment: Record "SD Payment";
        RefundedAmount: Decimal;
    begin
        if not Payment.Get(PaymentNo) then
            Error(
                'Payment %1 does not exist.',
                PaymentNo);

        RefundedAmount :=
            GetSuccessfulRefundedAmount(
                PaymentNo);

        if RefundedAmount >= Payment.Amount then
            Payment.Status := Payment.Status::Refunded
        else
            if RefundedAmount > 0 then
                Payment.Status := Payment.Status::PartiallyRefunded
            else
                Payment.Status := Payment.Status::Successful;

        Payment."Modified At" := CurrentDateTime();
        Payment.Modify(true);
    end;

    local procedure GetSuccessfulRefundedAmount(
        PaymentNo: Code[20]): Decimal
    var
        Refund: Record "SD Payment Refund";
        TotalRefunded: Decimal;
    begin
        TotalRefunded := 0;

        Refund.Reset();
        Refund.SetRange(
            "Payment No.",
            PaymentNo);
        Refund.SetRange(
            Status,
            Refund.Status::Successful);

        if Refund.FindSet() then
            repeat
                TotalRefunded += Refund.Amount;
            until Refund.Next() = 0;

        exit(TotalRefunded);
    end;

    local procedure RefundProviderIDExists(
        ProviderRefundID: Text[100]): Boolean
    var
        Refund: Record "SD Payment Refund";
    begin
        Refund.SetRange(
            "Provider Refund ID",
            ProviderRefundID);

        exit(
            not Refund.IsEmpty());
    end;

    local procedure GetNextRefundNo(): Code[20]
    var
        Refund: Record "SD Payment Refund";
        NextNumber: Integer;
        ExistingNo: Code[20];
    begin
        if Refund.FindLast() then begin
            ExistingNo := Refund."Refund No.";

            if Evaluate(
                NextNumber,
                CopyStr(ExistingNo, 5))
            then
                NextNumber += 1
            else
                NextNumber := 1;
        end
        else
            NextNumber := 1;

        exit(
            'REF-' +
            Format(
                NextNumber,
                6,
                '<Integer,6><Filler Character,0>'));
    end;
}