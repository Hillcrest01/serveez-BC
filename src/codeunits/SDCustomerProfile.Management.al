codeunit 50104 "SD Customer Profile Management"
{
    // Caption = 'Serveez Customer Profile Management';

    procedure UpdateProfile(
        CustomerNo: Code[20];
        CampusCode: Code[20];
        Resident: Boolean;
        Estate: Text[100];
        Room: Text[50];
        PreferredPickupPointCode: Code[20])
    var
        Customer: Record Customer;
        CustomerProfile: Record "SD Customer Profile";
        Campus: Record "Serveez Campus";
        PickupPoint: Record "SD Pickup Point";
    begin
        if CustomerNo = '' then
            Error('Customer number is required.');

        if not Customer.Get(CustomerNo) then
            Error(
                'Customer %1 does not exist.',
                CustomerNo);

        if CampusCode = '' then
            Error('Campus is required.');

        if not Campus.Get(CampusCode) then
            Error(
                'Campus %1 does not exist.',
                CampusCode);

        if not Campus.Active then
            Error(
                'Campus %1 is not active.',
                CampusCode);

        if Estate = '' then
            Error('Estate is required.');

        if Room = '' then
            Error('Room is required.');

        if PreferredPickupPointCode <> '' then begin
            if not PickupPoint.Get(PreferredPickupPointCode) then
                Error(
                    'Pickup point %1 does not exist.',
                    PreferredPickupPointCode);

            if not PickupPoint.Active then
                Error(
                    'Pickup point %1 is not active.',
                    PreferredPickupPointCode);

            if PickupPoint."Campus Code" <> CampusCode then
                Error(
                    'Pickup point %1 does not belong to campus %2.',
                    PreferredPickupPointCode,
                    CampusCode);
        end;

        if not CustomerProfile.Get(CustomerNo) then begin
            CustomerProfile.Init();
            CustomerProfile."Customer No." := CustomerNo;
            CustomerProfile."Campus Code" := CampusCode;
            CustomerProfile.Resident := Resident;
            CustomerProfile.Estate := Estate;
            CustomerProfile.Room := Room;
            CustomerProfile."Preferred Pickup Point" :=
                PreferredPickupPointCode;
            CustomerProfile."Created At" := CurrentDateTime();
            CustomerProfile."Modified At" := CurrentDateTime();

            CustomerProfile.Insert(true);
        end
        else begin
            CustomerProfile."Campus Code" := CampusCode;
            CustomerProfile.Resident := Resident;
            CustomerProfile.Estate := Estate;
            CustomerProfile.Room := Room;
            CustomerProfile."Preferred Pickup Point" :=
                PreferredPickupPointCode;
            CustomerProfile."Modified At" := CurrentDateTime();

            CustomerProfile.Modify(true);
        end;
    end;

    procedure GetProfile(
        CustomerNo: Code[20];
        var CampusCode: Code[20];
        var Resident: Boolean;
        var Estate: Text[100];
        var Room: Text[50];
        var PreferredPickupPointCode: Code[20])
    var
        CustomerProfile: Record "SD Customer Profile";
    begin
        if CustomerNo = '' then
            Error('Customer number is required.');

        if not CustomerProfile.Get(CustomerNo) then
            Error(
                'Customer profile for %1 does not exist.',
                CustomerNo);

        CampusCode := CustomerProfile."Campus Code";
        Resident := CustomerProfile.Resident;
        Estate := CustomerProfile.Estate;
        Room := CustomerProfile.Room;
        PreferredPickupPointCode :=
            CustomerProfile."Preferred Pickup Point";
    end;
}