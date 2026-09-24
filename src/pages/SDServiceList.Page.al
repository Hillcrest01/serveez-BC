page 50113 "SD Service List"
{
    Caption = 'Serveez Services';
    PageType = List;
    SourceTable = "SD Service";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "SD Service Card";

    layout
    {
        area(Content)
        {
            repeater(Services)
            {
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

                field(Price; Rec.Price)
                {
                    ApplicationArea = All;
                }

                field("Allow Partial Payment"; Rec."Allow Partial Payment")
                {
                    ApplicationArea = All;
                }

                field("Requires Delivery"; Rec."Requires Delivery")
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