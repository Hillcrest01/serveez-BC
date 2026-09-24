codeunit 50131 "SD Order Management"
{
    // Caption = 'Serveez Order Management';

    procedure CreateOrder(CustomerNo: Code[20]; CampusCode: Code[20]): Code[20]
    var
        PortalOrder: Record "SD Portal Order";
        Customer: Record Customer;
        Setup: Record "SD Setups Table";
        RecPickupPoint: Record "SD Pickup Point";
        CustomerProfile: Record "SD Customer Profile";
        OrderLocation: Record "SD Order Location";
        OrderNo: Code[20];
    begin
        if CustomerNo = '' then
            Error('Customer number is required.');

        if not Customer.Get(CustomerNo) then
            Error('Customer %1 does not exist.', CustomerNo);

        if CampusCode = '' then
            Error('Campus code is required.');

        if not Setup.Get('SETUP') then
            Error('Serveez Setup has not been configured.');

        if not RecCampusExists(CampusCode) then
            Error('Campus %1 does not exist or is inactive.', CampusCode);

        if not CustomerProfile.Get(CustomerNo) then
            Error('Customer profile for %1 has not been configured.', CustomerNo);

        OrderNo := GetNextOrderNo();

        PortalOrder.Init();
        PortalOrder."Order No." := OrderNo;
        PortalOrder."Customer No." := CustomerNo;
        PortalOrder."Campus Code" := CampusCode;
        PortalOrder."Order Date" := Today();
        PortalOrder."Order Time" := Time();
        PortalOrder."Order Status" := PortalOrder."Order Status"::Draft;
        PortalOrder."Payment Status" := PortalOrder."Payment Status"::Unpaid;
        PortalOrder."Fulfillment Status" := PortalOrder."Fulfillment Status"::NotStarted;
        PortalOrder."Created At" := CurrentDateTime();
        PortalOrder."Modified At" := CurrentDateTime();
        PortalOrder."Subtotal" := 0;
        PortalOrder."Delivery Charge" := 0;
        PortalOrder."Total Amount" := 0;
        PortalOrder."Amount Paid" := 0;
        PortalOrder."Amount Due" := 0;

        PortalOrder.Insert(true);

        OrderLocation.Init();
        OrderLocation."Order No." := OrderNo;
        OrderLocation."Campus Code" := CustomerProfile."Campus Code";
        OrderLocation.Resident := CustomerProfile.Resident;
        OrderLocation.Estate := CustomerProfile.Estate;
        OrderLocation.Room := CustomerProfile.Room;
        OrderLocation."Pickup Point Code" := CustomerProfile."Preferred Pickup Point";

        if CustomerProfile."Preferred Pickup Point" <> '' then begin
            if RecPickupPoint.Get(CustomerProfile."Preferred Pickup Point") then
                OrderLocation."Pickup Point Name" := RecPickupPoint.Name;
        end;

        if CustomerProfile.Resident then
            OrderLocation."Delivery Address" :=
                CustomerProfile.Estate + ', Room ' + CustomerProfile.Room
        else
            OrderLocation."Delivery Address" :=
                CustomerProfile.Estate + ', Room ' + CustomerProfile.Room;

        OrderLocation."Created At" := CurrentDateTime();

        OrderLocation.Insert(true);

        exit(OrderNo);
    end;

    procedure AddServiceLine(
    OrderNo: Code[20];
    ServiceCode: Code[20];
    Quantity: Decimal;
    CustomerNotes: Text[250])
    var
        PortalOrder: Record "SD Portal Order";
        OrderLine: Record "SD Portal Order Line";
        Service: Record "SD Service";
        LineNo: Integer;
    begin
        if not PortalOrder.Get(OrderNo) then
            Error('Order %1 does not exist.', OrderNo);

        if PortalOrder."Order Status" <> PortalOrder."Order Status"::Draft then
            Error('Order %1 is no longer in Draft status.', OrderNo);

        if ServiceCode = '' then
            Error('Service code is required.');

        if not Service.Get(ServiceCode) then
            Error('Service %1 does not exist.', ServiceCode);

        if not Service.Active then
            Error('Service %1 is not active.', ServiceCode);

        if Quantity <= 0 then
            Error('Quantity must be greater than zero.');

        LineNo := GetNextLineNo(OrderNo);

        OrderLine.Init();
        OrderLine."Order No." := OrderNo;
        OrderLine."Line No." := LineNo;
        OrderLine."Line Type" := OrderLine."Line Type"::Service;
        OrderLine."Service Code" := ServiceCode;
        OrderLine."Item No." := '';
        OrderLine.Description := Service.Name;
        OrderLine.Quantity := Quantity;
        OrderLine."Unit Price" := Service.Price;
        OrderLine.Amount := Quantity * Service.Price;
        OrderLine."Customer Notes" := CustomerNotes;

        OrderLine.Insert(true);

        CalculateOrderTotals(OrderNo);
    end;

    procedure AddProductLine(
        OrderNo: Code[20];
        ItemNo: Code[20];
        Quantity: Decimal;
        CustomerNotes: Text[250])
    var
        PortalOrder: Record "SD Portal Order";
        OrderLine: Record "SD Portal Order Line";
        Product: Record "SD Product";
        Item: Record Item;
        LineNo: Integer;
    begin
        if not PortalOrder.Get(OrderNo) then
            Error('Order %1 does not exist.', OrderNo);

        if PortalOrder."Order Status" <> PortalOrder."Order Status"::Draft then
            Error('Order %1 is no longer in Draft status.', OrderNo);

        if ItemNo = '' then
            Error('Item number is required.');

        if not Item.Get(ItemNo) then
            Error('Item %1 does not exist.', ItemNo);

        if not Product.Get(ItemNo) then
            Error('Item %1 is not configured as a Serveez product.', ItemNo);

        if not Product.Active then
            Error('Product %1 is not active.', ItemNo);

        if Quantity <= 0 then
            Error('Quantity must be greater than zero.');

        LineNo := GetNextLineNo(OrderNo);

        OrderLine.Init();
        OrderLine."Order No." := OrderNo;
        OrderLine."Line No." := LineNo;
        OrderLine."Line Type" := OrderLine."Line Type"::Product;
        OrderLine."Service Code" := '';
        OrderLine."Item No." := ItemNo;
        OrderLine.Description := Product."Display Name";

        if Product."Display Name" = '' then
            OrderLine.Description := Item.Description;

        OrderLine.Quantity := Quantity;

        OrderLine."Unit Price" := GetProductPrice(Item);

        OrderLine.Amount := Quantity * OrderLine."Unit Price";
        OrderLine."Customer Notes" := CustomerNotes;

        OrderLine.Insert(true);

        CalculateOrderTotals(OrderNo);
    end;

    procedure CalculateOrderTotals(OrderNo: Code[20])
    var
        PortalOrder: Record "SD Portal Order";
        OrderLine: Record "SD Portal Order Line";
        Subtotal: Decimal;
        DeliveryCharge: Decimal;
    begin
        if not PortalOrder.Get(OrderNo) then
            Error('Order %1 does not exist.', OrderNo);

        Subtotal := 0;

        OrderLine.Reset();
        OrderLine.SetRange("Order No.", OrderNo);

        if OrderLine.FindSet() then
            repeat
                Subtotal += OrderLine.Amount;
            until OrderLine.Next() = 0;

        DeliveryCharge := CalculateDeliveryCharge(OrderNo);

        PortalOrder.Subtotal := Subtotal;
        PortalOrder."Delivery Charge" := DeliveryCharge;
        PortalOrder."Total Amount" := Subtotal + DeliveryCharge;
        PortalOrder."Amount Due" := PortalOrder."Total Amount" - PortalOrder."Amount Paid";
        PortalOrder."Modified At" := CurrentDateTime();

        PortalOrder.Modify(true);
    end;

    // procedure SubmitOrder(OrderNo: Code[20])
    // var
    //     PortalOrder: Record "SD Portal Order";
    //     OrderLine: Record "SD Portal Order Line";
    //     FulfillmentManagement: Codeunit "SD Fulfillment Management";
    // begin
    //     if not PortalOrder.Get(OrderNo) then
    //         Error('Order %1 does not exist.', OrderNo);

    //     if PortalOrder."Order Status" <> PortalOrder."Order Status"::Draft then
    //         Error('Only Draft orders can be submitted.');

    //     OrderLine.Reset();
    //     OrderLine.SetRange("Order No.", OrderNo);

    //     if OrderLine.IsEmpty() then
    //         Error(
    //             'Order %1 cannot be submitted without at least one order line.',
    //             OrderNo);

    //     CalculateOrderTotals(OrderNo);

    //     PortalOrder.Get(OrderNo);
    //     PortalOrder."Order Status" := PortalOrder."Order Status"::Submitted;
    //     PortalOrder."Fulfillment Status" :=
    //         PortalOrder."Fulfillment Status"::NotStarted;
    //     PortalOrder."Modified At" := CurrentDateTime();

    //     PortalOrder.Modify(true);

    //     OrderLine.Reset();
    //     OrderLine.SetRange("Order No.", OrderNo);

    //     if OrderLine.FindSet() then
    //         repeat
    //             FulfillmentManagement.CreateFulfillment(
    //                 OrderLine."Order No.",
    //                 OrderLine."Line No.");
    //         until OrderLine.Next() = 0;
    // end;
    procedure SubmitOrder(OrderNo: Code[20])
    var
        PortalOrder: Record "SD Portal Order";
        OrderLine: Record "SD Portal Order Line";
        FulfillmentManagement: Codeunit "SD Fulfillment Management";
        BCSalesOrderManagement: Codeunit "SD BC Sales Order Management";
        BCSalesOrderNo: Code[20];
    begin
        if not PortalOrder.Get(OrderNo) then
            Error('Order %1 does not exist.', OrderNo);

        if PortalOrder."Order Status" <> PortalOrder."Order Status"::Draft then
            Error('Only Draft orders can be submitted.');

        OrderLine.Reset();
        OrderLine.SetRange("Order No.", OrderNo);

        if OrderLine.IsEmpty() then
            Error(
                'Order %1 cannot be submitted without at least one order line.',
                OrderNo);

        CalculateOrderTotals(OrderNo);

        PortalOrder.Get(OrderNo);
        PortalOrder."Order Status" := PortalOrder."Order Status"::Submitted;
        PortalOrder."Fulfillment Status" :=
            PortalOrder."Fulfillment Status"::NotStarted;
        PortalOrder."Modified At" := CurrentDateTime();

        PortalOrder.Modify(true);

        BCSalesOrderNo :=
            BCSalesOrderManagement.CreateSalesOrder(OrderNo);

        PortalOrder.Get(OrderNo);
        PortalOrder."BC Sales Order No." := BCSalesOrderNo;
        PortalOrder."Modified At" := CurrentDateTime();

        PortalOrder.Modify(true);

        OrderLine.Reset();
        OrderLine.SetRange("Order No.", OrderNo);

        if OrderLine.FindSet() then
            repeat
                FulfillmentManagement.CreateFulfillment(
                    OrderLine."Order No.",
                    OrderLine."Line No.");
            until OrderLine.Next() = 0;
    end;

    local procedure GetNextOrderNo(): Code[20]
    var
        PortalOrder: Record "SD Portal Order";
        NextNumber: Integer;
        ExistingNo: Code[20];
    begin
        if PortalOrder.FindLast() then begin
            ExistingNo := PortalOrder."Order No.";

            if Evaluate(NextNumber, CopyStr(ExistingNo, 5)) then
                NextNumber += 1
            else
                NextNumber := 1;
        end
        else
            NextNumber := 1;

        exit('ORD-' + Format(NextNumber, 6, '<Integer,6><Filler Character,0>'));
    end;

    local procedure GetNextLineNo(OrderNo: Code[20]): Integer
    var
        OrderLine: Record "SD Portal Order Line";
    begin
        OrderLine.SetRange("Order No.", OrderNo);

        if OrderLine.FindLast() then
            exit(OrderLine."Line No." + 10000);

        exit(10000);
    end;

    local procedure RecCampusExists(CampusCode: Code[20]): Boolean
    var
        Campus: Record "Serveez Campus";
    begin
        if not Campus.Get(CampusCode) then
            exit(false);

        exit(Campus.Active);
    end;

    local procedure GetProductPrice(Item: Record Item): Decimal
    begin
        exit(Item."Unit Price");
    end;

    local procedure CalculateDeliveryCharge(OrderNo: Code[20]): Decimal
    begin
        // Delivery pricing will be implemented in the
        // delivery/pricing module.
        exit(0);
    end;

    procedure CancelOrder(OrderNo: Code[20])
    var
        PortalOrder: Record "SD Portal Order";
        OrderLine: Record "SD Portal Order Line";
        Fulfillment: Record "SD Order Fulfillment";
        Payment: Record "SD Payment";
        FulfillmentManagement: Codeunit "SD Fulfillment Management";
        HasSuccessfulPayment: Boolean;
    begin
        if OrderNo = '' then
            Error('Order number is required.');

        if not PortalOrder.Get(OrderNo) then
            Error(
                'Order %1 does not exist.',
                OrderNo);

        if PortalOrder."Order Status" = PortalOrder."Order Status"::Completed then
            Error(
                'Completed order %1 cannot be cancelled.',
                OrderNo);

        if PortalOrder."Order Status" = PortalOrder."Order Status"::Cancelled then
            Error(
                'Order %1 is already cancelled.',
                OrderNo);

        if PortalOrder."Order Status" = PortalOrder."Order Status"::InProgress then
            Error(
                'Order %1 cannot be cancelled because processing has started.',
                OrderNo);

        HasSuccessfulPayment := false;

        Payment.Reset();
        Payment.SetRange(
            "Order No.",
            OrderNo);
        Payment.SetRange(
            Status,
            Payment.Status::Successful);

        HasSuccessfulPayment := not Payment.IsEmpty();

        if HasSuccessfulPayment then
            Error(
                'Order %1 cannot be cancelled because it has a successful payment. Process the refund first.',
                OrderNo);

        Fulfillment.Reset();
        Fulfillment.SetRange(
            "Order No.",
            OrderNo);

        if Fulfillment.FindSet() then
            repeat
                case Fulfillment.Status of
                    Fulfillment.Status::InProgress,
                    Fulfillment.Status::Ready,
                    Fulfillment.Status::OutForDelivery,
                    Fulfillment.Status::Delivered,
                    Fulfillment.Status::Completed:
                        Error(
                            'Order %1 cannot be cancelled because fulfillment %2 has progressed beyond the cancellation stage.',
                            OrderNo,
                            Fulfillment."Fulfillment No.");

                    Fulfillment.Status::NotStarted,
                    Fulfillment.Status::Assigned,
                    Fulfillment.Status::Accepted:
                        FulfillmentManagement.CancelFulfillment(
                            Fulfillment."Fulfillment No.");

                    Fulfillment.Status::Cancelled:
                        begin
                        end;
                end;
            until Fulfillment.Next() = 0;

        PortalOrder."Order Status" :=
            PortalOrder."Order Status"::Cancelled;

        PortalOrder."Fulfillment Status" :=
            PortalOrder."Fulfillment Status"::NotStarted;

        PortalOrder."Modified At" := CurrentDateTime();

        PortalOrder.Modify(true);
    end;
}