table 50102 "SD Setups Table"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Default Campus"; Code[20])
        {
            TableRelation = "Serveez Campus".Code;
        }
        field(3; "Platform Percentage"; Decimal)
        {
            Caption = 'Platform Percentage';
            DecimalPlaces = 0 : 2;
        }

    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}