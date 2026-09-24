page 50100 "Serveez Campus"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Serveez Campus";
    CardPageId = "SD Campus Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;

                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;

                }
                field("Phone Number"; Rec."Phone Number")
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

    actions
    {
        area(Processing)
        {
            action("Open Setups Page")
            {

                RunObject = page "SD Setups Page";
            }
        }
    }

    var
        myInt: Integer;
}