page 50121 "SD Order Location Card"
{
    Caption = 'Order Location';
    PageType = Card;
    SourceTable = "SD Order Location";
    ApplicationArea = All;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Order Location';

                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

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

                field("Pickup Point Code"; Rec."Pickup Point Code")
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

                field("Created At"; Rec."Created At")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}