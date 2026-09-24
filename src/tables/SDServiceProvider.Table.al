table 50121 "SD Service Provider"
{
    Caption = 'Serveez Service Provider';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Provider No."; Code[20])
        {
            Caption = 'Provider No.';
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

        field(5; Address; Text[250])
        {
            Caption = 'Address';
        }

        field(6; "Payment Details"; Text[250])
        {
            Caption = 'Payment Details';
            DataClassification = ToBeClassified;
        }

        field(7; Active; Boolean)
        {
            Caption = 'Active';
        }

        field(8; "Provider Percentage"; Decimal)
        {
            Caption = 'Provider Percentage';
            DecimalPlaces = 0 : 2;
        }

        field(9; "Created At"; DateTime)
        {
            Caption = 'Created At';
        }

        field(10; "Modified At"; DateTime)
        {
            Caption = 'Modified At';
        }
    }

    keys
    {
        key(PK; "Provider No.")
        {
            Clustered = true;
        }

        key(Name; Name)
        {
        }

        key(Active; Active)
        {
        }
    }
}