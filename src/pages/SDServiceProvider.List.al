page 50140 "SD Service Provider List"
{
    Caption = 'Service Providers';
    PageType = List;
    SourceTable = "SD Service Provider";
    ApplicationArea = All;
    UsageCategory = Lists;

    CardPageId = "SD Service Provider Card";

    layout
    {
        area(Content)
        {
            repeater(Providers)
            {
                field("Provider No."; Rec."Provider No.")
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

                field("Provider Percentage"; Rec."Provider Percentage")
                {
                    ApplicationArea = All;
                }

                field("Created At"; Rec."Created At")
                {
                    ApplicationArea = All;
                }

                field("Modified At"; Rec."Modified At")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}