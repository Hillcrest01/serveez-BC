codeunit 50103 "SD Delivery Management"
{
    // Caption = 'Serveez Delivery Management';

    procedure CreateDelivery(
        OrderNo: Code[20];
        FulfillmentNo: Code[20];
        PickupPointCode: Code[20];
        PickupLocation: Text[250];
        Destination: Text[250]): Code[20]
    var
        PortalOrder: Record "SD Portal Order";
        Fulfillment: Record "SD Order Fulfillment";
        PickupPoint: Record "SD Pickup Point";
        Delivery: Record "SD Delivery";
        PricingManagement: Codeunit "SD Delivery Pricing Management";
        DeliveryNo: Code[20];
        DeliveryCharge: Decimal;
    begin
        if OrderNo = '' then
            Error('Order number is required.');

        if not PortalOrder.Get(OrderNo) then
            Error(
                'Order %1 does not exist.',
                OrderNo);

        if FulfillmentNo = '' then
            Error('Fulfillment number is required.');

        if not Fulfillment.Get(FulfillmentNo) then
            Error(
                'Fulfillment %1 does not exist.',
                FulfillmentNo);

        if Fulfillment."Order No." <> OrderNo then
            Error(
                'Fulfillment %1 does not belong to order %2.',
                FulfillmentNo,
                OrderNo);

        if Fulfillment.Status <> Fulfillment.Status::Ready then
            Error(
                'Only ready fulfillment can have a delivery created.');

        if Fulfillment.Status = Fulfillment.Status::Cancelled then
            Error(
                'Fulfillment %1 is cancelled.',
                FulfillmentNo);

        if Fulfillment."Service Code" = '' then
            Error(
                'Fulfillment %1 does not have a service code.',
                FulfillmentNo);

        if PickupPointCode = '' then
            Error('Pickup point code is required.');

        if not PickupPoint.Get(PickupPointCode) then
            Error(
                'Pickup point %1 does not exist.',
                PickupPointCode);

        if not PickupPoint.Active then
            Error(
                'Pickup point %1 is not active.',
                PickupPointCode);

        if PickupLocation = '' then
            Error('Pickup location is required.');

        if Destination = '' then
            Error('Destination is required.');

        if DeliveryExists(FulfillmentNo) then
            Error(
                'A delivery already exists for fulfillment %1.',
                FulfillmentNo);

        DeliveryCharge :=
            PricingManagement.CalculateDeliveryCharge(
                Fulfillment."Service Code",
                PickupPointCode);

        DeliveryNo := GetNextDeliveryNo();

        Delivery.Init();
        Delivery."Delivery No." := DeliveryNo;
        Delivery."Order No." := OrderNo;
        Delivery."Fulfillment No." := FulfillmentNo;
        Delivery."Pickup Point Code" := PickupPointCode;
        Delivery."Pickup Location" := PickupLocation;
        Delivery.Destination := Destination;
        Delivery."Delivery Charge" := DeliveryCharge;
        Delivery.Status := Delivery.Status::Created;
        Delivery."Created At" := CurrentDateTime();
        Delivery."Modified At" := CurrentDateTime();

        Delivery.Insert(true);

        exit(DeliveryNo);
    end;

    local procedure DeliveryExists(
        FulfillmentNo: Code[20]): Boolean
    var
        Delivery: Record "SD Delivery";
    begin
        Delivery.SetRange(
            "Fulfillment No.",
            FulfillmentNo);

        exit(
            not Delivery.IsEmpty());
    end;

    local procedure GetNextDeliveryNo(): Code[20]
    var
        Delivery: Record "SD Delivery";
        NextNumber: Integer;
        ExistingNo: Code[20];
    begin
        if Delivery.FindLast() then begin
            ExistingNo := Delivery."Delivery No.";

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
            'DEL-' +
            Format(
                NextNumber,
                6,
                '<Integer,6><Filler Character,0>'));
    end;

    procedure AssignDelivery(
        DeliveryNo: Code[20];
        DeliveryPersonNo: Code[20])
    var
        Delivery: Record "SD Delivery";
        DeliveryPerson: Record "SD Delivery Person";
    begin
        if DeliveryNo = '' then
            Error('Delivery number is required.');

        if not Delivery.Get(DeliveryNo) then
            Error(
                'Delivery %1 does not exist.',
                DeliveryNo);

        if Delivery.Status <> Delivery.Status::Created then
            Error(
                'Only newly created deliveries can be assigned.');

        if DeliveryPersonNo = '' then
            Error('Delivery person is required.');

        if not DeliveryPerson.Get(DeliveryPersonNo) then
            Error(
                'Delivery person %1 does not exist.',
                DeliveryPersonNo);

        if not DeliveryPerson.Active then
            Error(
                'Delivery person %1 is not active.',
                DeliveryPersonNo);

        if not DeliveryPerson.Available then
            Error(
                'Delivery person %1 is not available.',
                DeliveryPersonNo);

        Delivery."Delivery Person No." := DeliveryPersonNo;
        Delivery.Status := Delivery.Status::Assigned;
        Delivery."Assigned At" := CurrentDateTime();
        Delivery."Modified At" := CurrentDateTime();

        Delivery.Modify(true);

        DeliveryPerson.Available := false;
        DeliveryPerson."Modified At" := CurrentDateTime();

        DeliveryPerson.Modify(true);
    end;

    procedure AcceptDelivery(
        DeliveryNo: Code[20])
    var
        Delivery: Record "SD Delivery";
        DeliveryPerson: Record "SD Delivery Person";
    begin
        if DeliveryNo = '' then
            Error('Delivery number is required.');

        if not Delivery.Get(DeliveryNo) then
            Error(
                'Delivery %1 does not exist.',
                DeliveryNo);

        if Delivery.Status <> Delivery.Status::Assigned then
            Error(
                'Only assigned deliveries can be accepted.');

        if Delivery."Delivery Person No." = '' then
            Error(
                'Delivery %1 has no delivery person assigned.',
                DeliveryNo);

        if not DeliveryPerson.Get(
            Delivery."Delivery Person No.")
        then
            Error(
                'Delivery person %1 does not exist.',
                Delivery."Delivery Person No.");

        if not DeliveryPerson.Active then
            Error(
                'Delivery person %1 is not active.',
                Delivery."Delivery Person No.");

        Delivery.Status := Delivery.Status::Accepted;
        Delivery."Accepted At" := CurrentDateTime();
        Delivery."Modified At" := CurrentDateTime();

        Delivery.Modify(true);
    end;

    procedure StartDeliveryToPickup(
        DeliveryNo: Code[20])
    var
        Delivery: Record "SD Delivery";
    begin
        if DeliveryNo = '' then
            Error('Delivery number is required.');

        if not Delivery.Get(DeliveryNo) then
            Error(
                'Delivery %1 does not exist.',
                DeliveryNo);

        if Delivery.Status <> Delivery.Status::Accepted then
            Error(
                'Only accepted deliveries can start travelling to pickup.');

        Delivery.Status := Delivery.Status::EnRouteToPickup;
        Delivery."Modified At" := CurrentDateTime();

        Delivery.Modify(true);
    end;

    procedure ArrivedAtPickup(
        DeliveryNo: Code[20])
    var
        Delivery: Record "SD Delivery";
    begin
        if DeliveryNo = '' then
            Error('Delivery number is required.');

        if not Delivery.Get(DeliveryNo) then
            Error(
                'Delivery %1 does not exist.',
                DeliveryNo);

        if Delivery.Status <> Delivery.Status::EnRouteToPickup then
            Error(
                'Only deliveries en route to pickup can arrive at pickup.');

        Delivery.Status := Delivery.Status::ArrivedAtPickup;
        Delivery."Modified At" := CurrentDateTime();

        Delivery.Modify(true);
    end;

    procedure MarkPickedUp(
        DeliveryNo: Code[20])
    var
        Delivery: Record "SD Delivery";
    begin
        if DeliveryNo = '' then
            Error('Delivery number is required.');

        if not Delivery.Get(DeliveryNo) then
            Error(
                'Delivery %1 does not exist.',
                DeliveryNo);

        if Delivery.Status <> Delivery.Status::ArrivedAtPickup then
            Error(
                'Only deliveries that have arrived at pickup can be marked as picked up.');

        Delivery.Status := Delivery.Status::PickedUp;
        Delivery."Picked Up At" := CurrentDateTime();
        Delivery."Modified At" := CurrentDateTime();

        Delivery.Modify(true);
    end;

    procedure StartDeliveryToDestination(
        DeliveryNo: Code[20])
    var
        Delivery: Record "SD Delivery";
        FulfillmentManagement: Codeunit "SD Fulfillment Management";
    begin
        if DeliveryNo = '' then
            Error('Delivery number is required.');

        if not Delivery.Get(DeliveryNo) then
            Error(
                'Delivery %1 does not exist.',
                DeliveryNo);

        if Delivery.Status <> Delivery.Status::PickedUp then
            Error(
                'Only picked up deliveries can travel to the destination.');

        FulfillmentManagement.MarkOutForDelivery(
            Delivery."Fulfillment No.");

        Delivery.Status := Delivery.Status::EnRouteToDestination;
        Delivery."Modified At" := CurrentDateTime();

        Delivery.Modify(true);
    end;

    procedure ArriveAtDestination(
        DeliveryNo: Code[20])
    var
        Delivery: Record "SD Delivery";
    begin
        if DeliveryNo = '' then
            Error('Delivery number is required.');

        if not Delivery.Get(DeliveryNo) then
            Error(
                'Delivery %1 does not exist.',
                DeliveryNo);

        if Delivery.Status <> Delivery.Status::EnRouteToDestination then
            Error(
                'Only deliveries en route to destination can arrive at destination.');

        Delivery.Status := Delivery.Status::ArrivedAtDestination;
        Delivery."Modified At" := CurrentDateTime();

        Delivery.Modify(true);
    end;

    procedure MarkDelivered(
        DeliveryNo: Code[20];
        ProofOfDelivery: Text[250])
    var
        Delivery: Record "SD Delivery";
        FulfillmentManagement: Codeunit "SD Fulfillment Management";
    begin
        if DeliveryNo = '' then
            Error('Delivery number is required.');

        if not Delivery.Get(DeliveryNo) then
            Error(
                'Delivery %1 does not exist.',
                DeliveryNo);

        if Delivery.Status <> Delivery.Status::ArrivedAtDestination then
            Error(
                'Only deliveries that have arrived at destination can be marked as delivered.');

        if ProofOfDelivery = '' then
            Error('Proof of delivery is required.');

        FulfillmentManagement.MarkDelivered(
            Delivery."Fulfillment No.");

        Delivery.Status := Delivery.Status::Delivered;
        Delivery."Proof Of Delivery" := ProofOfDelivery;
        Delivery."Delivered At" := CurrentDateTime();
        Delivery."Modified At" := CurrentDateTime();

        Delivery.Modify(true);
    end;

    // procedure CompleteDelivery(
    //     DeliveryNo: Code[20])
    // var
    //     Delivery: Record "SD Delivery";
    //     DeliveryPerson: Record "SD Delivery Person";
    //     FulfillmentManagement: Codeunit "SD Fulfillment Management";
    // begin
    //     if DeliveryNo = '' then
    //         Error('Delivery number is required.');

    //     if not Delivery.Get(DeliveryNo) then
    //         Error(
    //             'Delivery %1 does not exist.',
    //             DeliveryNo);

    //     if Delivery.Status <> Delivery.Status::Delivered then
    //         Error(
    //             'Only delivered deliveries can be completed.');

    //     if Delivery."Delivery Person No." = '' then
    //         Error(
    //             'Delivery %1 has no delivery person assigned.',
    //             DeliveryNo);

    //     if not DeliveryPerson.Get(
    //         Delivery."Delivery Person No.")
    //     then
    //         Error(
    //             'Delivery person %1 does not exist.',
    //             Delivery."Delivery Person No.");

    //     FulfillmentManagement.CompleteFulfillment(
    //         Delivery."Fulfillment No.");

    //     Delivery.Status := Delivery.Status::Completed;
    //     Delivery."Modified At" := CurrentDateTime();

    //     Delivery.Modify(true);

    //     DeliveryPerson.Available := true;
    //     DeliveryPerson."Modified At" := CurrentDateTime();

    //     DeliveryPerson.Modify(true);
    // end;


    procedure CompleteDelivery(
    DeliveryNo: Code[20])
    var
        Delivery: Record "SD Delivery";
        DeliveryPerson: Record "SD Delivery Person";
        FulfillmentManagement: Codeunit "SD Fulfillment Management";
    begin
        if DeliveryNo = '' then
            Error('Delivery number is required.');

        if not Delivery.Get(DeliveryNo) then
            Error(
                'Delivery %1 does not exist.',
                DeliveryNo);

        if Delivery.Status <> Delivery.Status::Delivered then
            Error(
                'Only delivered deliveries can be completed.');

        if Delivery."Delivery Person No." = '' then
            Error(
                'Delivery %1 has no delivery person assigned.',
                DeliveryNo);

        if not DeliveryPerson.Get(
            Delivery."Delivery Person No.")
        then
            Error(
                'Delivery person %1 does not exist.',
                Delivery."Delivery Person No.");

        Delivery.Status := Delivery.Status::Completed;
        Delivery."Modified At" := CurrentDateTime();

        Delivery.Modify(true);

        FulfillmentManagement.CompleteFulfillment(
            Delivery."Fulfillment No.");

        DeliveryPerson.Available := true;
        DeliveryPerson."Modified At" := CurrentDateTime();

        DeliveryPerson.Modify(true);
    end;
}