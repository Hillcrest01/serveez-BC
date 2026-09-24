page 50122 "SD Order Location Subpage"
{
    Caption = 'Order Location';
    PageType = ListPart;
    SourceTable = "SD Order Location";
    ApplicationArea = All;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(Location)
            {
                Caption = 'Delivery Location';

                field("Campus Code"; Rec."Campus Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Resident; Rec.Resident)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Estate; Rec.Estate)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Room; Rec.Room)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Pickup Point Name"; Rec."Pickup Point Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Delivery Address"; Rec."Delivery Address")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Location Notes"; Rec."Location Notes")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}