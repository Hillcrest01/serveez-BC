page 50136 "SD Support Request List"
{
    Caption = 'Support Requests';
    PageType = List;
    SourceTable = "SD Support Request";
    ApplicationArea = All;
    UsageCategory = Lists;

    CardPageId = "SD Support Request Card";

    layout
    {
        area(Content)
        {
            repeater(SupportRequests)
            {
                field("Support No."; Rec."Support No.")
                {
                    ApplicationArea = All;
                }

                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }

                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                }

                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }

                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }

                field(Subject; Rec.Subject)
                {
                    ApplicationArea = All;
                }

                field("Assigned To"; Rec."Assigned To")
                {
                    ApplicationArea = All;
                }

                field("Created At"; Rec."Created At")
                {
                    ApplicationArea = All;
                }

                field("Resolved At"; Rec."Resolved At")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}