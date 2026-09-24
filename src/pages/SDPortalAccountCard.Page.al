page 50102 "SD Portal Account Card"
{
    Caption = 'Serveez Portal Account';
    PageType = Card;
    SourceTable = "Serveez Portal Users";
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }

                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }

                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }

                field(Phone; Rec.Phone)
                {
                    ApplicationArea = All;
                }

                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                }

                field("Email Verified"; Rec."Email Verified")
                {
                    ApplicationArea = All;
                }
            }

            group(Security)
            {
                Caption = 'Security';

                field("Password Hash"; Rec."Password Hash")
                {
                    ApplicationArea = All;
                    ExtendedDatatype = Masked;
                }

                field("Last Login"; Rec."Last Login")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Created At"; Rec."Created At")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}