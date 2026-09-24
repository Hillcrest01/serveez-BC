page 50139 "SD Service Provider Card"
{
    Caption = 'Service Provider';
    PageType = Card;
    SourceTable = "SD Service Provider";
    ApplicationArea = All;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Provider';

                field("Provider No."; Rec."Provider No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }

                field(Phone; Rec.Phone)
                {
                    ApplicationArea = All;
                }

                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }

                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }

                field("Payment Details"; Rec."Payment Details")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }

                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                }

                field("Provider Percentage"; Rec."Provider Percentage")
                {
                    ApplicationArea = All;
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