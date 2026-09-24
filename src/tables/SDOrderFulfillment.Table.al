table 50112 "SD Order Fulfillment"
{
    Caption = 'Serveez Order Fulfillment';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Fulfillment No."; Code[20])
        {
            Caption = 'Fulfillment No.';
        }

        field(2; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            TableRelation = "SD Portal Order"."Order No.";
        }

        field(3; "Order Line No."; Integer)
        {
            Caption = 'Order Line No.';
        }

        field(4; "Service Code"; Code[20])
        {
            Caption = 'Service Code';
            TableRelation = "SD Service".Code;
        }

        field(5; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item."No.";
        }

        field(6; Description; Text[100])
        {
            Caption = 'Description';
        }

        field(7; Quantity; Decimal)
        {
            Caption = 'Quantity';
        }

        field(8; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = NotStarted,Assigned,Accepted,InProgress,Ready,OutForDelivery,Delivered,Completed,Cancelled;
            OptionCaption = 'Not Started,Assigned,Accepted,In Progress,Ready,Out for Delivery,Delivered,Completed,Cancelled';
        }

        field(9; "Assigned To"; Code[20])
        {
            Caption = 'Assigned To';
        }

        field(10; "Provider No."; Code[20])
        {
            Caption = 'Provider No.';
            TableRelation = Vendor."No.";
        }

        field(11; "Started At"; DateTime)
        {
            Caption = 'Started At';
        }

        field(12; "Ready At"; DateTime)
        {
            Caption = 'Ready At';
        }

        field(13; "Completed At"; DateTime)
        {
            Caption = 'Completed At';
        }

        field(14; Notes; Text[250])
        {
            Caption = 'Notes';
        }

        field(15; "Created At"; DateTime)
        {
            Caption = 'Created At';
        }

        field(16; "Modified At"; DateTime)
        {
            Caption = 'Modified At';
        }
    }

    keys
    {
        key(PK; "Fulfillment No.")
        {
            Clustered = true;
        }

        key(Order; "Order No.")
        {
        }

        key(OrderLine; "Order No.", "Order Line No.")
        {
        }

        key(Status; Status)
        {
        }

        key(Provider; "Provider No.")
        {
        }
    }
}