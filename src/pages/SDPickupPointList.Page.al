page 50109 "SD Pickup Point List"
{
    Caption = 'Serveez Pickup Points';
    PageType = List;
    SourceTable = "SD Pickup Point";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "SD Pickup Point Card";

    layout
    {
        area(Content)
        {
            repeater(PickupPoints)
            {
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

                field(Location; Rec.Location)
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