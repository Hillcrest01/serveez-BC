page 50145 "SD Settlement Card"
{
    Caption = 'Settlement';
    PageType = Card;
    SourceTable = "SD Settlement";
    ApplicationArea = All;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Settlement';

                field("Settlement No."; Rec."Settlement No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Fulfillment No."; Rec."Fulfillment No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Delivery No."; Rec."Delivery No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Service Code"; Rec."Service Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Provider No."; Rec."Provider No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Delivery Person No."; Rec."Delivery Person No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group(Amounts)
            {
                Caption = 'Amounts';

                field("Service Amount"; Rec."Service Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Delivery Charge"; Rec."Delivery Charge")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Gross Amount"; Rec."Gross Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Provider Amount"; Rec."Provider Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Delivery Person Amount"; Rec."Delivery Person Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Platform Amount"; Rec."Platform Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group(Payouts)
            {
                Caption = 'Payouts';

                field("Provider Paid"; Rec."Provider Paid")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Provider Paid At"; Rec."Provider Paid At")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Delivery Person Paid"; Rec."Delivery Person Paid")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Delivery Person Paid At"; Rec."Delivery Person Paid At")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group(Dates)
            {
                Caption = 'Dates';

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