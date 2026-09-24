page 50108 "SD Pickup Point Card"
{
    Caption = 'Serveez Pickup Point Card';
    PageType = Card;
    SourceTable = "SD Pickup Point";
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

                field("Campus Code"; Rec."Campus Code")
                {
                    ApplicationArea = All;
                }

                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                }
            }

            group("Area")
            {
                Caption = 'Location';

                field(Location; Rec.Location)
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