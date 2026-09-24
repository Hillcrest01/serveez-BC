table 50118 "SD Notification"
{
    Caption = 'Serveez Notification';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Notification No."; Code[20])
        {
            Caption = 'Notification No.';
        }

        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
        }

        field(3; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            TableRelation = "SD Portal Order"."Order No.";
        }

        field(4; Type; Option)
        {
            Caption = 'Type';
            OptionMembers = Order,Payment,Fulfillment,Delivery,System;
            OptionCaption = 'Order,Payment,Fulfillment,Delivery,System';
        }

        field(5; Title; Text[100])
        {
            Caption = 'Title';
        }

        field(6; Message; Text[250])
        {
            Caption = 'Message';
        }

        field(7; "Is Read"; Boolean)
        {
            Caption = 'Is Read';
        }

        field(8; "Created At"; DateTime)
        {
            Caption = 'Created At';
        }

        field(9; "Read At"; DateTime)
        {
            Caption = 'Read At';
        }
    }

    keys
    {
        key(PK; "Notification No.")
        {
            Clustered = true;
        }

        key(Customer; "Customer No.")
        {
        }

        key(Order; "Order No.")
        {
        }

        key(Unread; "Customer No.", "Is Read")
        {
        }

        key(CreatedAt; "Created At")
        {
        }
    }
}