query 50123 "SD Provider Fulfillment Query"
{
    Caption = 'Serveez Provider Fulfillments';

    elements
    {
        dataitem(Fulfillment; "SD Order Fulfillment")
        {
            DataItemTableFilter = "Service Code" = FILTER(<> '');

            column(FulfillmentNo; "Fulfillment No.")
            {
            }

            column(OrderNo; "Order No.")
            {
            }

            column(OrderLineNo; "Order Line No.")
            {
            }

            column(ServiceCode; "Service Code")
            {
            }

            column(ProviderNo; "Provider No.")
            {
            }

            column(AssignedTo; "Assigned To")
            {
            }

            column(Description; Description)
            {
            }

            column(Quantity; Quantity)
            {
            }

            column(Status; Status)
            {
            }

            column(StartedAt; "Started At")
            {
            }

            column(ReadyAt; "Ready At")
            {
            }

            column(CompletedAt; "Completed At")
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