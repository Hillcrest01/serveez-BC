codeunit 50110 "SD Customer Management"
{
    // Caption = 'Serveez Customer Management';

    procedure UpdateCustomerDetails(
        UserID: Code[20];
        FullName: Text[100];
        Email: Text[100];
        Phone: Text[30]): Text[100]
    var
        PortalAccount: Record "Serveez Portal Users";
        Customer: Record Customer;
        VerificationToken: Text[100];
        VerificationDuration: Duration;
    begin
        if UserID = '' then
            Error('User ID is required.');

        if not PortalAccount.Get(UserID) then
            Error(
                'Portal account %1 does not exist.',
                UserID);

        if FullName = '' then
            Error('Full name is required.');

        if Email = '' then
            Error('Email address is required.');

        if Phone = '' then
            Error('Phone number is required.');

        if not Customer.Get(PortalAccount."Customer No.") then
            Error(
                'Customer %1 does not exist.',
                PortalAccount."Customer No.");

        if Email <> PortalAccount.Email then begin
            if EmailExistsForAnotherUser(
                Email,
                UserID)
            then
                Error(
                    'An account with email %1 already exists.',
                    Email);
        end;

        if Phone <> PortalAccount.Phone then begin
            if PhoneExistsForAnotherUser(
                Phone,
                UserID)
            then
                Error(
                    'An account with phone number %1 already exists.',
                    Phone);
        end;

        Customer.Validate(
            Name,
            FullName);

        Customer.Modify(true);

        PortalAccount.Phone := Phone;

        if Email <> PortalAccount.Email then begin
            VerificationToken := DelChr(
                Format(CreateGuid()),
                '=',
                '{}-');

            VerificationDuration :=
                24 * 60 * 60 * 1000;

            PortalAccount.Email := Email;
            PortalAccount."Email Verified" := false;
            PortalAccount."Email Verification Token" :=
                VerificationToken;
            PortalAccount."Email Verification Expires At" :=
                CurrentDateTime() + VerificationDuration;
        end;

        PortalAccount.Modify(true);

        exit(VerificationToken);
    end;

    local procedure EmailExistsForAnotherUser(
        Email: Text[100];
        CurrentUserID: Code[20]): Boolean
    var
        PortalAccount: Record "Serveez Portal Users";
    begin
        PortalAccount.SetRange(
            Email,
            Email);

        PortalAccount.SetFilter(
            "User ID",
            '<>%1',
            CurrentUserID);

        exit(
            not PortalAccount.IsEmpty());
    end;

    local procedure PhoneExistsForAnotherUser(
        Phone: Text[30];
        CurrentUserID: Code[20]): Boolean
    var
        PortalAccount: Record "Serveez Portal Users";
    begin
        PortalAccount.SetRange(
            Phone,
            Phone);

        PortalAccount.SetFilter(
            "User ID",
            '<>%1',
            CurrentUserID);

        exit(
            not PortalAccount.IsEmpty());
    end;
}