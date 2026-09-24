page 50146 "SD Settlement List"
{
    Caption = 'Settlements';
    PageType = List;
    SourceTable = "SD Settlement";
    ApplicationArea = All;
    UsageCategory = Lists;

    CardPageId = "SD Settlement Card";

    layout
    {
        area(Content)
        {
            repeater(Settlements)
            {
                field("Settlement No."; Rec."Settlement No.")
                {
                    ApplicationArea = All;
                }

                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                }

                field("Fulfillment No."; Rec."Fulfillment No.")
                {
                    ApplicationArea = All;
                }

                field("Provider No."; Rec."Provider No.")
                {
                    ApplicationArea = All;
                }

                field("Delivery Person No."; Rec."Delivery Person No.")
                {
                    ApplicationArea = All;
                }

                field("Gross Amount"; Rec."Gross Amount")
                {
                    ApplicationArea = All;
                }

                field("Provider Amount"; Rec."Provider Amount")
                {
                    ApplicationArea = All;
                }

                field("Delivery Person Amount"; Rec."Delivery Person Amount")
                {
                    ApplicationArea = All;
                }

                field("Platform Amount"; Rec."Platform Amount")
                {
                    ApplicationArea = All;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }

                field("Provider Paid"; Rec."Provider Paid")
                {
                    ApplicationArea = All;
                }

                field("Delivery Person Paid"; Rec."Delivery Person Paid")
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