page 50132 "SD Payment List"
{
    Caption = 'Payments';
    PageType = List;
    SourceTable = "SD Payment";
    ApplicationArea = All;
    UsageCategory = Lists;

    CardPageId = "SD Payment Card";

    layout
    {
        area(Content)
        {
            repeater(Payments)
            {
                field("Payment No."; Rec."Payment No.")
                {
                    ApplicationArea = All;
                }

                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                }

                field("BC Document No."; Rec."BC Document No.")
                {
                    ApplicationArea = All;
                }

                field("Payment Provider"; Rec."Payment Provider")
                {
                    ApplicationArea = All;
                }

                field("Provider Transaction ID"; Rec."Provider Transaction ID")
                {
                    ApplicationArea = All;
                }

                field("Provider Reference"; Rec."Provider Reference")
                {
                    ApplicationArea = All;
                }

                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }

                field(Currency; Rec.Currency)
                {
                    ApplicationArea = All;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }

                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}