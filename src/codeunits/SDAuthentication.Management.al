codeunit 50109 "SD Authentication Management"
{
    // Caption = 'Serveez Authentication Management';

    procedure CreateAccount(
        Email: Text[100];
        Phone: Text[30];
        PasswordHash: Text[250];
        FullName: Text[100];
        CampusCode: Code[20];
        Resident: Boolean;
        Estate: Text[100];
        Room: Text[50];
        PreferredPickupPointCode: Code[20]): Code[20]
    var
        Customer: Record Customer;
        PortalAccount: Record "Serveez Portal Users";
        CustomerProfile: Record "SD Customer Profile";
        Campus: Record "Serveez Campus";
        PickupPoint: Record "SD Pickup Point";
        UserID: Code[20];
        VerificationToken: Text[100];
        VerificationDuration: Duration;
    begin
        ValidateRegistrationInput(
            Email,
            Phone,
            PasswordHash,
            FullName,
            CampusCode,
            Resident,
            Estate,
            Room);

        if AccountEmailExists(Email) then
            Error(
                'An account with email %1 already exists.',
                Email);

        if AccountPhoneExists(Phone) then
            Error(
                'An account with phone number %1 already exists.',
                Phone);

        if not Campus.Get(CampusCode) then
            Error(
                'Campus %1 does not exist.',
                CampusCode);

        if not Campus.Active then
            Error(
                'Campus %1 is not active.',
                CampusCode);

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

        UserID := GetNextUserID();

        VerificationToken := DelChr(
            Format(CreateGuid()),
            '=',
            '{}-');

        VerificationDuration := 24 * 60 * 60 * 1000;

        Customer.Init();
        Customer.Validate(Name, FullName);
        Customer.Insert(true);

        PortalAccount.Init();
        PortalAccount."User ID" := UserID;
        PortalAccount."Customer No." := Customer."No.";
        PortalAccount.Email := Email;
        PortalAccount.Phone := Phone;
        PortalAccount."Password Hash" := PasswordHash;
        PortalAccount.Active := true;
        PortalAccount."Email Verified" := false;
        PortalAccount."Email Verification Token" := VerificationToken;
        PortalAccount."Email Verification Expires At" :=
            CurrentDateTime() + VerificationDuration;
        PortalAccount."Created At" := CurrentDateTime();

        PortalAccount.Insert(true);

        CustomerProfile.Init();
        CustomerProfile."Customer No." := Customer."No.";
        CustomerProfile."Campus Code" := CampusCode;
        CustomerProfile.Resident := Resident;
        CustomerProfile.Estate := Estate;
        CustomerProfile.Room := Room;
        CustomerProfile."Preferred Pickup Point" :=
            PreferredPickupPointCode;

        CustomerProfile.Insert(true);

        exit(UserID);
    end;

    procedure VerifyEmail(
        UserID: Code[20];
        VerificationToken: Text[100])
    var
        PortalAccount: Record "Serveez Portal Users";
    begin
        GetAccount(
            PortalAccount,
            UserID);

        if PortalAccount."Email Verified" then
            Error('Email address is already verified.');

        if VerificationToken = '' then
            Error('Verification token is required.');

        if PortalAccount."Email Verification Token" <> VerificationToken then
            Error('Invalid email verification token.');

        if PortalAccount."Email Verification Expires At" < CurrentDateTime() then
            Error('Email verification token has expired.');

        PortalAccount."Email Verified" := true;
        PortalAccount."Email Verification Token" := '';
        PortalAccount."Email Verification Expires At" := 0DT;

        PortalAccount.Modify(true);
    end;

    procedure ActivateAccount(UserID: Code[20])
    var
        PortalAccount: Record "Serveez Portal Users";
    begin
        GetAccount(
            PortalAccount,
            UserID);

        PortalAccount.Active := true;
        PortalAccount.Modify(true);
    end;

    procedure DeactivateAccount(UserID: Code[20])
    var
        PortalAccount: Record "Serveez Portal Users";
    begin
        GetAccount(
            PortalAccount,
            UserID);

        PortalAccount.Active := false;
        PortalAccount.Modify(true);
    end;

    procedure RecordLogin(UserID: Code[20])
    var
        PortalAccount: Record "Serveez Portal Users";
    begin
        GetAccount(
            PortalAccount,
            UserID);

        if not PortalAccount.Active then
            Error(
                'Account %1 is inactive.',
                UserID);

        if not PortalAccount."Email Verified" then
            Error(
                'Email address has not been verified.');

        PortalAccount."Last Login" := CurrentDateTime();
        PortalAccount.Modify(true);
    end;

    procedure GetUserIDByEmail(Email: Text[100]): Code[20]
    var
        PortalAccount: Record "Serveez Portal Users";
    begin
        if Email = '' then
            Error('Email is required.');

        PortalAccount.SetRange(
            Email,
            Email);

        if not PortalAccount.FindFirst() then
            Error(
                'No account exists for email %1.',
                Email);

        exit(
            PortalAccount."User ID");
    end;

    local procedure ValidateRegistrationInput(
        Email: Text[100];
        Phone: Text[30];
        PasswordHash: Text[250];
        FullName: Text[100];
        CampusCode: Code[20];
        Resident: Boolean;
        Estate: Text[100];
        Room: Text[50])
    begin
        if Email = '' then
            Error('Email address is required.');

        if Phone = '' then
            Error('Phone number is required.');

        if PasswordHash = '' then
            Error('Password hash is required.');

        if FullName = '' then
            Error('Full name is required.');

        if CampusCode = '' then
            Error('Campus is required.');

        if Estate = '' then
            Error('Estate is required.');

        if Room = '' then
            Error('Room is required.');
    end;

    local procedure AccountEmailExists(
        Email: Text[100]): Boolean
    var
        PortalAccount: Record "Serveez Portal Users";
    begin
        PortalAccount.SetRange(
            Email,
            Email);

        exit(
            not PortalAccount.IsEmpty());
    end;

    local procedure AccountPhoneExists(
        Phone: Text[30]): Boolean
    var
        PortalAccount: Record "Serveez Portal Users";
    begin
        PortalAccount.SetRange(
            Phone,
            Phone);

        exit(
            not PortalAccount.IsEmpty());
    end;

    local procedure GetAccount(
        var PortalAccount: Record "Serveez Portal Users";
        UserID: Code[20])
    begin
        if UserID = '' then
            Error('User ID is required.');

        if not PortalAccount.Get(UserID) then
            Error(
                'Portal account %1 does not exist.',
                UserID);
    end;

    local procedure GetNextUserID(): Code[20]
    var
        PortalAccount: Record "Serveez Portal Users";
        NextNumber: Integer;
        ExistingNo: Code[20];
    begin
        if PortalAccount.FindLast() then begin
            ExistingNo := PortalAccount."User ID";

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
            'USR-' +
            Format(
                NextNumber,
                6,
                '<Integer,6><Filler Character,0>'));
    end;

    procedure ChangePassword(
    UserID: Code[20];
    NewPasswordHash: Text[250])
    var
        PortalAccount: Record "Serveez Portal Users";
    begin
        if UserID = '' then
            Error('User ID is required.');

        if NewPasswordHash = '' then
            Error('New password hash is required.');

        GetAccount(
            PortalAccount,
            UserID);

        if not PortalAccount.Active then
            Error(
                'Account %1 is inactive.',
                UserID);

        PortalAccount."Password Hash" := NewPasswordHash;
        PortalAccount.Modify(true);
    end;

    procedure RequestPasswordReset(
    Email: Text[100]): Text[100]
    var
        PortalAccount: Record "Serveez Portal Users";
        ResetToken: Text[100];
        ResetDuration: Duration;
    begin
        if Email = '' then
            Error('Email address is required.');

        PortalAccount.SetRange(
            Email,
            Email);

        if not PortalAccount.FindFirst() then
            Error(
                'No account exists for email %1.',
                Email);

        if not PortalAccount.Active then
            Error('Account is inactive.');

        ResetToken := DelChr(
            Format(CreateGuid()),
            '=',
            '{}-');

        ResetDuration :=
            60 * 60 * 1000;

        PortalAccount."Password Reset Token" := ResetToken;
        PortalAccount."Password Reset Expires At" :=
            CurrentDateTime() + ResetDuration;

        PortalAccount.Modify(true);

        exit(ResetToken);
    end;

    procedure ResetPassword(
    Email: Text[100];
    ResetToken: Text[100];
    NewPasswordHash: Text[250])
    var
        PortalAccount: Record "Serveez Portal Users";
    begin
        if Email = '' then
            Error('Email address is required.');

        if ResetToken = '' then
            Error('Password reset token is required.');

        if NewPasswordHash = '' then
            Error('New password hash is required.');

        PortalAccount.SetRange(
            Email,
            Email);

        if not PortalAccount.FindFirst() then
            Error(
                'No account exists for email %1.',
                Email);

        if not PortalAccount.Active then
            Error('Account is inactive.');

        if PortalAccount."Password Reset Token" <> ResetToken then
            Error('Invalid password reset token.');

        if PortalAccount."Password Reset Expires At" < CurrentDateTime() then
            Error('Password reset token has expired.');

        PortalAccount."Password Hash" := NewPasswordHash;
        PortalAccount."Password Reset Token" := '';
        PortalAccount."Password Reset Expires At" := 0DT;

        PortalAccount.Modify(true);
    end;
}