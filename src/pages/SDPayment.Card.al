page 50131 "SD Payment Card"
{
    Caption = 'Payment';
    PageType = Card;
    SourceTable = "SD Payment";
    ApplicationArea = All;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Payment';

                field("Payment No."; Rec."Payment No.")
                {
                    ApplicationArea = All;
                    Editable = false;
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
            }

            group(Transaction)
            {
                Caption = 'Transaction';

                field("Transaction Date"; Rec."Transaction Date")
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

                field("Gateway Response"; Rec."Gateway Response")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
        }
    }
}