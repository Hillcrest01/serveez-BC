table 50120 "SD Payment Refund"
{
    Caption = 'Serveez Payment Refund';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Refund No."; Code[20])
        {
            Caption = 'Refund No.';
        }

        field(2; "Payment No."; Code[20])
        {
            Caption = 'Payment No.';
            TableRelation = "SD Payment"."Payment No.";
        }

        field(3; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            TableRelation = "SD Portal Order"."Order No.";
        }

        field(4; Amount; Decimal)
        {
            Caption = 'Amount';
            DecimalPlaces = 0 : 2;
        }

        field(5; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Pending,Successful,Failed,Cancelled;
            OptionCaption = 'Pending,Successful,Failed,Cancelled';
        }

        field(6; "Refund Provider"; Option)
        {
            Caption = 'Refund Provider';
            OptionMembers = "M-Pesa",Paystack,Other;
            OptionCaption = 'M-Pesa,Paystack,Other';
        }

        field(7; "Provider Refund ID"; Text[100])
        {
            Caption = 'Provider Refund ID';
        }

        field(8; "Provider Reference"; Text[100])
        {
            Caption = 'Provider Reference';
        }

        field(9; Reason; Text[250])
        {
            Caption = 'Reason';
        }

        field(10; "Gateway Response"; Text[250])
        {
            Caption = 'Gateway Response';
        }

        field(11; "Created At"; DateTime)
        {
            Caption = 'Created At';
        }

        field(12; "Modified At"; DateTime)
        {
            Caption = 'Modified At';
        }

        field(13; "Processed At"; DateTime)
        {
            Caption = 'Processed At';
        }
    }

    keys
    {
        key(PK; "Refund No.")
        {
            Clustered = true;
        }

        key(Payment; "Payment No.")
        {
        }

        key(Order; "Order No.")
        {
        }

        key(Status; Status)
        {
        }

        key(ProviderRefundID; "Provider Refund ID")
        {
        }
    }
}