page 50104 "SD Portal Account List"
{
    Caption = 'Serveez Portal Accounts';
    PageType = List;
    SourceTable = "Serveez Portal Users";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "SD Portal Account Card";

    layout
    {
        area(Content)
        {
            repeater(Accounts)
            {
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

                field("Last Login"; Rec."Last Login")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}