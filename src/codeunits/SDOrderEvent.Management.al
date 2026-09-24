codeunit 50114 "SD Order Event Management"
{
    // Caption = 'Serveez Order Event Management';

    procedure CreateEvent(
        OrderNo: Code[20];
        EventType: Option Order,Payment,Refund,Fulfillment,Delivery,Settlement,Support,System;
        EventCode: Code[50];
        Title: Text[100];
        Description: Text[250];
        ReferenceNo: Code[50]): Code[20]
    var
        PortalOrder: Record "SD Portal Order";
        OrderEvent: Record "SD Order Event";
        EventNo: Code[20];
    begin
        if OrderNo = '' then
            Error('Order number is required.');

        if not PortalOrder.Get(OrderNo) then
            Error(
                'Order %1 does not exist.',
                OrderNo);

        if EventCode = '' then
            Error('Event code is required.');

        if Title = '' then
            Error('Event title is required.');

        EventNo := GetNextEventNo();

        OrderEvent.Init();
        OrderEvent."Event No." := EventNo;
        OrderEvent."Order No." := OrderNo;
        OrderEvent."Customer No." := PortalOrder."Customer No.";
        OrderEvent.Type := EventType;
        OrderEvent."Event Code" := EventCode;
        OrderEvent.Title := Title;
        OrderEvent.Description := Description;
        OrderEvent."Reference No." := ReferenceNo;
        OrderEvent."Event Date" := CurrentDateTime();

        OrderEvent.Insert(true);

        exit(EventNo);
    end;

    procedure OrderCreated(
        OrderNo: Code[20])
    var
        EventType: Option Order,Payment,Refund,Fulfillment,Delivery,Settlement,Support,System;
    begin
        EventType := EventType::Order;

        CreateEvent(
            OrderNo,
            EventType,
            'ORDER_CREATED',
            'Order Created',
            'Serveez order was created.',
            OrderNo);
    end;

    procedure OrderSubmitted(
        OrderNo: Code[20])
    var
        EventType: Option Order,Payment,Refund,Fulfillment,Delivery,Settlement,Support,System;
    begin
        EventType := EventType::Order;

        CreateEvent(
            OrderNo,
            EventType,
            'ORDER_SUBMITTED',
            'Order Submitted',
            'Serveez order was submitted successfully.',
            OrderNo);
    end;

    procedure OrderCancelled(
        OrderNo: Code[20])
    var
        EventType: Option Order,Payment,Refund,Fulfillment,Delivery,Settlement,Support,System;
    begin
        EventType := EventType::Order;

        CreateEvent(
            OrderNo,
            EventType,
            'ORDER_CANCELLED',
            'Order Cancelled',
            'Serveez order was cancelled.',
            OrderNo);
    end;

    procedure PaymentSuccessful(
        OrderNo: Code[20];
        PaymentNo: Code[20])
    var
        EventType: Option Order,Payment,Refund,Fulfillment,Delivery,Settlement,Support,System;
    begin
        EventType := EventType::Payment;

        CreateEvent(
            OrderNo,
            EventType,
            'PAYMENT_SUCCESSFUL',
            'Payment Successful',
            'Payment was received successfully.',
            PaymentNo);
    end;

    procedure PaymentRefunded(
        OrderNo: Code[20];
        RefundNo: Code[20])
    var
        EventType: Option Order,Payment,Refund,Fulfillment,Delivery,Settlement,Support,System;
    begin
        EventType := EventType::Refund;

        CreateEvent(
            OrderNo,
            EventType,
            'PAYMENT_REFUNDED',
            'Payment Refunded',
            'A payment refund was processed successfully.',
            RefundNo);
    end;

    procedure FulfillmentCreated(
        OrderNo: Code[20];
        FulfillmentNo: Code[20])
    var
        EventType: Option Order,Payment,Refund,Fulfillment,Delivery,Settlement,Support,System;
    begin
        EventType := EventType::Fulfillment;

        CreateEvent(
            OrderNo,
            EventType,
            'FULFILLMENT_CREATED',
            'Fulfillment Created',
            'Order fulfillment was created.',
            FulfillmentNo);
    end;

    procedure FulfillmentStarted(
        OrderNo: Code[20];
        FulfillmentNo: Code[20])
    var
        EventType: Option Order,Payment,Refund,Fulfillment,Delivery,Settlement,Support,System;
    begin
        EventType := EventType::Fulfillment;

        CreateEvent(
            OrderNo,
            EventType,
            'FULFILLMENT_STARTED',
            'Fulfillment Started',
            'Fulfillment processing has started.',
            FulfillmentNo);
    end;

    procedure FulfillmentReady(
        OrderNo: Code[20];
        FulfillmentNo: Code[20])
    var
        EventType: Option Order,Payment,Refund,Fulfillment,Delivery,Settlement,Support,System;
    begin
        EventType := EventType::Fulfillment;

        CreateEvent(
            OrderNo,
            EventType,
            'FULFILLMENT_READY',
            'Fulfillment Ready',
            'Fulfillment is ready for the next stage.',
            FulfillmentNo);
    end;

    procedure FulfillmentCompleted(
        OrderNo: Code[20];
        FulfillmentNo: Code[20])
    var
        EventType: Option Order,Payment,Refund,Fulfillment,Delivery,Settlement,Support,System;
    begin
        EventType := EventType::Fulfillment;

        CreateEvent(
            OrderNo,
            EventType,
            'FULFILLMENT_COMPLETED',
            'Fulfillment Completed',
            'Fulfillment was completed successfully.',
            FulfillmentNo);
    end;

    procedure DeliveryCreated(
        OrderNo: Code[20];
        DeliveryNo: Code[20])
    var
        EventType: Option Order,Payment,Refund,Fulfillment,Delivery,Settlement,Support,System;
    begin
        EventType := EventType::Delivery;

        CreateEvent(
            OrderNo,
            EventType,
            'DELIVERY_CREATED',
            'Delivery Created',
            'A delivery was created for the order.',
            DeliveryNo);
    end;

    procedure DeliveryOutForDelivery(
        OrderNo: Code[20];
        DeliveryNo: Code[20])
    var
        EventType: Option Order,Payment,Refund,Fulfillment,Delivery,Settlement,Support,System;
    begin
        EventType := EventType::Delivery;

        CreateEvent(
            OrderNo,
            EventType,
            'OUT_FOR_DELIVERY',
            'Out for Delivery',
            'The order is now out for delivery.',
            DeliveryNo);
    end;

    procedure DeliveryDelivered(
        OrderNo: Code[20];
        DeliveryNo: Code[20])
    var
        EventType: Option Order,Payment,Refund,Fulfillment,Delivery,Settlement,Support,System;
    begin
        EventType := EventType::Delivery;

        CreateEvent(
            OrderNo,
            EventType,
            'DELIVERY_COMPLETED',
            'Order Delivered',
            'The order was delivered successfully.',
            DeliveryNo);
    end;

    procedure SettlementCreated(
        OrderNo: Code[20];
        SettlementNo: Code[20])
    var
        EventType: Option Order,Payment,Refund,Fulfillment,Delivery,Settlement,Support,System;
    begin
        EventType := EventType::Settlement;

        CreateEvent(
            OrderNo,
            EventType,
            'SETTLEMENT_CREATED',
            'Settlement Created',
            'Settlement was created for the completed fulfillment.',
            SettlementNo);
    end;

    procedure SettlementPaid(
        OrderNo: Code[20];
        SettlementNo: Code[20])
    var
        EventType: Option Order,Payment,Refund,Fulfillment,Delivery,Settlement,Support,System;
    begin
        EventType := EventType::Settlement;

        CreateEvent(
            OrderNo,
            EventType,
            'SETTLEMENT_PAID',
            'Settlement Paid',
            'Settlement has been fully processed.',
            SettlementNo);
    end;

    procedure SupportCreated(
        OrderNo: Code[20];
        SupportNo: Code[20])
    var
        EventType: Option Order,Payment,Refund,Fulfillment,Delivery,Settlement,Support,System;
    begin
        EventType := EventType::Support;

        CreateEvent(
            OrderNo,
            EventType,
            'SUPPORT_CREATED',
            'Support Request Created',
            'A support request was created for the order.',
            SupportNo);
    end;

    local procedure GetNextEventNo(): Code[20]
    var
        OrderEvent: Record "SD Order Event";
        NextNumber: Integer;
        ExistingNo: Code[20];
    begin
        if OrderEvent.FindLast() then begin
            ExistingNo := OrderEvent."Event No.";

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
            'EVT-' +
            Format(
                NextNumber,
                6,
                '<Integer,6><Filler Character,0>'));
    end;
}