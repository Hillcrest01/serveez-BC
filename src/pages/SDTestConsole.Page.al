page 50128 "SD Test Console"
{
    Caption = 'Serveez Test Console';
    PageType = Card;
    SourceTable = "Serveez Campus";
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(Test)
            {
                Caption = 'Order Testing';

                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Default Campus Code"; Rec.Code)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(CreateTestOrder)
            {
                Caption = 'Create Test Order';
                ApplicationArea = All;

                trigger OnAction()
                var
                    TestOrder: Codeunit "SD Test Order";
                begin
                    TestOrder.CreateTestOrder();
                end;
            }
            action("Add Test Service")
            {
                Caption = 'Add Test Service';
                ApplicationArea = All;

                trigger OnAction()
                var
                    TestOrder: Codeunit "SD Test Order";
                begin
                    TestOrder.AddTestServiceLine();
                end;
            }
            action("Add Test Product")
            {
                Caption = 'Add Test Product';
                ApplicationArea = All;

                trigger OnAction()
                var
                    TestOrder: Codeunit "SD Test Order";
                begin
                    TestOrder.AddTestProductLine();
                end;
            }
            action("Submit Test Order")
            {
                Caption = 'Submit Test Order';
                ApplicationArea = All;

                trigger OnAction()
                var
                    TestOrder: Codeunit "SD Test Order";
                begin
                    TestOrder.SubmitTestOrder();
                end;
            }
            action(CreateTestDelivery)
            {
                Caption = 'Create Test Delivery';
                ApplicationArea = All;

                trigger OnAction()
                var
                    TestOrder: Codeunit "SD Test Order";
                begin
                    TestOrder.CreateTestDelivery();
                end;
            }
            action(AssignTestDelivery)
            {
                Caption = 'Assign Test Delivery';
                ApplicationArea = All;

                trigger OnAction()
                var
                    TestOrder: Codeunit "SD Test Order";
                begin
                    TestOrder.AssignTestDelivery();
                end;
            }

            action("Accept Delivery")
            {
                Caption = 'Accept Test Delivery';
                ApplicationArea = All;

                trigger OnAction()
                var
                    TestOrder: Codeunit "SD Test Order";
                begin
                    TestOrder.AcceptDelivery();
                end;
            }
            action("StartDeliveryToPickup")
            {
                Caption = 'Start Delivery';
                ApplicationArea = All;

                trigger OnAction()
                var
                    TestOrder: Codeunit "SD Test Order";
                begin
                    TestOrder.StartDeliveryToPickup();
                end;
            }
            action(StartTestDeliveryToPickup)
            {
                Caption = 'Start Delivery to Pickup';
                ApplicationArea = All;

                trigger OnAction()
                var
                    TestOrder: Codeunit "SD Test Order";
                begin
                    TestOrder.StartTestDeliveryToPickup();
                end;
            }
            action(ArriveTestDeliveryAtPickup)
            {
                Caption = 'Arrive at Pickup';
                ApplicationArea = All;

                trigger OnAction()
                var
                    TestOrder: Codeunit "SD Test Order";
                begin
                    TestOrder.ArriveTestDeliveryAtPickup();
                end;
            }
            action(PickUpTestDelivery)
            {
                Caption = 'Mark Delivery Picked Up';
                ApplicationArea = All;

                trigger OnAction()
                var
                    TestOrder: Codeunit "SD Test Order";
                begin
                    TestOrder.PickUpTestDelivery();
                end;
            }

            action(StartTestDeliveryToDestination)
            {
                Caption = 'Start Delivery to Destination';
                ApplicationArea = All;

                trigger OnAction()
                var
                    TestOrder: Codeunit "SD Test Order";
                begin
                    TestOrder.StartTestDeliveryToDestination();
                end;
            }

            action(ArriveTestDeliveryAtDestination)
            {
                Caption = 'Arrive at Destination';
                ApplicationArea = All;

                trigger OnAction()
                var
                    TestOrder: Codeunit "SD Test Order";
                begin
                    TestOrder.ArriveTestDeliveryAtDestination();
                end;
            }
            action(DeliverTestDelivery)
            {
                Caption = 'Mark Delivery Delivered';
                ApplicationArea = All;

                trigger OnAction()
                var
                    TestOrder: Codeunit "SD Test Order";
                begin
                    TestOrder.DeliverTestDelivery();
                end;
            }
            action(CompleteTestDelivery)
            {
                Caption = 'Complete Delivery';
                ApplicationArea = All;

                trigger OnAction()
                var
                    TestOrder: Codeunit "SD Test Order";
                begin
                    TestOrder.CompleteTestDelivery();
                end;
            }
            action(CreateTestPayment)
            {
                Caption = 'Create Test Payment';
                ApplicationArea = All;

                trigger OnAction()
                var
                    TestOrder: Codeunit "SD Test Order";
                begin
                    TestOrder.CreateTestPayment();
                end;
            }
            action(CompleteTestPayment)
            {
                Caption = 'Complete Test Payment';
                ApplicationArea = All;

                trigger OnAction()
                var
                    TestOrder: Codeunit "SD Test Order";
                begin
                    TestOrder.CompleteTestPayment();
                end;
            }
            action(CreateSecondTestPayment)
            {
                Caption = 'Create Second Test Payment';
                ApplicationArea = All;

                trigger OnAction()
                var
                    TestOrder: Codeunit "SD Test Order";
                begin
                    TestOrder.CreateSecondTestPayment();
                end;
            }
            action(CompleteSecondTestPayment)
            {
                Caption = 'Complete Second Test Payment';
                ApplicationArea = All;

                trigger OnAction()
                var
                    TestOrder: Codeunit "SD Test Order";
                begin
                    TestOrder.CompleteSecondTestPayment();
                end;
            }
            action(CreateTestBCSalesOrder)
            {
                Caption = 'Create BC Sales Order';
                ApplicationArea = All;

                trigger OnAction()
                var
                    TestOrder: Codeunit "SD Test Order";
                begin
                    TestOrder.CreateTestBCSalesOrder();
                end;
            }
            action(CreateTestPortalAccount)
            {
                Caption = 'Create Test Portal Account';
                ApplicationArea = All;

                trigger OnAction()
                var
                    TestOrder: Codeunit "SD Test Order";
                begin
                    TestOrder.CreateTestPortalAccount();
                end;
            }
            action(VerifyTestPortalAccount)
            {
                Caption = 'Verify Test Portal Account';
                ApplicationArea = All;

                trigger OnAction()
                var
                    TestOrder: Codeunit "SD Test Order";
                begin
                    TestOrder.VerifyTestPortalAccount();
                end;
            }
            action(CreateTestPartialRefund)
            {
                Caption = 'Create Test Partial Refund';
                ApplicationArea = All;

                trigger OnAction()
                var
                    TestOrder: Codeunit "SD Test Order";
                begin
                    TestOrder.CreateTestPartialRefund();
                end;
            }
            action(CompleteTestPartialRefund)
            {
                Caption = 'Complete Test Partial Refund';
                ApplicationArea = All;

                trigger OnAction()
                var
                    TestOrder: Codeunit "SD Test Order";
                begin
                    TestOrder.CompleteTestPartialRefund();
                end;
            }
            action(CreateRemainingRefund)
            {
                Caption = 'Create Remaining Refund';
                ApplicationArea = All;

                trigger OnAction()
                var
                    TestOrder: Codeunit "SD Test Order";
                begin
                    TestOrder.CreateRemainingRefund();
                end;
            }
            action(CompleteRemainingRefund)
            {
                Caption = 'Complete Remaining Refund';
                ApplicationArea = All;

                trigger OnAction()
                var
                    TestOrder: Codeunit "SD Test Order";
                begin
                    TestOrder.CompleteRemainingRefund();
                end;
            }
            action(TestOverRefund)
            {
                Caption = 'Test Over Refund';
                ApplicationArea = All;

                trigger OnAction()
                var
                    TestOrder: Codeunit "SD Test Order";
                begin
                    TestOrder.TestOverRefund();
                end;
            }

            action(TestServicePricing)
            {
                Caption = 'Test pricing setup';
                ApplicationArea = All;

                trigger OnAction()
                var
                    TestOrder: Codeunit "SD Test Order";
                begin
                    TestOrder.TestPricing();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get('SETUP') then begin
            Rec.Init();
            Rec.Code := 'SETUP';
            Rec.Insert(true);
        end;
    end;
}