page 50117 "SD Product List"
{
    Caption = 'Serveez Products';
    PageType = List;
    SourceTable = "SD Product";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "SD Product Card";

    layout
    {
        area(Content)
        {
            repeater(Products)
            {
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

                field("Requires Delivery"; Rec."Requires Delivery")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}