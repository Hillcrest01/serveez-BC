page 50116 "SD Product Card"
{
    Caption = 'Serveez Product';
    PageType = Card;
    SourceTable = "SD Product";
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }

                field("Category Code"; Rec."Category Code")
                {
                    ApplicationArea = All;
                }

                field("Display Name"; Rec."Display Name")
                {
                    ApplicationArea = All;
                }

                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                }

                field("Display Order"; Rec."Display Order")
                {
                    ApplicationArea = All;
                }
            }

            group(Pricing)
            {
                Caption = 'Pricing';

                field("Allow Partial Payment"; Rec."Allow Partial Payment")
                {
                    ApplicationArea = All;
                }

                field("Deposit Percentage"; Rec."Deposit Percentage")
                {
                    ApplicationArea = All;
                }
            }

            group(Fulfillment)
            {
                Caption = 'Fulfillment';

                field("Requires Delivery"; Rec."Requires Delivery")
                {
                    ApplicationArea = All;
                }
            }

            group("Description Text")
            {
                Caption = 'Description';

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
        }
    }
}