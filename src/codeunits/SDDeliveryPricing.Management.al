codeunit 50113 "SD Delivery Pricing Management"
{
    // Caption = 'Serveez Delivery Pricing Management';

    procedure CreatePricing(
        ServiceCode: Code[20];
        PickupPointCode: Code[20];
        DeliveryCharge: Decimal): Code[20]
    var
        Service: Record "SD Service";
        PickupPoint: Record "SD Pickup Point";
        Pricing: Record "SD Delivery Pricing";
        PricingNo: Code[20];
    begin
        if ServiceCode = '' then
            Error('Service code is required.');

        if PickupPointCode = '' then
            Error('Pickup point code is required.');

        if not Service.Get(ServiceCode) then
            Error(
                'Service %1 does not exist.',
                ServiceCode);

        if not Service.Active then
            Error(
                'Service %1 is not active.',
                ServiceCode);

        if not PickupPoint.Get(PickupPointCode) then
            Error(
                'Pickup point %1 does not exist.',
                PickupPointCode);

        if not PickupPoint.Active then
            Error(
                'Pickup point %1 is not active.',
                PickupPointCode);

        if DeliveryCharge < 0 then
            Error(
                'Delivery charge cannot be negative.');

        if PricingExists(
            ServiceCode,
            PickupPointCode)
        then
            Error(
                'A delivery pricing rule already exists for service %1 and pickup point %2.',
                ServiceCode,
                PickupPointCode);

        PricingNo := GetNextPricingNo();

        Pricing.Init();
        Pricing."Pricing No." := PricingNo;
        Pricing."Service Code" := ServiceCode;
        Pricing."Pickup Point Code" := PickupPointCode;
        Pricing."Delivery Charge" := DeliveryCharge;
        Pricing.Active := true;
        Pricing."Created At" := CurrentDateTime();
        Pricing."Modified At" := CurrentDateTime();

        Pricing.Insert(true);

        exit(PricingNo);
    end;

    procedure UpdatePricing(
        PricingNo: Code[20];
        DeliveryCharge: Decimal)
    var
        Pricing: Record "SD Delivery Pricing";
    begin
        GetPricing(
            Pricing,
            PricingNo);

        if DeliveryCharge < 0 then
            Error(
                'Delivery charge cannot be negative.');

        Pricing."Delivery Charge" := DeliveryCharge;
        Pricing."Modified At" := CurrentDateTime();

        Pricing.Modify(true);
    end;

    procedure ActivatePricing(
        PricingNo: Code[20])
    var
        Pricing: Record "SD Delivery Pricing";
    begin
        GetPricing(
            Pricing,
            PricingNo);

        if Pricing.Active then
            Error(
                'Pricing rule %1 is already active.',
                PricingNo);

        Pricing.Active := true;
        Pricing."Modified At" := CurrentDateTime();

        Pricing.Modify(true);
    end;

    procedure DeactivatePricing(
        PricingNo: Code[20])
    var
        Pricing: Record "SD Delivery Pricing";
    begin
        GetPricing(
            Pricing,
            PricingNo);

        if not Pricing.Active then
            Error(
                'Pricing rule %1 is already inactive.',
                PricingNo);

        Pricing.Active := false;
        Pricing."Modified At" := CurrentDateTime();

        Pricing.Modify(true);
    end;

    procedure CalculateDeliveryCharge(
        ServiceCode: Code[20];
        PickupPointCode: Code[20]): Decimal
    var
        Pricing: Record "SD Delivery Pricing";
    begin
        if ServiceCode = '' then
            Error('Service code is required.');

        if PickupPointCode = '' then
            Error('Pickup point code is required.');

        Pricing.SetRange(
            "Service Code",
            ServiceCode);

        Pricing.SetRange(
            "Pickup Point Code",
            PickupPointCode);

        Pricing.SetRange(
            Active,
            true);

        if not Pricing.FindFirst() then
            Error(
                'No active delivery price exists for service %1 to pickup point %2.',
                ServiceCode,
                PickupPointCode);

        exit(
            Pricing."Delivery Charge");
    end;

    local procedure PricingExists(
        ServiceCode: Code[20];
        PickupPointCode: Code[20]): Boolean
    var
        Pricing: Record "SD Delivery Pricing";
    begin
        Pricing.SetRange(
            "Service Code",
            ServiceCode);

        Pricing.SetRange(
            "Pickup Point Code",
            PickupPointCode);

        exit(
            not Pricing.IsEmpty());
    end;

    local procedure GetPricing(
        var Pricing: Record "SD Delivery Pricing";
        PricingNo: Code[20])
    begin
        if PricingNo = '' then
            Error('Pricing number is required.');

        if not Pricing.Get(PricingNo) then
            Error(
                'Pricing rule %1 does not exist.',
                PricingNo);
    end;

    local procedure GetNextPricingNo(): Code[20]
    var
        Pricing: Record "SD Delivery Pricing";
        NextNumber: Integer;
        ExistingNo: Code[20];
    begin
        if Pricing.FindLast() then begin
            ExistingNo := Pricing."Pricing No.";

            if Evaluate(
                NextNumber,
                CopyStr(ExistingNo, 7))
            then
                NextNumber += 1
            else
                NextNumber := 1;
        end
        else
            NextNumber := 1;

        exit(
            'PRICE-' +
            Format(
                NextNumber,
                6,
                '<Integer,6><Filler Character,0>'));
    end;
}