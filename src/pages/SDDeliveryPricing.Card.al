page 50143 "SD Delivery Pricing Card"
{
    Caption = 'Delivery Pricing';
    PageType = Card;
    SourceTable = "SD Delivery Pricing";
    ApplicationArea = All;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Pricing Rule';

                field("Service Code"; Rec."Service Code")
                {
                    ApplicationArea = All;
                }

                field("Pickup Point Code"; Rec."Pickup Point Code")
                {
                    ApplicationArea = All;
                }

                field("Delivery Charge"; Rec."Delivery Charge")
                {
                    ApplicationArea = All;
                }

                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
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
            }
        }
    }
}