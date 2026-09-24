page 50106 "SD Customer Profile Card"
{
    Caption = 'Serveez Customer Profile';
    PageType = Card;
    SourceTable = "SD Customer Profile";
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Customer';

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
            }

            group(Location)
            {
                Caption = 'Location';

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

            group(System)
            {
                Caption = 'System Information';

                field("Created At"; Rec."Created At")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Modified At"; Rec."Modified At")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}