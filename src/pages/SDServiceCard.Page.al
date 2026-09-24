page 50112 "SD Service Card"
{
    Caption = 'Serveez Service';
    PageType = Card;
    SourceTable = "SD Service";
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }

                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }

                field("Category Code"; Rec."Category Code")
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
                field("Sales Account No."; Rec."Sales Account No.")
                {
                    ApplicationArea = All;
                }
            }

            group(Pricing)
            {
                Caption = 'Pricing';

                field(Price; Rec.Price)
                {
                    ApplicationArea = All;
                }

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

                field("Requires Document"; Rec."Requires Document")
                {
                    ApplicationArea = All;
                }
            }

            group("Description Feature")
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