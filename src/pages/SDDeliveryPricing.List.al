page 50144 "SD Delivery Pricing List"
{
    Caption = 'Delivery Pricing';
    PageType = List;
    SourceTable = "SD Delivery Pricing";
    ApplicationArea = All;
    UsageCategory = Lists;

    CardPageId = "SD Delivery Pricing Card";

    layout
    {
        area(Content)
        {
            repeater(PricingRules)
            {

                field("Pricing No."; Rec."Pricing No.")
                {
                    ApplicationArea = All;
                }

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
        }
    }
}