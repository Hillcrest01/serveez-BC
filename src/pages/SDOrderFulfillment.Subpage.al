page 50125 "SD Order Fulfillment Subpage"
{
    Caption = 'Fulfillments';
    PageType = ListPart;
    SourceTable = "SD Order Fulfillment";
    ApplicationArea = All;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(Fulfillments)
            {
                field("Fulfillment No."; Rec."Fulfillment No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Order Line No."; Rec."Order Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }

                field("Assigned To"; Rec."Assigned To")
                {
                    ApplicationArea = All;
                }

                field("Provider No."; Rec."Provider No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}