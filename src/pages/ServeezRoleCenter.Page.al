page 50105 "Serveez Role Center"
{
    PageType = RoleCenter;
    ApplicationArea = All;
    // UsageCategory = Administration;

    layout
    {
        area(RoleCenter)
        {
        }
    }

    actions
    {
        area(Sections)
        {
            group("General Setups")
            {
                action("View All Campuses")
                {
                    ApplicationArea = All;
                    RunObject = page "Serveez Campus";
                }
                action("Serveez Setup")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Setups Page";
                }
                action("Service Categories")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Service Category List";
                }
                action("Services")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Service List";
                }
                action("Service Providers")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Service Provider List";
                }
                action("Product Category")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Product Category List";
                }
                action("Product List")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Product List";
                }

            }

            group("Order Management")
            {
                action("All Orders")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Portal Order List";
                }
                action("Submitted Orders")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Portal Order List";
                    RunPageView = where("Order Status" = filter(Submitted));
                }
                action("Orders in Progress")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Portal Order List";
                    RunPageView = where("Order Status" = filter("InProgress"));
                }
                action("Completed Orders")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Portal Order List";
                    RunPageView = where("Order Status" = filter("Completed"));
                }
                action("Closed Orders")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Portal Order List";
                    RunPageView = where("Order Status" = filter("Closed"));
                }
                action("Rejected Orders")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Portal Order List";
                    RunPageView = where("Order Status" = filter("Rejected"));
                }
                action("Cancelled Orders")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Portal Order List";
                    RunPageView = where("Order Status" = filter("Cancelled"));
                }
                action("Delivery Persons")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Delivery Person List";
                }

            }

            group(fulfillment)
            {
                action("All")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Order Fulfillment List";
                }
                action("Not Started")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Order Fulfillment List";
                    RunPageView = where(Status = filter("NotStarted"));
                }
                action("Assigned")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Order Fulfillment List";
                    RunPageView = where(Status = filter("Assigned"));
                }
                action("Accepted")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Order Fulfillment List";
                    RunPageView = where(Status = filter("Accepted"));
                }
                action("In Progress")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Order Fulfillment List";
                    RunPageView = where(Status = filter("InProgress"));
                }
                action("Ready")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Order Fulfillment List";
                    RunPageView = where(Status = filter(Ready));
                }
                action("Out for Delivery")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Order Fulfillment List";
                    RunPageView = where(Status = filter("OutForDelivery"));
                }
                action("Delivered")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Order Fulfillment List";
                    RunPageView = where(Status = filter(Delivered));
                }
                action("Completed")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Order Fulfillment List";
                    RunPageView = where(Status = filter(Completed));
                }
                action("Cancelled")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Order Fulfillment List";
                    RunPageView = where(Status = filter("Cancelled"));
                }

            }
            group(delivery)
            {
                action("Delivery List")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Delivery List";
                }
                action("Created")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Delivery List";
                    RunPageView = where(Status = filter(Created));
                }
                action("Del. Assigned")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Delivery List";
                    RunPageView = where(Status = filter(Assigned));
                }
                action("En Route to Destination")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Delivery List";
                    RunPageView = where(Status = filter(EnRouteToDestination));
                }
                action("Del. Delivered")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Delivery List";
                    RunPageView = where(Status = filter(Delivered));
                }
                action("Del. Completed")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Delivery List";
                    RunPageView = where(Status = filter(Completed));
                }
                action("Declined")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Delivery List";
                    RunPageView = where(Status = filter(Declined));
                }
                action("Failed")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Delivery List";
                    RunPageView = where(Status = filter(Failed));
                }


            }
            group("Portal Users")
            {
                action("All Portal Users")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Portal Account List";
                }
            }
            group("Customer Profiles")
            {
                action("All Customers")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Customer Profile List";
                }
                action("All pickup points")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Pickup Point List";
                }
            }
            group(Payments)
            {
                action("All Payments")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Payment List";
                }
                action("Payment Refund List")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Payment Refund List";
                }
                action("Delivery Pricing")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Delivery List";
                }
            }
            group("Notifications & Support")
            {
                action("All Notifications")
                {
                    ApplicationArea = All;
                    RunObject = page "SD Notification List";
                }
                action(Support)
                {
                    ApplicationArea = All;
                    RunObject = page "SD Support Request List";
                }
            }

        }
    }

    var
        myInt: Integer;
}