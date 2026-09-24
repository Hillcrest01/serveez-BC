page 50141 "SD Provider Service Card"
{
    Caption = 'Provider Service';
    PageType = Card;
    SourceTable = "SD Provider Service";
    ApplicationArea = All;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Provider Service';

                field("Provider No."; Rec."Provider No.")
                {
                    ApplicationArea = All;
                }

                field("Service Code"; Rec."Service Code")
                {
                    ApplicationArea = All;
                }

                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
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
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Created At" := CurrentDateTime();
        Rec."Modified At" := CurrentDateTime();

        exit(true);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        Rec."Modified At" := CurrentDateTime();

        exit(true);
    end;
}