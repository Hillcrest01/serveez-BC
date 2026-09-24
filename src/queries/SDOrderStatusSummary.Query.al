query 50119 "SD Order Status Summary Query"
{
    Caption = 'Serveez Order Status Summary';

    elements
    {
        dataitem(PortalOrder; "SD Portal Order")
        {
            column(OrderStatus; "Order Status")
            {
            }

            // column(OrderCount; "Order No.")
            // {
            //     Method = Count;
            // }
        }
    }
}