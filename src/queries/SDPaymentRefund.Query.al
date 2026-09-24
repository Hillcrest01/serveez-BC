query 50122 "SD Payment Refund Query"
{
    Caption = 'Serveez Payment Refunds';

    elements
    {
        dataitem(Refund; "SD Payment Refund")
        {
            column(RefundNo; "Refund No.")
            {
            }

            column(PaymentNo; "Payment No.")
            {
            }

            column(OrderNo; "Order No.")
            {
            }

            column(Amount; Amount)
            {
            }

            column(Status; Status)
            {
            }

            column(RefundProvider; "Refund Provider")
            {
            }

            column(ProviderRefundID; "Provider Refund ID")
            {
            }

            column(ProviderReference; "Provider Reference")
            {
            }

            column(Reason; Reason)
            {
            }

            column(GatewayResponse; "Gateway Response")
            {
            }

            column(CreatedAt; "Created At")
            {
            }

            column(ModifiedAt; "Modified At")
            {
            }

            column(ProcessedAt; "Processed At")
            {
            }
        }
    }
}