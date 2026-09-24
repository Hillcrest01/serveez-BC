page 50130 "SD Delivery Person List"
{
    Caption = 'Delivery Persons';
    PageType = List;
    SourceTable = "SD Delivery Person";
    ApplicationArea = All;
    UsageCategory = Lists;

    CardPageId = "SD Delivery Person Card";

    layout
    {
        area(Content)
        {
            repeater(DeliveryPersons)
            {
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
                field("Settlement Percentage"; Rec."Settlement Percentage")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}