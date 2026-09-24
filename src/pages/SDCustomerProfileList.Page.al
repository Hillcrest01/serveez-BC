page 50107 "SD Customer Profile List"
{
    Caption = 'Serveez Customer Profiles';
    PageType = List;
    SourceTable = "SD Customer Profile";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "SD Customer Profile Card";

    layout
    {
        area(Content)
        {
            repeater(Profiles)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }

                field("Campus Code"; Rec."Campus Code")
                {
                    ApplicationArea = All;
                }

                field(Resident; Rec.Resident)
                {
                    ApplicationArea = All;
                }

                field(Room; Rec.Room)
                {
                    ApplicationArea = All;
                }

                field(Estate; Rec.Estate)
                {
                    ApplicationArea = All;
                }

                field("Preferred Pickup Point"; Rec."Preferred Pickup Point")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}