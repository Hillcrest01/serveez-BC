table 50113 "SD Delivery"
{
    Caption = 'Serveez Delivery';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Delivery No."; Code[20])
        {
            Caption = 'Delivery No.';
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

        field(4; "Delivery Person No."; Code[20])
        {
            Caption = 'Delivery Person No.';
            TableRelation = "SD Delivery Person"."Delivery Person No.";
        }

        field(5; "Pickup Location"; Text[250])
        {
            Caption = 'Pickup Location';
        }

        field(6; "Destination"; Text[250])
        {
            Caption = 'Destination';
        }
        field(17; "Pickup Point Code"; Code[20])
        {
            Caption = 'Pickup Point Code';
            TableRelation = "SD Pickup Point".Code;
        }

        field(7; "Delivery Charge"; Decimal)
        {
            Caption = 'Delivery Charge';
            DecimalPlaces = 0 : 2;
        }

        field(8; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Created,Assigned,Accepted,EnRouteToPickup,ArrivedAtPickup,PickedUp,EnRouteToDestination,ArrivedAtDestination,Delivered,Completed,Declined,Failed,CustomerUnavailable,DeliveryFailed;
            OptionCaption = 'Created,Assigned,Accepted,En Route to Pickup,Arrived at Pickup,Picked Up,En Route to Destination,Arrived at Destination,Delivered,Completed,Declined,Failed,Customer Unavailable,Delivery Failed';
        }

        field(9; "Assigned At"; DateTime)
        {
            Caption = 'Assigned At';
        }

        field(10; "Accepted At"; DateTime)
        {
            Caption = 'Accepted At';
        }

        field(11; "Picked Up At"; DateTime)
        {
            Caption = 'Picked Up At';
        }

        field(12; "Delivered At"; DateTime)
        {
            Caption = 'Delivered At';
        }

        field(13; "Proof Of Delivery"; Text[250])
        {
            Caption = 'Proof Of Delivery';
        }

        field(14; "Customer Notes"; Text[250])
        {
            Caption = 'Customer Notes';
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
        key(PK; "Delivery No.")
        {
            Clustered = true;
        }

        key(Order; "Order No.")
        {
        }

        key(Fulfillment; "Fulfillment No.")
        {
        }

        key(Status; Status)
        {
        }

        key(DeliveryPerson; "Delivery Person No.")
        {
        }
    }
}