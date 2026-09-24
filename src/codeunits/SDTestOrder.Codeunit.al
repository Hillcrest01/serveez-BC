codeunit 50102 "SD Test Order"
{
    // Caption = 'Serveez Test Order';

    procedure CreateTestOrder()
    var
        OrderManagement: Codeunit "SD Order Management";
        OrderNo: Code[20];
    begin
        OrderNo := OrderManagement.CreateOrder(
            '01445544',
            'EGERTON');

        Message(
            'Test order created successfully.\Order No.: %1',
            OrderNo);
    end;

    procedure AddTestServiceLine()
    var
        OrderManagement: Codeunit "SD Order Management";
    begin
        OrderManagement.AddServiceLine(
            'ORD-000003',
            'PRINTING',
            2,
            'Test black and white printing');

        Message('Service line added successfully.');
    end;

    procedure AddTestProductLine()
    var
        OrderManagement: Codeunit "SD Order Management";
    begin
        OrderManagement.AddProductLine(
            'ORD-000003',
            'MILK-500',
            3,
            'Test milk purchase');

        Message('Product line added successfully.');
    end;

    procedure SubmitTestOrder()
    var
        OrderManagement: Codeunit "SD Order Management";
    begin
        OrderManagement.SubmitOrder('ORD-000003');

        Message('Order submitted successfully.');
    end;

    procedure CreateTestDelivery()
    var
        DeliveryManagement: Codeunit "SD Delivery Management";
        DeliveryNo: Code[20];
    begin
        // DeliveryNo := DeliveryManagement.CreateDelivery(
        //     'ORD-000003',
        //     'FUL-000006',
        //     'E-Cyber Centre',
        //     'Tatton, Mombasa, Room 23',
        //     0);

        Message(
            'Delivery created successfully.\Delivery No.: %1',
            DeliveryNo);
    end;

    procedure AssignTestDelivery()
    var
        DeliveryManagement: Codeunit "SD Delivery Management";
    begin
        DeliveryManagement.AssignDelivery(
            'DEL-000003',
            'DP-001');

        Message('Delivery assigned successfully.');
    end;


    procedure AcceptDelivery()
    var
        DeliveryManagement: Codeunit "SD Delivery Management";
    begin
        DeliveryManagement.AcceptDelivery(
            'DEL-000003');

        Message('Delivery accepted successfully.');
    end;

    procedure StartDeliveryToPickup()
    var
        DeliveryManagement: Codeunit "SD Delivery Management";
    begin
        DeliveryManagement.StartDeliveryToPickup(
            'DEL-000003');

        Message('Delivery is now en route to pickup.');
    end;

    procedure StartTestDeliveryToPickup()
    var
        DeliveryManagement: Codeunit "SD Delivery Management";
    begin
        DeliveryManagement.StartDeliveryToPickup('DEL-000003');

        Message('Delivery is now en route to pickup.');
    end;

    procedure ArriveTestDeliveryAtPickup()
    var
        DeliveryManagement: Codeunit "SD Delivery Management";
    begin
        DeliveryManagement.ArrivedAtPickup('DEL-000003');

        Message('Delivery has arrived at pickup.');
    end;

    procedure PickUpTestDelivery()
    var
        DeliveryManagement: Codeunit "SD Delivery Management";
    begin
        DeliveryManagement.MarkPickedUp('DEL-000003');

        Message('Delivery has been picked up successfully.');
    end;

    procedure StartTestDeliveryToDestination()
    var
        DeliveryManagement: Codeunit "SD Delivery Management";
    begin
        DeliveryManagement.StartDeliveryToDestination('DEL-000003');

        Message('Delivery is now en route to destination.');
    end;

    procedure ArriveTestDeliveryAtDestination()
    var
        DeliveryManagement: Codeunit "SD Delivery Management";
    begin
        DeliveryManagement.ArriveAtDestination('DEL-000003');

        Message('Delivery has arrived at destination.');
    end;

    procedure DeliverTestDelivery()
    var
        DeliveryManagement: Codeunit "SD Delivery Management";
    begin
        DeliveryManagement.MarkDelivered(
            'DEL-000003',
            'Received by customer - Peter');

        Message('Delivery marked as delivered successfully.');
    end;

    procedure CompleteTestDelivery()
    var
        DeliveryManagement: Codeunit "SD Delivery Management";
    begin
        DeliveryManagement.CompleteDelivery('DEL-000003');

        Message('Delivery completed successfully.');
    end;

    procedure CreateTestPayment()
    var
        PaymentManagement: Codeunit "SD Payment Management";
        PaymentProvider: Option "M-Pesa",Paystack,Other;
        PaymentNo: Code[20];
    begin
        PaymentProvider := PaymentProvider::"M-Pesa";

        PaymentNo := PaymentManagement.CreatePayment(
            'ORD-000002',
            PaymentProvider,
            100,
            'KES',
            'TEST-TXN-001',
            'TEST-REF-001');

        Message(
            'Payment created successfully.\Payment No.: %1',
            PaymentNo);
    end;

    procedure CompleteTestPayment()
    var
        PaymentManagement: Codeunit "SD Payment Management";
    begin
        PaymentManagement.MarkPaymentSuccessful('PAY-000001');

        Message('Payment marked as successful.');
    end;

    procedure CreateSecondTestPayment()
    var
        PaymentManagement: Codeunit "SD Payment Management";
        PaymentProvider: Option "M-Pesa",Paystack,Other;
        PaymentNo: Code[20];
    begin
        PaymentProvider := PaymentProvider::"M-Pesa";

        PaymentNo := PaymentManagement.CreatePayment(
            'ORD-000002',
            PaymentProvider,
            350,
            'KES',
            'TEST-TXN-002',
            'TEST-REF-002');

        Message(
            'Second payment created successfully.\Payment No.: %1',
            PaymentNo);
    end;

    procedure CompleteSecondTestPayment()
    var
        PaymentManagement: Codeunit "SD Payment Management";
    begin
        PaymentManagement.MarkPaymentSuccessful('PAY-000002');

        Message('Second payment marked as successful.');
    end;

    procedure CreateTestBCSalesOrder()
    var
        BCSalesOrderManagement: Codeunit "SD BC Sales Order Management";
        SalesOrderNo: Code[20];
    begin
        SalesOrderNo :=
            BCSalesOrderManagement.CreateSalesOrder(
                'ORD-000002');

        Message(
            'BC Sales Order created successfully.\Sales Order No.: %1',
            SalesOrderNo);
    end;

    procedure CreateTestPortalAccount()
    var
        AuthenticationManagement: Codeunit "SD Authentication Management";
        UserID: Code[20];
    begin
        UserID := AuthenticationManagement.CreateAccount(
            'testuser@serveez.test',
            '0700000001',
            '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC2cK4x3zXyX7dGqGm2S',
            'Serveez Test User',
            'EGERTON',
            true,
            'University Hostels',
            'H24',
            'MAIN-GATE');

        Message(
            'Portal account created successfully.\User ID: %1',
            UserID);
    end;

    procedure VerifyTestPortalAccount()
    var
        AuthenticationManagement: Codeunit "SD Authentication Management";
    begin
        AuthenticationManagement.VerifyEmail(
            'USR-000002',
            'DF63132544A14B5E8C64956814552AAD');

        Message('Email verified successfully.');
    end;

    procedure CreateTestPartialRefund()
    var
        RefundManagement: Codeunit "SD Payment Refund Management";
        RefundProvider: Option "M-Pesa",Paystack,Other;
        RefundNo: Code[20];
    begin
        RefundProvider := RefundProvider::"M-Pesa";

        RefundNo := RefundManagement.CreateRefund(
            'PAY-000001',
            RefundProvider,
            50,
            'Customer cancellation of part of the order',
            'TEST-REFUND-001',
            'TEST-REF-001');

        Message(
            'Partial refund created successfully.\Refund No.: %1',
            RefundNo);
    end;

    procedure CompleteTestPartialRefund()
    var
        RefundManagement: Codeunit "SD Payment Refund Management";
    begin
        RefundManagement.MarkRefundSuccessful(
            'REF-000001');

        Message('Partial refund marked as successful.');
    end;

    procedure CreateRemainingRefund()
    var
        RefundManagement: Codeunit "SD Payment Refund Management";
        RefundProvider: Option "M-Pesa",Paystack,Other;
        RefundNo: Code[20];
    begin
        RefundProvider := RefundProvider::"M-Pesa";

        RefundNo := RefundManagement.CreateRefund(
            'PAY-000001',
            RefundProvider,
            50,
            'Full remaining refund',
            'TEST-REFUND-003',
            'TEST-REF-003');

        Message(
            'Remaining refund created successfully.\Refund No.: %1',
            RefundNo);
    end;

    procedure CompleteRemainingRefund()
    var
        RefundManagement: Codeunit "SD Payment Refund Management";
    begin
        RefundManagement.MarkRefundSuccessful(
            'REF-000003');

        Message('Remaining refund marked as successful.');
    end;

    procedure TestOverRefund()
    var
        RefundManagement: Codeunit "SD Payment Refund Management";
        RefundProvider: Option "M-Pesa",Paystack,Other;
    begin
        RefundProvider := RefundProvider::"M-Pesa";

        RefundManagement.CreateRefund(
            'PAY-000001',
            RefundProvider,
            1,
            'Over refund test',
            'TEST-REFUND-004',
            'TEST-REF-004');

        Message('Unexpected: over-refund was accepted.');
    end;

    procedure TestPricing()
    var
        PricingMgt: Codeunit "SD Delivery Pricing Management";
    begin
        PricingMgt.CreatePricing('PRINTING', 'NJOKS', 20);
        Message('pricing set was successful');
    end;

}