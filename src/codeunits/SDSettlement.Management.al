codeunit 50116 "SD Settlement Management"
{
    // Caption = 'Serveez Settlement Management';

    procedure CreateSettlement(
        FulfillmentNo: Code[20]): Code[20]
    var
        Fulfillment: Record "SD Order Fulfillment";
        OrderLine: Record "SD Portal Order Line";
        Delivery: Record "SD Delivery";
        Provider: Record "SD Service Provider";
        DeliveryPerson: Record "SD Delivery Person";
        Settlement: Record "SD Settlement";
        SettlementNo: Code[20];
        ServiceAmount: Decimal;
        DeliveryCharge: Decimal;
        GrossAmount: Decimal;
        ProviderAmount: Decimal;
        DeliveryPersonAmount: Decimal;
        PlatformAmount: Decimal;
    begin
        if FulfillmentNo = '' then
            Error('Fulfillment number is required.');

        if not Fulfillment.Get(FulfillmentNo) then
            Error(
                'Fulfillment %1 does not exist.',
                FulfillmentNo);

        if Fulfillment.Status <> Fulfillment.Status::Completed then
            Error(
                'Only completed fulfillment can create a settlement.');

        if SettlementExists(FulfillmentNo) then
            Error(
                'A settlement already exists for fulfillment %1.',
                FulfillmentNo);

        if not OrderLine.Get(
            Fulfillment."Order No.",
            Fulfillment."Order Line No.")
        then
            Error(
                'Order line %1 for order %2 does not exist.',
                Fulfillment."Order Line No.",
                Fulfillment."Order No.");

        ServiceAmount := OrderLine.Amount;
        DeliveryCharge := 0;

        Delivery.Reset();
        Delivery.SetRange(
            "Fulfillment No.",
            FulfillmentNo);

        if Delivery.FindFirst() then begin
            if Delivery.Status <> Delivery.Status::Completed then
                Error(
                    'Delivery %1 must be completed before settlement.',
                    Delivery."Delivery No.");

            DeliveryCharge := Delivery."Delivery Charge";

            if Delivery."Delivery Person No." <> '' then begin
                if not DeliveryPerson.Get(
                    Delivery."Delivery Person No.")
                then
                    Error(
                        'Delivery person %1 does not exist.',
                        Delivery."Delivery Person No.");
            end;
        end;

        ProviderAmount := 0;

        if Fulfillment."Provider No." <> '' then begin
            if not Provider.Get(
                Fulfillment."Provider No.")
            then
                Error(
                    'Provider %1 does not exist.',
                    Fulfillment."Provider No.");

            if not Provider.Active then
                Error(
                    'Provider %1 is not active.',
                    Fulfillment."Provider No.");

            if Provider."Provider Percentage" < 0 then
                Error(
                    'Provider percentage cannot be negative.');

            if Provider."Provider Percentage" > 100 then
                Error(
                    'Provider percentage cannot exceed 100.');

            ProviderAmount :=
                ServiceAmount *
                Provider."Provider Percentage" /
                100;
        end;

        DeliveryPersonAmount := 0;

        if DeliveryPerson."Delivery Person No." <> '' then begin
            if DeliveryPerson."Settlement Percentage" < 0 then
                Error(
                    'Delivery person settlement percentage cannot be negative.');

            if DeliveryPerson."Settlement Percentage" > 100 then
                Error(
                    'Delivery person settlement percentage cannot exceed 100.');

            DeliveryPersonAmount :=
                DeliveryCharge *
                DeliveryPerson."Settlement Percentage" /
                100;
        end;

        GrossAmount :=
            ServiceAmount +
            DeliveryCharge;

        PlatformAmount :=
            GrossAmount -
            ProviderAmount -
            DeliveryPersonAmount;

        if PlatformAmount < 0 then
            Error(
                'Settlement shares exceed the gross amount.');

        SettlementNo := GetNextSettlementNo();

        Settlement.Init();
        Settlement."Settlement No." := SettlementNo;
        Settlement."Order No." := Fulfillment."Order No.";
        Settlement."Fulfillment No." := FulfillmentNo;

        if Delivery.FindFirst() then
            Settlement."Delivery No." :=
                Delivery."Delivery No.";

        Settlement."Provider No." :=
            Fulfillment."Provider No.";

        if Delivery."Delivery Person No." <> '' then
            Settlement."Delivery Person No." :=
                Delivery."Delivery Person No.";

        Settlement."Service Code" :=
            Fulfillment."Service Code";

        Settlement."Service Amount" :=
            ServiceAmount;

        Settlement."Delivery Charge" :=
            DeliveryCharge;

        Settlement."Gross Amount" :=
            GrossAmount;

        Settlement."Provider Amount" :=
            Round(
                ProviderAmount,
                0.01);

        Settlement."Delivery Person Amount" :=
            Round(
                DeliveryPersonAmount,
                0.01);

        Settlement."Platform Amount" :=
            GrossAmount -
            Settlement."Provider Amount" -
            Settlement."Delivery Person Amount";

        Settlement.Status :=
            Settlement.Status::Pending;

        Settlement."Created At" :=
            CurrentDateTime();

        Settlement."Modified At" :=
            CurrentDateTime();

        Settlement.Insert(true);

        exit(SettlementNo);
    end;

    local procedure SettlementExists(
        FulfillmentNo: Code[20]): Boolean
    var
        Settlement: Record "SD Settlement";
    begin
        Settlement.SetRange(
            "Fulfillment No.",
            FulfillmentNo);

        exit(
            not Settlement.IsEmpty());
    end;

    local procedure GetNextSettlementNo(): Code[20]
    var
        Settlement: Record "SD Settlement";
        NextNumber: Integer;
        ExistingNo: Code[20];
    begin
        if Settlement.FindLast() then begin
            ExistingNo := Settlement."Settlement No.";

            if Evaluate(
                NextNumber,
                CopyStr(ExistingNo, 6))
            then
                NextNumber += 1
            else
                NextNumber := 1;
        end
        else
            NextNumber := 1;

        exit(
            'SETT-' +
            Format(
                NextNumber,
                6,
                '<Integer,6><Filler Character,0>'));
    end;

    procedure MarkProviderPaid(
    SettlementNo: Code[20])
    var
        Settlement: Record "SD Settlement";
    begin
        GetSettlement(
            Settlement,
            SettlementNo);

        if Settlement.Status = Settlement.Status::Paid then
            Error(
                'Settlement %1 is already fully paid.',
                SettlementNo);

        if Settlement.Status = Settlement.Status::Cancelled then
            Error(
                'Cancelled settlement %1 cannot be paid.',
                SettlementNo);

        if Settlement."Provider No." = '' then
            Error(
                'Settlement %1 has no provider.',
                SettlementNo);

        if Settlement."Provider Amount" <= 0 then
            Error(
                'Settlement %1 has no provider amount to pay.',
                SettlementNo);

        if Settlement."Provider Paid" then
            Error(
                'Provider payment for settlement %1 has already been recorded.',
                SettlementNo);

        Settlement."Provider Paid" := true;
        Settlement."Provider Paid At" := CurrentDateTime();
        Settlement."Modified At" := CurrentDateTime();

        Settlement.Modify(true);

        UpdateSettlementStatus(
            Settlement);
    end;

    procedure MarkDeliveryPersonPaid(
        SettlementNo: Code[20])
    var
        Settlement: Record "SD Settlement";
    begin
        GetSettlement(
            Settlement,
            SettlementNo);

        if Settlement.Status = Settlement.Status::Paid then
            Error(
                'Settlement %1 is already fully paid.',
                SettlementNo);

        if Settlement.Status = Settlement.Status::Cancelled then
            Error(
                'Cancelled settlement %1 cannot be paid.',
                SettlementNo);

        if Settlement."Delivery Person No." = '' then
            Error(
                'Settlement %1 has no delivery person.',
                SettlementNo);

        if Settlement."Delivery Person Amount" <= 0 then
            Error(
                'Settlement %1 has no delivery person amount to pay.',
                SettlementNo);

        if Settlement."Delivery Person Paid" then
            Error(
                'Delivery person payment for settlement %1 has already been recorded.',
                SettlementNo);

        Settlement."Delivery Person Paid" := true;
        Settlement."Delivery Person Paid At" := CurrentDateTime();
        Settlement."Modified At" := CurrentDateTime();

        Settlement.Modify(true);

        UpdateSettlementStatus(
            Settlement);
    end;

    procedure CompleteSettlement(
        SettlementNo: Code[20])
    var
        Settlement: Record "SD Settlement";
    begin
        GetSettlement(
            Settlement,
            SettlementNo);

        if Settlement.Status = Settlement.Status::Cancelled then
            Error(
                'Cancelled settlement %1 cannot be completed.',
                SettlementNo);

        if Settlement.Status = Settlement.Status::Paid then
            Error(
                'Settlement %1 is already paid.',
                SettlementNo);

        if Settlement."Provider Amount" > 0 then
            if not Settlement."Provider Paid" then
                Error(
                    'Provider payment for settlement %1 has not been completed.',
                    SettlementNo);

        if Settlement."Delivery Person Amount" > 0 then
            if not Settlement."Delivery Person Paid" then
                Error(
                    'Delivery person payment for settlement %1 has not been completed.',
                    SettlementNo);

        Settlement.Status := Settlement.Status::Paid;
        Settlement."Processed At" := CurrentDateTime();
        Settlement."Modified At" := CurrentDateTime();

        Settlement.Modify(true);
    end;

    procedure CancelSettlement(
        SettlementNo: Code[20])
    var
        Settlement: Record "SD Settlement";
    begin
        GetSettlement(
            Settlement,
            SettlementNo);

        if Settlement.Status = Settlement.Status::Paid then
            Error(
                'Paid settlement %1 cannot be cancelled.',
                SettlementNo);

        if Settlement."Provider Paid" then
            Error(
                'Settlement %1 cannot be cancelled after provider payment.',
                SettlementNo);

        if Settlement."Delivery Person Paid" then
            Error(
                'Settlement %1 cannot be cancelled after delivery person payment.',
                SettlementNo);

        Settlement.Status := Settlement.Status::Cancelled;
        Settlement."Modified At" := CurrentDateTime();

        Settlement.Modify(true);
    end;

    local procedure UpdateSettlementStatus(
        var Settlement: Record "SD Settlement")
    var
        ProviderComplete: Boolean;
        DeliveryPersonComplete: Boolean;
    begin
        ProviderComplete :=
            (Settlement."Provider Amount" = 0) or
            Settlement."Provider Paid";

        DeliveryPersonComplete :=
            (Settlement."Delivery Person Amount" = 0) or
            Settlement."Delivery Person Paid";

        if ProviderComplete and DeliveryPersonComplete then begin
            Settlement.Status := Settlement.Status::Paid;
            Settlement."Processed At" := CurrentDateTime();
        end
        else begin
            Settlement.Status := Settlement.Status::PartiallyPaid;
            Settlement."Processed At" := 0DT;
        end;

        Settlement."Modified At" := CurrentDateTime();

        Settlement.Modify(true);
    end;

    local procedure GetSettlement(
        var Settlement: Record "SD Settlement";
        SettlementNo: Code[20])
    begin
        if SettlementNo = '' then
            Error('Settlement number is required.');

        if not Settlement.Get(SettlementNo) then
            Error(
                'Settlement %1 does not exist.',
                SettlementNo);
    end;
}