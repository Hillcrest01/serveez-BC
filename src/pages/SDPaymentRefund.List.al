page 50138 "SD Payment Refund List"
{
    Caption = 'Payment Refunds';
    PageType = List;
    SourceTable = "SD Payment Refund";
    ApplicationArea = All;
    UsageCategory = Lists;

    CardPageId = "SD Payment Refund Card";

    layout
    {
        area(Content)
        {
            repeater(Refunds)
            {
                field("Refund No."; Rec."Refund No.")
                {
                    ApplicationArea = All;
                }

                field("Payment No."; Rec."Payment No.")
                {
                    ApplicationArea = All;
                }

                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                }

                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }

                field("Refund Provider"; Rec."Refund Provider")
                {
                    ApplicationArea = All;
                }

                field("Provider Refund ID"; Rec."Provider Refund ID")
                {
                    ApplicationArea = All;
                }

                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                }

                field("Created At"; Rec."Created At")
                {
                    ApplicationArea = All;
                }

                field("Processed At"; Rec."Processed At")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}