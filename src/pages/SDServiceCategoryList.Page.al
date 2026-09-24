page 50111 "SD Service Category List"
{
    Caption = 'Serveez Service Categories';
    PageType = List;
    SourceTable = "SD Service Category";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "SD Service Category Card";

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