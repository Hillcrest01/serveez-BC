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
                group("Order Management")
                {
                    action("Portal Order List")
                    {
                        ApplicationArea = All;
                        RunObject = page "SD Portal Order List";
                    }
                    action("Order Placement Test")
                    {
                        ApplicationArea = All;
                        RunObject = page "SD Test Console";
                    }
                    action("Order Fulfillment List")
                    {
                        ApplicationArea = All;
                        RunObject = page "SD Order Fulfillment List";
                    }
                    action("Delivery List")
                    {
                        ApplicationArea = All;
                        RunObject = page "SD Delivery List";
                    }
                    action("Delivery Persons")
                    {
                        ApplicationArea = All;
                        RunObject = page "SD Delivery Person List";
                    }
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