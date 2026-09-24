page 50133 "SD Notification Card"
{
    Caption = 'Notification';
    PageType = Card;
    SourceTable = "SD Notification";
    ApplicationArea = All;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Notification';

                field("Notification No."; Rec."Notification No.")
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

                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }

                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                }

                field(Message; Rec.Message)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }

                field("Is Read"; Rec."Is Read")
                {
                    ApplicationArea = All;
                }

                field("Created At"; Rec."Created At")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Read At"; Rec."Read At")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}