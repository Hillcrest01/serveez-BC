page 50124 "SD Order Fulfillment List"
{
    Caption = 'Order Fulfillments';
    PageType = List;
    SourceTable = "SD Order Fulfillment";
    ApplicationArea = All;
    UsageCategory = Lists;

    CardPageId = "SD Order Fulfillment Card";

    layout
    {
        area(Content)
        {
            repeater(Fulfillments)
            {
                field("Fulfillment No."; Rec."Fulfillment No.")
                {
                    ApplicationArea = All;
                }

                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                }

                field("Order Line No."; Rec."Order Line No.")
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

                field("Started At"; Rec."Started At")
                {
                    ApplicationArea = All;
                }

                field("Ready At"; Rec."Ready At")
                {
                    ApplicationArea = All;
                }

                field("Completed At"; Rec."Completed At")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}