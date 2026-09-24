table 50125 "SD Order Event"
{
    Caption = 'Serveez Order Event';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Event No."; Code[20])
        {
            Caption = 'Event No.';
        }

        field(2; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            TableRelation = "SD Portal Order"."Order No.";
        }

        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
        }

        field(4; Type; Option)
        {
            Caption = 'Type';
            OptionMembers = Order,Payment,Refund,Fulfillment,Delivery,Settlement,Support,System;
            OptionCaption = 'Order,Payment,Refund,Fulfillment,Delivery,Settlement,Support,System';
        }

        field(5; "Event Code"; Code[50])
        {
            Caption = 'Event Code';
        }

        field(6; Title; Text[100])
        {
            Caption = 'Title';
        }

        field(7; Description; Text[250])
        {
            Caption = 'Description';
        }

        field(8; "Reference No."; Code[50])
        {
            Caption = 'Reference No.';
        }

        field(9; "Event Date"; DateTime)
        {
            Caption = 'Event Date';
        }

        field(10; "Created By"; Code[50])
        {
            Caption = 'Created By';
        }
    }

    keys
    {
        key(PK; "Event No.")
        {
            Clustered = true;
        }

        key(OrderDate; "Order No.", "Event Date")
        {
        }

        key(Customer; "Customer No.", "Event Date")
        {
        }

        key(EventCode; "Event Code")
        {
        }

        key(Reference; "Reference No.")
        {
        }
    }
}