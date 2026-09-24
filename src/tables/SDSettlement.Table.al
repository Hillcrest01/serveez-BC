table 50124 "SD Settlement"
{
    Caption = 'Serveez Settlement';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Settlement No."; Code[20])
        {
            Caption = 'Settlement No.';
        }

        field(2; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            TableRelation = "SD Portal Order"."Order No.";
        }

        field(3; "Fulfillment No."; Code[20])
        {
            Caption = 'Fulfillment No.';
            TableRelation = "SD Order Fulfillment"."Fulfillment No.";
        }

        field(4; "Delivery No."; Code[20])
        {
            Caption = 'Delivery No.';
            TableRelation = "SD Delivery"."Delivery No.";
        }

        field(5; "Provider No."; Code[20])
        {
            Caption = 'Provider No.';
            TableRelation = "SD Service Provider"."Provider No.";
        }

        field(6; "Delivery Person No."; Code[20])
        {
            Caption = 'Delivery Person No.';
            TableRelation = "SD Delivery Person"."Delivery Person No.";
        }

        field(7; "Service Code"; Code[20])
        {
            Caption = 'Service Code';
            TableRelation = "SD Service".Code;
        }

        field(8; "Service Amount"; Decimal)
        {
            Caption = 'Service Amount';
            DecimalPlaces = 0 : 2;
        }

        field(9; "Delivery Charge"; Decimal)
        {
            Caption = 'Delivery Charge';
            DecimalPlaces = 0 : 2;
        }

        field(10; "Gross Amount"; Decimal)
        {
            Caption = 'Gross Amount';
            DecimalPlaces = 0 : 2;
        }

        field(11; "Provider Amount"; Decimal)
        {
            Caption = 'Provider Amount';
            DecimalPlaces = 0 : 2;
        }

        field(12; "Delivery Person Amount"; Decimal)
        {
            Caption = 'Delivery Person Amount';
            DecimalPlaces = 0 : 2;
        }

        field(13; "Platform Amount"; Decimal)
        {
            Caption = 'Platform Amount';
            DecimalPlaces = 0 : 2;
        }

        field(14; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Pending,PartiallyPaid,Paid,Cancelled;
            OptionCaption = 'Pending,Partially Paid,Paid,Cancelled';
        }

        field(15; "Created At"; DateTime)
        {
            Caption = 'Created At';
        }

        field(16; "Modified At"; DateTime)
        {
            Caption = 'Modified At';
        }

        field(17; "Processed At"; DateTime)
        {
            Caption = 'Processed At';
        }
        field(18; "Provider Paid"; Boolean)
        {
            Caption = 'Provider Paid';
        }

        field(19; "Delivery Person Paid"; Boolean)
        {
            Caption = 'Delivery Person Paid';
        }

        field(20; "Provider Paid At"; DateTime)
        {
            Caption = 'Provider Paid At';
        }

        field(21; "Delivery Person Paid At"; DateTime)
        {
            Caption = 'Delivery Person Paid At';
        }
    }

    keys
    {
        key(PK; "Settlement No.")
        {
            Clustered = true;
        }

        key(Fulfillment; "Fulfillment No.")
        {
        }

        key(Order; "Order No.")
        {
        }

        key(Provider; "Provider No.")
        {
        }

        key(DeliveryPerson; "Delivery Person No.")
        {
        }

        key(Status; Status)
        {
        }
    }
}