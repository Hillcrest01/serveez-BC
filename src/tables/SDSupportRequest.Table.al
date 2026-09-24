table 50119 "SD Support Request"
{
    Caption = 'Serveez Support Request';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Support No."; Code[20])
        {
            Caption = 'Support No.';
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

        field(4; Category; Option)
        {
            Caption = 'Category';
            OptionMembers = General,Order,Payment,Delivery,Fulfillment,Product,Service,Technical,Other;
            OptionCaption = 'General,Order,Payment,Delivery,Fulfillment,Product,Service,Technical,Other';
        }

        field(5; Priority; Option)
        {
            Caption = 'Priority';
            OptionMembers = Low,Normal,High,Urgent;
            OptionCaption = 'Low,Normal,High,Urgent';
        }

        field(6; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Open,InProgress,WaitingForCustomer,Resolved,Closed,Cancelled;
            OptionCaption = 'Open,In Progress,Waiting for Customer,Resolved,Closed,Cancelled';
        }

        field(7; Subject; Text[150])
        {
            Caption = 'Subject';
        }

        field(8; Description; Text[250])
        {
            Caption = 'Description';
        }

        field(9; "Assigned To"; Code[20])
        {
            Caption = 'Assigned To';
        }

        field(10; "Resolution Notes"; Text[250])
        {
            Caption = 'Resolution Notes';
        }

        field(11; "Created At"; DateTime)
        {
            Caption = 'Created At';
        }

        field(12; "Modified At"; DateTime)
        {
            Caption = 'Modified At';
        }

        field(13; "Resolved At"; DateTime)
        {
            Caption = 'Resolved At';
        }

        field(14; "Closed At"; DateTime)
        {
            Caption = 'Closed At';
        }
    }

    keys
    {
        key(PK; "Support No.")
        {
            Clustered = true;
        }

        key(Customer; "Customer No.")
        {
        }

        key(Order; "Order No.")
        {
        }

        key(Status; Status)
        {
        }

        key(Priority; Priority)
        {
        }

        key(CreatedAt; "Created At")
        {
        }
    }
}