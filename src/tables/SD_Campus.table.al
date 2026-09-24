table 50100 "Serveez Campus"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Code';
            NotBlank = true;

        }
        field(2; Name; Text[100])
        {

        }
        field(3; Address; Text[200])
        {

        }
        field(4; "Phone Number"; Text[30])
        {

        }
        field(5; Email; Text[100])
        {

        }
        field(6; Active; Boolean)
        {

        }
    }

    keys
    {
        key(Key1; Code)
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