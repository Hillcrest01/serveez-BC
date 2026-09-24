page 50142 "SD Provider Service List"
{
    Caption = 'Provider Services';
    PageType = List;
    SourceTable = "SD Provider Service";
    ApplicationArea = All;
    UsageCategory = Lists;

    CardPageId = "SD Provider Service Card";

    layout
    {
        area(Content)
        {
            repeater(ProviderServices)
            {
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
                }

                field("Modified At"; Rec."Modified At")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}