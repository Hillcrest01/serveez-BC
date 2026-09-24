query 50114 "SD Notification Query"
{
    Caption = 'Serveez Notifications';

    elements
    {
        dataitem(Notification; "SD Notification")
        {
            column(NotificationNo; "Notification No.")
            {
            }

            column(CustomerNo; "Customer No.")
            {
            }

            column(OrderNo; "Order No.")
            {
            }

            column(Type; Type)
            {
            }

            column(Title; Title)
            {
            }

            column(Message; Message)
            {
            }

            column(IsRead; "Is Read")
            {
            }

            column(CreatedAt; "Created At")
            {
            }

            column(ReadAt; "Read At")
            {
            }
        }
    }
}