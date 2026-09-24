page 50127 "SD Delivery List"
{
    Caption = 'Deliveries';
    PageType = List;
    SourceTable = "SD Delivery";
    ApplicationArea = All;
    UsageCategory = Lists;

    CardPageId = "SD Delivery Card";

    layout
    {
        area(Content)
        {
            repeater(Deliveries)
            {
                field("Delivery No."; Rec."Delivery No.")
                {
                    ApplicationArea = All;
                }

                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                }

                field("Fulfillment No."; Rec."Fulfillment No.")
                {
                    ApplicationArea = All;
                }

                field("Delivery Person No."; Rec."Delivery Person No.")
                {
                    ApplicationArea = All;
                }

                field("Pickup Location"; Rec."Pickup Location")
                {
                    ApplicationArea = All;
                }

                field(Destination; Rec.Destination)
                {
                    ApplicationArea = All;
                }

                field("Delivery Charge"; Rec."Delivery Charge")
                {
                    ApplicationArea = All;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }

                field("Assigned At"; Rec."Assigned At")
                {
                    ApplicationArea = All;
                }

                field("Picked Up At"; Rec."Picked Up At")
                {
                    ApplicationArea = All;
                }

                field("Delivered At"; Rec."Delivered At")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}