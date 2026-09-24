page 50103 "SD Setups Page"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "SD Setups Table";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Default Campus"; Rec."Default Campus")
                {
                    ApplicationArea = All;
                }
                field("Platform Percentage"; Rec."Platform Percentage")
                {

                }
            }
        }

    }


    actions
    {
        area(Processing)
        {
            action("Format Setup")
            {

                trigger OnAction()
                begin
                    Rec.FindFirst();
                    Rec.Delete();
                    Message('The setup has been deleted successfully');
                end;
            }
        }
    }

    // var
    //     myInt: Integer;
    trigger OnOpenPage()
    begin
        if Rec."Primary Key" = '' then begin
            Rec."Primary Key" := 'SETUP';
            Rec.Insert();
        end;
    end;
}