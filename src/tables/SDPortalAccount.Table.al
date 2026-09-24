table 50103 "Serveez Portal Users"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "User ID"; Code[50])
        {
            DataClassification = CustomerContent;

        }
        field(2; "Customer No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Customer."No.";

        }
        field(3; Email; Text[150])
        {
            DataClassification = CustomerContent;
        }
        field(4; Phone; Text[30])
        {
            Caption = 'Phone';
            DataClassification = CustomerContent;
        }

        field(5; "Password Hash"; Text[255])
        {
            Caption = 'Password Hash';
            DataClassification = ToBeClassified;
        }

        field(6; Active; Boolean)
        {
            Caption = 'Active';
            DataClassification = CustomerContent;
        }

        field(7; "Email Verified"; Boolean)
        {
            Caption = 'Email Verified';
            DataClassification = CustomerContent;
        }

        field(8; "Last Login"; DateTime)
        {
            Caption = 'Last Login';
            DataClassification = SystemMetadata;
        }

        field(9; "Created At"; DateTime)
        {
            Caption = 'Created At';
            DataClassification = SystemMetadata;
        }
        field(11; "Email Verification Token"; Text[100])
        {
            Caption = 'Email Verification Token';
            DataClassification = ToBeClassified;
        }

        field(12; "Email Verification Expires At"; DateTime)
        {
            Caption = 'Email Verification Expires At';
            DataClassification = ToBeClassified;
        }
        field(13; "Password Reset Token"; Text[100])
        {
            Caption = 'Password Reset Token';
            DataClassification = ToBeClassified;
        }

        field(14; "Password Reset Expires At"; DateTime)
        {
            Caption = 'Password Reset Expires At';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "User ID")
        {
            Clustered = true;
        }
        key(Customer; "Customer No.")
        {

        }
        key(Email; Email)
        {

        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}