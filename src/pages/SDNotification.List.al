page 50134 "SD Notification List"
{
    Caption = 'Notifications';
    PageType = List;
    SourceTable = "SD Notification";
    ApplicationArea = All;
    UsageCategory = Lists;

    CardPageId = "SD Notification Card";

    layout
    {
        area(Content)
        {
            repeater(Notifications)
            {
                field("Notification No."; Rec."Notification No.")
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
                }

                field("Is Read"; Rec."Is Read")
                {
                    ApplicationArea = All;
                }

                field("Created At"; Rec."Created At")
                {
                    ApplicationArea = All;
                }

                field("Read At"; Rec."Read At")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}