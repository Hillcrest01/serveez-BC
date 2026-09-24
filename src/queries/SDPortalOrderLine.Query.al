query 50109 "SD Portal Order Line Query"
{
    Caption = 'Serveez Portal Order Lines';

    elements
    {
        dataitem(OrderLine; "SD Portal Order Line")
        {
            column(OrderNo; "Order No.")
            {
            }

            column(LineNo; "Line No.")
            {
            }

            column(LineType; "Line Type")
            {
            }

            column(ServiceCode; "Service Code")
            {
            }

            column(ItemNo; "Item No.")
            {
            }

            column(Description; Description)
            {
            }

            column(Quantity; Quantity)
            {
            }

            column(UnitPrice; "Unit Price")
            {
            }

            column(Amount; Amount)
            {
            }

            column(CustomerNotes; "Customer Notes")
            {
            }
        }
    }
}