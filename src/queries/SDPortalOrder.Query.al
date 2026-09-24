query 50108 "SD Portal Order Query"
{
    Caption = 'Serveez Portal Orders';

    elements
    {
        dataitem(PortalOrder; "SD Portal Order")
        {
            column(OrderNo; "Order No.")
            {
            }

            column(CustomerNo; "Customer No.")
            {
            }

            column(CampusCode; "Campus Code")
            {
            }

            column(OrderDate; "Order Date")
            {
            }

            column(OrderTime; "Order Time")
            {
            }

            column(OrderStatus; "Order Status")
            {
            }

            column(PaymentStatus; "Payment Status")
            {
            }

            column(FulfillmentStatus; "Fulfillment Status")
            {
            }

            column(Subtotal; Subtotal)
            {
            }

            column(DeliveryCharge; "Delivery Charge")
            {
            }

            column(TotalAmount; "Total Amount")
            {
            }

            column(AmountPaid; "Amount Paid")
            {
            }

            column(AmountDue; "Amount Due")
            {
            }

            column(BCSalesOrderNo; "BC Sales Order No.")
            {
            }

            column(CreatedAt; "Created At")
            {
            }

            column(ModifiedAt; "Modified At")
            {
            }

            column(CustomerNotes; "Customer Notes")
            {
            }
        }
    }
}