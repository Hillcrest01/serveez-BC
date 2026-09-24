codeunit 50107 "SD Notification Management"
{
    // Caption = 'Serveez Notification Management';

    procedure CreateNotification(
        CustomerNo: Code[20];
        OrderNo: Code[20];
        NotificationType: Option Order,Payment,Fulfillment,Delivery,System;
        Title: Text[100];
        MessageText: Text[250]): Code[20]
    var
        Customer: Record Customer;
        PortalOrder: Record "SD Portal Order";
        Notification: Record "SD Notification";
        NotificationNo: Code[20];
    begin
        if CustomerNo = '' then
            Error('Customer number is required.');

        if not Customer.Get(CustomerNo) then
            Error('Customer %1 does not exist.', CustomerNo);

        if Title = '' then
            Error('Notification title is required.');

        if MessageText = '' then
            Error('Notification message is required.');

        if OrderNo <> '' then begin
            if not PortalOrder.Get(OrderNo) then
                Error('Order %1 does not exist.', OrderNo);

            if PortalOrder."Customer No." <> CustomerNo then
                Error(
                    'Order %1 does not belong to customer %2.',
                    OrderNo,
                    CustomerNo);
        end;

        NotificationNo := GetNextNotificationNo();

        Notification.Init();
        Notification."Notification No." := NotificationNo;
        Notification."Customer No." := CustomerNo;
        Notification."Order No." := OrderNo;
        Notification.Type := NotificationType;
        Notification.Title := Title;
        Notification.Message := MessageText;
        Notification."Is Read" := false;
        Notification."Created At" := CurrentDateTime();

        Notification.Insert(true);

        exit(NotificationNo);
    end;

    procedure MarkAsRead(NotificationNo: Code[20])
    var
        Notification: Record "SD Notification";
    begin
        if NotificationNo = '' then
            Error('Notification number is required.');

        if not Notification.Get(NotificationNo) then
            Error(
                'Notification %1 does not exist.',
                NotificationNo);

        if Notification."Is Read" then
            exit;

        Notification."Is Read" := true;
        Notification."Read At" := CurrentDateTime();

        Notification.Modify(true);
    end;

    procedure MarkAllAsRead(CustomerNo: Code[20])
    var
        Notification: Record "SD Notification";
    begin
        if CustomerNo = '' then
            Error('Customer number is required.');

        Notification.SetRange("Customer No.", CustomerNo);
        Notification.SetRange("Is Read", false);

        if Notification.FindSet() then
            repeat
                Notification."Is Read" := true;
                Notification."Read At" := CurrentDateTime();
                Notification.Modify(true);
            until Notification.Next() = 0;
    end;

    local procedure GetNextNotificationNo(): Code[20]
    var
        Notification: Record "SD Notification";
        NextNumber: Integer;
        ExistingNo: Code[20];
    begin
        if Notification.FindLast() then begin
            ExistingNo := Notification."Notification No.";

            if Evaluate(NextNumber, CopyStr(ExistingNo, 5)) then
                NextNumber += 1
            else
                NextNumber := 1;
        end
        else
            NextNumber := 1;

        exit(
            'NOT-' +
            Format(
                NextNumber,
                6,
                '<Integer,6><Filler Character,0>'));
    end;

    procedure OrderSubmitted(
    OrderNo: Code[20])
    var
        NotificationType: Option Order,Payment,Fulfillment,Delivery,System;
    begin
        NotificationType := NotificationType::Order;

        CreateNotification(
            GetCustomerNo(OrderNo),
            OrderNo,
            NotificationType,
            'Order Submitted',
            'Your order ' + OrderNo + ' has been submitted successfully.');
    end;

    procedure OrderCancelled(
        OrderNo: Code[20])
    var
        NotificationType: Option Order,Payment,Fulfillment,Delivery,System;
    begin
        NotificationType := NotificationType::Order;

        CreateNotification(
            GetCustomerNo(OrderNo),
            OrderNo,
            NotificationType,
            'Order Cancelled',
            'Your order ' + OrderNo + ' has been cancelled.');
    end;

    procedure OrderCompleted(
        OrderNo: Code[20])
    var
        NotificationType: Option Order,Payment,Fulfillment,Delivery,System;
    begin
        NotificationType := NotificationType::Order;

        CreateNotification(
            GetCustomerNo(OrderNo),
            OrderNo,
            NotificationType,
            'Order Completed',
            'Your order ' + OrderNo + ' has been completed successfully.');
    end;

    procedure PaymentSuccessful(
        OrderNo: Code[20];
        PaymentNo: Code[20])
    var
        NotificationType: Option Order,Payment,Fulfillment,Delivery,System;
    begin
        NotificationType := NotificationType::Payment;

        CreateNotification(
            GetCustomerNo(OrderNo),
            OrderNo,
            NotificationType,
            'Payment Successful',
            'Payment ' + PaymentNo + ' was received successfully.');
    end;

    procedure PaymentFailed(
        OrderNo: Code[20];
        PaymentNo: Code[20])
    var
        NotificationType: Option Order,Payment,Fulfillment,Delivery,System;
    begin
        NotificationType := NotificationType::Payment;

        CreateNotification(
            GetCustomerNo(OrderNo),
            OrderNo,
            NotificationType,
            'Payment Failed',
            'Payment ' + PaymentNo + ' was not successful.');
    end;

    procedure PaymentRefunded(
        OrderNo: Code[20];
        RefundNo: Code[20])
    var
        NotificationType: Option Order,Payment,Fulfillment,Delivery,System;
    begin
        NotificationType := NotificationType::Payment;

        CreateNotification(
            GetCustomerNo(OrderNo),
            OrderNo,
            NotificationType,
            'Refund Processed',
            'Refund ' + RefundNo + ' was processed successfully.');
    end;

    procedure FulfillmentReady(
        OrderNo: Code[20];
        FulfillmentNo: Code[20])
    var
        NotificationType: Option Order,Payment,Fulfillment,Delivery,System;
    begin
        NotificationType := NotificationType::Fulfillment;

        CreateNotification(
            GetCustomerNo(OrderNo),
            OrderNo,
            NotificationType,
            'Order Ready',
            'Fulfillment ' + FulfillmentNo + ' is ready.');
    end;

    procedure FulfillmentCompleted(
        OrderNo: Code[20];
        FulfillmentNo: Code[20])
    var
        NotificationType: Option Order,Payment,Fulfillment,Delivery,System;
    begin
        NotificationType := NotificationType::Fulfillment;

        CreateNotification(
            GetCustomerNo(OrderNo),
            OrderNo,
            NotificationType,
            'Fulfillment Completed',
            'Fulfillment ' + FulfillmentNo + ' has been completed.');
    end;

    procedure DeliveryOutForDelivery(
        OrderNo: Code[20];
        DeliveryNo: Code[20])
    var
        NotificationType: Option Order,Payment,Fulfillment,Delivery,System;
    begin
        NotificationType := NotificationType::Delivery;

        CreateNotification(
            GetCustomerNo(OrderNo),
            OrderNo,
            NotificationType,
            'Out for Delivery',
            'Your order ' + OrderNo + ' is now out for delivery.');
    end;

    procedure DeliveryDelivered(
        OrderNo: Code[20];
        DeliveryNo: Code[20])
    var
        NotificationType: Option Order,Payment,Fulfillment,Delivery,System;
    begin
        NotificationType := NotificationType::Delivery;

        CreateNotification(
            GetCustomerNo(OrderNo),
            OrderNo,
            NotificationType,
            'Order Delivered',
            'Your order ' + OrderNo + ' has been delivered.');
    end;

    procedure SettlementPaid(
        OrderNo: Code[20];
        SettlementNo: Code[20])
    var
        NotificationType: Option Order,Payment,Fulfillment,Delivery,System;
    begin
        NotificationType := NotificationType::System;

        CreateNotification(
            GetCustomerNo(OrderNo),
            OrderNo,
            NotificationType,
            'Settlement Completed',
            'Settlement ' + SettlementNo + ' has been fully processed.');
    end;

    procedure SupportCreated(
        OrderNo: Code[20];
        SupportNo: Code[20])
    var
        NotificationType: Option Order,Payment,Fulfillment,Delivery,System;
    begin
        NotificationType := NotificationType::System;

        CreateNotification(
            GetCustomerNo(OrderNo),
            OrderNo,
            NotificationType,
            'Support Request Created',
            'Your support request ' + SupportNo + ' has been created.');
    end;

    local procedure GetCustomerNo(
        OrderNo: Code[20]): Code[20]
    var
        PortalOrder: Record "SD Portal Order";
    begin
        if not PortalOrder.Get(OrderNo) then
            Error(
                'Order %1 does not exist.',
                OrderNo);

        exit(
            PortalOrder."Customer No.");
    end;
}