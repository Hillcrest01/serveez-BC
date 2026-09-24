table 50106 "SD Service"
{
    Caption = 'Serveez Service';
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

        field(3; "Category Code"; Code[20])
        {
            Caption = 'Category Code';
            TableRelation = "SD Service Category".Code;
            DataClassification = CustomerContent;
        }

        field(4; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }

        field(5; Active; Boolean)
        {
            Caption = 'Active';
            DataClassification = CustomerContent;
        }

        field(6; Price; Decimal)
        {
            Caption = 'Price';
            DecimalPlaces = 0 : 2;
            DataClassification = CustomerContent;
        }

        field(7; "Allow Partial Payment"; Boolean)
        {
            Caption = 'Allow Partial Payment';
            DataClassification = CustomerContent;
        }

        field(8; "Deposit Percentage"; Decimal)
        {
            Caption = 'Deposit Percentage';
            DecimalPlaces = 0 : 2;
            MinValue = 0;
            MaxValue = 100;
            DataClassification = CustomerContent;
        }

        field(9; "Requires Delivery"; Boolean)
        {
            Caption = 'Requires Delivery';
            DataClassification = CustomerContent;
        }

        field(10; "Requires Document"; Boolean)
        {
            Caption = 'Requires Document';
            DataClassification = CustomerContent;
        }

        field(11; "Display Order"; Integer)
        {
            Caption = 'Display Order';
            DataClassification = SystemMetadata;
        }
        field(12; "Sales Account No."; Code[20])
        {
            Caption = 'Sales Account No.';
            TableRelation = "G/L Account"."No.";
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }

        key(Category; "Category Code")
        {
        }

        key(Name; Name)
        {
        }

        key(DisplayOrder; "Display Order")
        {
        }
    }
}