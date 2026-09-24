table 50105 "SD Service Category"
{
    Caption = 'Serveez Service Category';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }

        field(2; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }

        field(3; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }

        field(4; Active; Boolean)
        {
            Caption = 'Active';
            DataClassification = CustomerContent;
        }

        field(5; "Display Order"; Integer)
        {
            Caption = 'Display Order';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }

        key(Name; Name)
        {
        }

        key(DisplayOrder; "Display Order")
        {
        }
    }
}