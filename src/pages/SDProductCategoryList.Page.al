page 50115 "SD Product Category List"
{
    Caption = 'Serveez Product Categories';
    PageType = List;
    SourceTable = "SD Product Category";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "SD Product Category Card";

    layout
    {
        area(Content)
        {
            repeater(Categories)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }

                field(Name; Rec.Name)
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
        }
    }
}