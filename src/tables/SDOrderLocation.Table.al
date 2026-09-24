table 50111 "SD Order Location"
{
    Caption = 'Serveez Order Location';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            TableRelation = "SD Portal Order"."Order No.";
        }

        field(2; "Campus Code"; Code[20])
        {
            Caption = 'Campus Code';
            TableRelation = "Serveez Campus".Code;
        }

        field(3; Resident; Boolean)
        {
            Caption = 'Resident';
        }

        field(4; Estate; Text[100])
        {
            Caption = 'Estate';
        }

        field(5; Room; Text[50])
        {
            Caption = 'Room';
        }

        field(6; "Pickup Point Code"; Code[20])
        {
            Caption = 'Pickup Point Code';
            TableRelation = "SD Pickup Point".Code;
        }

        field(7; "Pickup Point Name"; Text[100])
        {
            Caption = 'Pickup Point Name';
        }

        field(8; "Delivery Address"; Text[250])
        {
            Caption = 'Delivery Address';
        }

        field(9; "Location Notes"; Text[250])
        {
            Caption = 'Location Notes';
        }

        field(10; "Created At"; DateTime)
        {
            Caption = 'Created At';
        }
    }

    keys
    {
        key(PK; "Order No.")
        {
            Clustered = true;
        }

        key(Campus; "Campus Code")
        {
        }

        key(PickupPoint; "Pickup Point Code")
        {
        }
    }
}