table 50101 "SD Customer Profile"
{
    Caption = 'Serveez Customer Profile';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
            DataClassification = CustomerContent;
        }

        field(2; "Campus Code"; Code[20])
        {
            Caption = 'Campus Code';
            TableRelation = "Serveez Campus".Code;
            DataClassification = CustomerContent;
        }

        field(3; Resident; Boolean)
        {
            Caption = 'Resident';
            DataClassification = CustomerContent;
        }

        field(4; Room; Text[50])
        {
            Caption = 'Room';
            DataClassification = CustomerContent;
        }

        field(5; Estate; Text[100])
        {
            Caption = 'Estate';
            DataClassification = CustomerContent;
        }

        field(6; "Preferred Pickup Point"; Code[20])
        {
            Caption = 'Preferred Pickup Point';
            TableRelation = "SD Pickup Point".Code;
            DataClassification = CustomerContent;
        }

        field(7; "Created At"; DateTime)
        {
            Caption = 'Created At';
            DataClassification = SystemMetadata;
        }

        field(8; "Modified At"; DateTime)
        {
            Caption = 'Modified At';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "Customer No.")
        {
            Clustered = true;
        }

        key(Campus; "Campus Code")
        {
        }
    }
}