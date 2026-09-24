page 50123 "SD Order Fulfillment Card"
{
    Caption = 'Order Fulfillment';
    PageType = Card;
    SourceTable = "SD Order Fulfillment";
    ApplicationArea = All;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Fulfillment';

                field("Fulfillment No."; Rec."Fulfillment No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Order No."; Rec."Order No.")
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
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }

            group(Assignment)
            {
                Caption = 'Assignment';

                field("Provider No."; Rec."Provider No.")
                {
                    ApplicationArea = All;
                }

                field("Assigned To"; Rec."Assigned To")
                {
                    ApplicationArea = All;
                }
            }

            group(Timestamps)
            {
                Caption = 'Progress';

                field("Started At"; Rec."Started At")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Ready At"; Rec."Ready At")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Completed At"; Rec."Completed At")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

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

            group("Fulfillment Notes")
            {
                Caption = 'Notes';

                field(Notes; Rec.Notes)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
        }
    }
}