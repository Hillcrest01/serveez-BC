table 50104 "SD Pickup Point"
{
    Caption = 'Serveez Pickup Point';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }

        field(2; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }

        field(3; "Campus Code"; Code[20])
        {
            Caption = 'Campus Code';
            TableRelation = "Serveez Campus".Code;
            DataClassification = CustomerContent;
        }

        field(4; Location; Text[250])
        {
            Caption = 'Location';
            DataClassification = CustomerContent;
        }

        field(5; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }

        field(6; Active; Boolean)
        {
            Caption = 'Active';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }

        key(Campus; "Campus Code")
        {
        }

        key(Name; Name)
        {
        }
    }
}