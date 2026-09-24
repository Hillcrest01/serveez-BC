page 50120 "SD Portal Order Subpage"
{
    Caption = 'Order Lines';
    PageType = ListPart;
    SourceTable = "SD Portal Order Line";
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Line Type"; Rec."Line Type")
                {
                    ApplicationArea = All;
                }

                field("Service Code"; Rec."Service Code")
                {
                    ApplicationArea = All;
                }

                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }

                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }

                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                }

                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }

                field("Customer Notes"; Rec."Customer Notes")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}