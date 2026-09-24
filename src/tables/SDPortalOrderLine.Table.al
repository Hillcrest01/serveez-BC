table 50110 "SD Portal Order Line"
{
    Caption = 'Serveez Portal Order Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            TableRelation = "SD Portal Order"."Order No.";
            DataClassification = CustomerContent;
        }

        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = SystemMetadata;
        }

        field(3; "Line Type"; Option)
        {
            Caption = 'Line Type';
            OptionMembers = Service,Product;
            OptionCaption = 'Service,Product';
            DataClassification = CustomerContent;
        }

        field(4; "Service Code"; Code[20])
        {
            Caption = 'Service Code';
            TableRelation = "SD Service".Code;
            DataClassification = CustomerContent;
        }

        field(5; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item."No.";
            DataClassification = CustomerContent;
        }

        field(6; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }

        field(7; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 2;
            MinValue = 0;
            DataClassification = CustomerContent;
        }

        field(8; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            DecimalPlaces = 0 : 2;
            DataClassification = CustomerContent;
        }

        field(9; Amount; Decimal)
        {
            Caption = 'Amount';
            DecimalPlaces = 0 : 2;
            DataClassification = CustomerContent;
        }

        field(10; "Customer Notes"; Text[250])
        {
            Caption = 'Customer Notes';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Order No.", "Line No.")
        {
            Clustered = true;
        }

        key(Service; "Service Code")
        {
        }

        key(Item; "Item No.")
        {
        }
    }
}