query 50118 "SD Order Summary Query"
{
    Caption = 'Serveez Order Summary';

    elements
    {
        dataitem(PortalOrder; "SD Portal Order")
        {
            column(CustomerNo; "Customer No.")
            {
            }

            // column(OrderCount; "Order No.")
            // {
            //     Method = Count;
            // }

            column(TotalOrdersAmount; "Total Amount")
            {
                Method = Sum;
            }

            column(TotalAmountPaid; "Amount Paid")
            {
                Method = Sum;
            }

            column(TotalAmountDue; "Amount Due")
            {
                Method = Sum;
            }
        }
    }
}