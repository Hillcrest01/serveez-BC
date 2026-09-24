page 50137 "SD Payment Refund Card"
{
    Caption = 'Payment Refund';
    PageType = Card;
    SourceTable = "SD Payment Refund";
    ApplicationArea = All;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Refund';

                field("Refund No."; Rec."Refund No.")
                {
                    ApplicationArea = All;
                    Editable = false;
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

                field("Provider Reference"; Rec."Provider Reference")
                {
                    ApplicationArea = All;
                }

                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }

            group(Processing)
            {
                Caption = 'Processing';

                field("Gateway Response"; Rec."Gateway Response")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }

                field("Created At"; Rec."Created At")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Modified At"; Rec."Modified At")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Processed At"; Rec."Processed At")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}