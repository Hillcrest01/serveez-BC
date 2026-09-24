page 50119 "SD Portal Order Card"
{
    Caption = 'Serveez Portal Order';
    PageType = Document;
    SourceTable = "SD Portal Order";
    ApplicationArea = All;
    UsageCategory = Documents;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Order';

                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }

                field("Campus Code"; Rec."Campus Code")
                {
                    ApplicationArea = All;
                }

                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                }

                field("Order Time"; Rec."Order Time")
                {
                    ApplicationArea = All;
                }

                field("Order Status"; Rec."Order Status")
                {
                    ApplicationArea = All;
                }

                field("Payment Status"; Rec."Payment Status")
                {
                    ApplicationArea = All;
                }

                field("Fulfillment Status"; Rec."Fulfillment Status")
                {
                    ApplicationArea = All;
                }
            }

            part(Lines; "SD Portal Order Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "Order No." = field("Order No.");
            }
            part(Location; "SD Order Location Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "Order No." = field("Order No.");
            }
            part(Fulfillments; "SD Order Fulfillment Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "Order No." = field("Order No.");
            }

            group(Financial)
            {
                Caption = 'Financial';

                field(Subtotal; Rec.Subtotal)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Delivery Charge"; Rec."Delivery Charge")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Amount Paid"; Rec."Amount Paid")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Amount Due"; Rec."Amount Due")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group(Integration)
            {
                Caption = 'ERP Integration';

                field("BC Sales Order No."; Rec."BC Sales Order No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group(Notes)
            {
                Caption = 'Notes';

                field("Customer Notes"; Rec."Customer Notes")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
        }
    }
}