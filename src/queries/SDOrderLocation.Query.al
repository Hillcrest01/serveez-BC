query 50110 "SD Order Location Query"
{
    Caption = 'Serveez Order Locations';

    elements
    {
        dataitem(OrderLocation; "SD Order Location")
        {
            column(OrderNo; "Order No.")
            {
            }

            column(CampusCode; "Campus Code")
            {
            }

            column(Resident; Resident)
            {
            }

            column(Estate; Estate)
            {
            }

            column(Room; Room)
            {
            }

            column(PickupPointCode; "Pickup Point Code")
            {
            }

            column(PickupPointName; "Pickup Point Name")
            {
            }

            column(DeliveryAddress; "Delivery Address")
            {
            }

            column(LocationNotes; "Location Notes")
            {
            }

            column(CreatedAt; "Created At")
            {
            }
        }
    }
}