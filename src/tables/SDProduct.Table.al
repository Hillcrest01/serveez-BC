table 50108 "SD Product"
{
    Caption = 'Serveez Product';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item."No.";
            DataClassification = CustomerContent;
        }

        field(2; "Category Code"; Code[20])
        {
            Caption = 'Category Code';
            TableRelation = "SD Product Category".Code;
            DataClassification = CustomerContent;
        }

        field(3; "Display Name"; Text[100])
        {
            Caption = 'Display Name';
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

        field(6; "Display Order"; Integer)
        {
            Caption = 'Display Order';
            DataClassification = SystemMetadata;
        }

        field(7; "Requires Delivery"; Boolean)
        {
            Caption = 'Requires Delivery';
            DataClassification = CustomerContent;
        }

        field(8; "Allow Partial Payment"; Boolean)
        {
            Caption = 'Allow Partial Payment';
            DataClassification = CustomerContent;
        }

        field(9; "Deposit Percentage"; Decimal)
        {
            Caption = 'Deposit Percentage';
            DecimalPlaces = 0 : 2;
            MinValue = 0;
            MaxValue = 100;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Item No.")
        {
            Clustered = true;
        }

        key(Category; "Category Code")
        {
        }

        key(DisplayOrder; "Display Order")
        {
        }
    }
}