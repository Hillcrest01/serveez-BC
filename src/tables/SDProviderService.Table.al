table 50122 "SD Provider Service"
{
    Caption = 'Serveez Provider Service';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Provider No."; Code[20])
        {
            Caption = 'Provider No.';
            TableRelation = "SD Service Provider"."Provider No.";
        }

        field(2; "Service Code"; Code[20])
        {
            Caption = 'Service Code';
            TableRelation = "SD Service".Code;
        }

        field(3; Active; Boolean)
        {
            Caption = 'Active';
        }

        field(4; "Created At"; DateTime)
        {
            Caption = 'Created At';
        }

        field(5; "Modified At"; DateTime)
        {
            Caption = 'Modified At';
        }
    }

    keys
    {
        key(PK; "Provider No.", "Service Code")
        {
            Clustered = true;
        }

        key(Service; "Service Code")
        {
        }

        key(Active; Active)
        {
        }
    }
}