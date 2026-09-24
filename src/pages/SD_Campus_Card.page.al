page 50101 "SD Campus Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Serveez Campus";

    layout
    {
        area(Content)
        {
            group(General)
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
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}