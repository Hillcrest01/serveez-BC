table 50116 "SD Payment"
{
    Caption = 'Serveez Payment';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Payment No."; Code[20])
        {
            Caption = 'Payment No.';
        }

        field(2; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            TableRelation = "SD Portal Order"."Order No.";
        }

        field(3; "BC Document No."; Code[20])
        {
            Caption = 'BC Document No.';
        }

        field(4; "Payment Provider"; Option)
        {
            Caption = 'Payment Provider';
            OptionMembers = MPesa,Paystack,Other;
            OptionCaption = 'M-Pesa,Paystack,Other';
        }

        field(5; "Provider Transaction ID"; Text[100])
        {
            Caption = 'Provider Transaction ID';
        }

        field(6; "Provider Reference"; Text[100])
        {
            Caption = 'Provider Reference';
        }

        field(7; Amount; Decimal)
        {
            Caption = 'Amount';
            DecimalPlaces = 0 : 2;
        }

        field(8; Currency; Code[10])
        {
            Caption = 'Currency';
        }

        field(9; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Pending,Successful,Failed,Cancelled,Refunded,PartiallyRefunded;
            OptionCaption = 'Pending,Successful,Failed,Cancelled,Refunded,Partially Refunded';
        }

        field(10; "Transaction Date"; DateTime)
        {
            Caption = 'Transaction Date';
        }

        field(11; "Created At"; DateTime)
        {
            Caption = 'Created At';
        }

        field(12; "Modified At"; DateTime)
        {
            Caption = 'Modified At';
        }

        field(13; "Gateway Response"; Text[250])
        {
            Caption = 'Gateway Response';
        }
    }

    keys
    {
        key(PK; "Payment No.")
        {
            Clustered = true;
        }

        key(Order; "Order No.")
        {
        }

        key(Status; Status)
        {
        }

        key(TransactionID; "Provider Transaction ID")
        {
        }
    }
}