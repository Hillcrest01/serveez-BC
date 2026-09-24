table 50109 "SD Portal Order"
{
    Caption = 'Serveez Portal Order';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            DataClassification = CustomerContent;
        }

        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
            DataClassification = CustomerContent;
        }

        field(3; "Campus Code"; Code[20])
        {
            Caption = 'Campus Code';
            TableRelation = "Serveez Campus".Code;
            DataClassification = CustomerContent;
        }

        field(4; "Order Date"; Date)
        {
            Caption = 'Order Date';
            DataClassification = CustomerContent;
        }

        field(5; "Order Time"; Time)
        {
            Caption = 'Order Time';
            DataClassification = CustomerContent;
        }

        field(6; "Order Status"; Option)
        {
            Caption = 'Order Status';
            OptionMembers = Draft,Submitted,Confirmed,InProgress,Completed,Closed,Rejected,Cancelled;
            OptionCaption = 'Draft,Submitted,Confirmed,In Progress,Completed,Closed,Rejected,Cancelled';
            DataClassification = CustomerContent;
        }

        field(7; "Payment Status"; Option)
        {
            Caption = 'Payment Status';
            OptionMembers = Unpaid,PaymentPending,PartiallyPaid,Paid,PartiallyRefunded,Refunded;
            OptionCaption = 'Unpaid,Payment Pending,Partially Paid,Paid,Partially Refunded,Refunded';
            DataClassification = CustomerContent;
        }

        field(8; "Fulfillment Status"; Option)
        {
            Caption = 'Fulfillment Status';
            OptionMembers = NotStarted,Assigned,Accepted,InProgress,Ready,OutForDelivery,Delivered,Completed;
            OptionCaption = 'Not Started,Assigned,Accepted,In Progress,Ready,Out for Delivery,Delivered,Completed';
            DataClassification = CustomerContent;
        }

        field(9; "Subtotal"; Decimal)
        {
            Caption = 'Subtotal';
            DecimalPlaces = 0 : 2;
            DataClassification = CustomerContent;
        }

        field(10; "Delivery Charge"; Decimal)
        {
            Caption = 'Delivery Charge';
            DecimalPlaces = 0 : 2;
            DataClassification = CustomerContent;
        }

        field(11; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            DecimalPlaces = 0 : 2;
            DataClassification = CustomerContent;
        }

        field(12; "Amount Paid"; Decimal)
        {
            Caption = 'Amount Paid';
            DecimalPlaces = 0 : 2;
            DataClassification = CustomerContent;
        }

        field(13; "Amount Due"; Decimal)
        {
            Caption = 'Amount Due';
            DecimalPlaces = 0 : 2;
            DataClassification = CustomerContent;
        }

        field(14; "BC Sales Order No."; Code[20])
        {
            Caption = 'BC Sales Order No.';
            DataClassification = CustomerContent;
        }

        field(15; "Created At"; DateTime)
        {
            Caption = 'Created At';
            DataClassification = SystemMetadata;
        }

        field(16; "Modified At"; DateTime)
        {
            Caption = 'Modified At';
            DataClassification = SystemMetadata;
        }

        field(17; "Customer Notes"; Text[250])
        {
            Caption = 'Customer Notes';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Order No.")
        {
            Clustered = true;
        }

        key(Customer; "Customer No.")
        {
        }

        key(Status; "Order Status")
        {
        }

        key(OrderDate; "Order Date")
        {
        }
    }
}