page 50110 "SD Service Category Card"
{
    Caption = 'Serveez Service Category';
    PageType = Card;
    SourceTable = "SD Service Category";
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

                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                }

                field("Display Order"; Rec."Display Order")
                {
                    ApplicationArea = All;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
        }
    }
}