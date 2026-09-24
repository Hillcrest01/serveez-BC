table 50123 "SD Delivery Pricing"
{
    Caption = 'Serveez Delivery Pricing';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Pricing No."; Code[20])
        {
            Caption = 'Pricing No.';
        }

        field(2; "Service Code"; Code[20])
        {
            Caption = 'Service Code';
            TableRelation = "SD Service".Code;
        }

        field(3; "Pickup Point Code"; Code[20])
        {
            Caption = 'Pickup Point Code';
            TableRelation = "SD Pickup Point".Code;
        }

        field(4; "Delivery Charge"; Decimal)
        {
            Caption = 'Delivery Charge';
            DecimalPlaces = 0 : 2;
        }

        field(5; Active; Boolean)
        {
            Caption = 'Active';
        }

        field(6; "Created At"; DateTime)
        {
            Caption = 'Created At';
        }

        field(7; "Modified At"; DateTime)
        {
            Caption = 'Modified At';
        }
    }

    keys
    {
        key(PK; "Pricing No.")
        {
            Clustered = true;
        }

        key(ServicePickup; "Service Code", "Pickup Point Code", Active)
        {
        }

        key(PickupPoint; "Pickup Point Code", Active)
        {
        }
    }
}