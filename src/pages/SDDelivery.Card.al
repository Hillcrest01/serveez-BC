page 50126 "SD Delivery Card"
{
    Caption = 'Delivery';
    PageType = Card;
    SourceTable = "SD Delivery";
    ApplicationArea = All;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Delivery Card';

                field("Delivery No."; Rec."Delivery No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Fulfillment No."; Rec."Fulfillment No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }

                field("Delivery Person No."; Rec."Delivery Person No.")
                {
                    ApplicationArea = All;
                }
            }

            group(Route)
            {
                Caption = 'Route';

                field("Pickup Location"; Rec."Pickup Location")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }

                field(Destination; Rec.Destination)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }

                field("Delivery Charge"; Rec."Delivery Charge")
                {
                    ApplicationArea = All;
                }
            }

            group(Timestamps)
            {
                Caption = 'Progress';

                field("Assigned At"; Rec."Assigned At")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Accepted At"; Rec."Accepted At")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Picked Up At"; Rec."Picked Up At")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Delivered At"; Rec."Delivered At")
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

            group(Completion)
            {
                Caption = 'Completion';

                field("Proof Of Delivery"; Rec."Proof Of Delivery")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }

                field("Customer Notes"; Rec."Customer Notes")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
        }
    }
}
