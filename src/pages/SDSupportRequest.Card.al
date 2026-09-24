page 50135 "SD Support Request Card"
{
    Caption = 'Support Request';
    PageType = Card;
    SourceTable = "SD Support Request";
    ApplicationArea = All;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Support Request';

                field("Support No."; Rec."Support No.")
                {
                    ApplicationArea = All;
                    Editable = false;
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

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }

            group(Assignment)
            {
                Caption = 'Assignment';

                field("Assigned To"; Rec."Assigned To")
                {
                    ApplicationArea = All;
                }

                field("Resolution Notes"; Rec."Resolution Notes")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }

            group(Timestamps)
            {
                Caption = 'Dates';

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

                field("Resolved At"; Rec."Resolved At")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Closed At"; Rec."Closed At")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}