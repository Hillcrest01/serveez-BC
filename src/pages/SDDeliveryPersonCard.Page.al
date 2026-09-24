page 50129 "SD Delivery Person Card"
{
    Caption = 'Delivery Person';
    PageType = Card;
    SourceTable = "SD Delivery Person";
    ApplicationArea = All;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Delivery Person';

                field("Delivery Person No."; Rec."Delivery Person No.")
                {
                    ApplicationArea = All;
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

                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                }

                field(Available; Rec.Available)
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
                field("Settlement Percentage"; Rec."Settlement Percentage")
                {
                    ApplicationArea = All;
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