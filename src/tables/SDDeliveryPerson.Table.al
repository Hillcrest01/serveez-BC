table 50115 "SD Delivery Person"
{
    Caption = 'Serveez Delivery Person';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Delivery Person No."; Code[20])
        {
            Caption = 'Delivery Person No.';
        }

        field(2; Name; Text[100])
        {
            Caption = 'Name';
        }

        field(3; Phone; Text[30])
        {
            Caption = 'Phone';
        }

        field(4; Email; Text[100])
        {
            Caption = 'Email';
        }

        field(5; "Active"; Boolean)
        {
            Caption = 'Active';
        }

        field(6; Available; Boolean)
        {
            Caption = 'Available';
        }

        field(7; "Created At"; DateTime)
        {
            Caption = 'Created At';
        }

        field(8; "Modified At"; DateTime)
        {
            Caption = 'Modified At';
        }
        field(9; "Settlement Percentage"; Decimal)
        {
            Caption = 'Settlement Percentage';
            DecimalPlaces = 0 : 2;
        }
    }

    keys
    {
        key(PK; "Delivery Person No.")
        {
            Clustered = true;
        }

        key(Name; Name)
        {
        }

        key(Active; Active)
        {
        }

        key(Available; Available)
        {
        }
    }
}