query 50113 "SD Payment Query"
{
    Caption = 'Serveez Payments';

    elements
    {
        dataitem(Payment; "SD Payment")
        {
            column(PaymentNo; "Payment No.")
            {
            }

            column(OrderNo; "Order No.")
            {
            }

            column(BCDocumentNo; "BC Document No.")
            {
            }

            column(PaymentProvider; "Payment Provider")
            {
            }

            column(ProviderTransactionID; "Provider Transaction ID")
            {
            }

            column(ProviderReference; "Provider Reference")
            {
            }

            column(Amount; Amount)
            {
            }

            column(Currency; Currency)
            {
            }

            column(Status; Status)
            {
            }

            column(TransactionDate; "Transaction Date")
            {
            }

            column(CreatedAt; "Created At")
            {
            }

            column(ModifiedAt; "Modified At")
            {
            }
        }
    }
}