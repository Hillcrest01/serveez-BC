page 50118 "SD Portal Order List"
{
    Caption = 'Serveez Portal Orders';
    PageType = List;
    SourceTable = "SD Portal Order";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "SD Portal Order Card";

    layout
    {
        area(Content)
        {
            repeater(Orders)
            {
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
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

                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                }

                field("Amount Paid"; Rec."Amount Paid")
                {
                    ApplicationArea = All;
                }

                field("Amount Due"; Rec."Amount Due")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}