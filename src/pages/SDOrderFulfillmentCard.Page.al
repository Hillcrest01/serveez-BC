page 50123 "SD Order Fulfillment Card"
{
    Caption = 'Order Fulfillment';
    PageType = Card;
    SourceTable = "SD Order Fulfillment";
    ApplicationArea = All;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Fulfillment';

                field("Fulfillment No."; Rec."Fulfillment No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Order Line No."; Rec."Order Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }

            group(Assignment)
            {
                Caption = 'Assignment';

                field("Provider No."; Rec."Provider No.")
                {
                    ApplicationArea = All;
                }

                field("Assigned To"; Rec."Assigned To")
                {
                    ApplicationArea = All;
                }
            }

            group(Timestamps)
            {
                Caption = 'Progress';

                field("Started At"; Rec."Started At")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Ready At"; Rec."Ready At")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Completed At"; Rec."Completed At")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Created At"; Rec."Created At")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Modified At"; Rec."Modified At")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group("Fulfillment Notes")
            {
                Caption = 'Notes';

                field(Notes; Rec.Notes)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
        }
    }

    actions
    {

        area(Processing)
        {
            action(AssignServiceProvider)
            {
                Caption = 'Assign Service Provider';
                ApplicationArea = All;
                trigger OnAction()
                var
                    ServiceProvider: Record Vendor;
                    FulfillmentMgt: Codeunit "SD Fulfillment Management";
                begin
                    Rec.TestField("Fulfillment No.");
                    if Page.RunModal(
                        Page::"Vendor List", ServiceProvider
                    ) = Action::LookupOK
                    then begin
                        FulfillmentMgt.AssignFulfillment(
                            Rec."Fulfillment No.",
                            '',
                            ServiceProvider."No."
                        );
                        CurrPage.Update(false);
                        FulfillmentMgt.AcceptFulfillment(Rec."Fulfillment No.");
                        FulfillmentMgt.StartFulfillment(Rec."Fulfillment No.");
                        FulfillmentMgt.MarkReady(Rec."Fulfillment No.");
                        Message(
                'Service provider %1 has been assigned to fulfillment %2.',
                ServiceProvider.Name,
                Rec."Fulfillment No.");
                    end;
                end;
            }

            action(CreateDelivery)
            {
                Caption = 'Create Delivery';
                ApplicationArea = All;
                Image = Create;
                trigger OnAction()
                var
                    DeliveryManagement: Codeunit "SD Delivery Management";
                    PickupPoint: Record "SD Pickup Point";
                    Delivery: Record "SD Delivery";
                    Order: Record "SD Portal Order";
                    CustomerProfile: Record "SD Customer Profile";
                    PickupPointCode: Code[50];
                    PickupPointLocation: Text[250];
                    Destination: Text[250];
                    DeliveryNo: Code[50];

                    ServiceProvider: Record "SD Service Provider";
                    FulfillmentMgt: Codeunit "SD Fulfillment Management";

                    DeliveryPerson: Record "SD Delivery Person";
                begin
                    Rec.TestField("Order No.");
                    Rec.TestField("Fulfillment No.");

                    Delivery.Reset();
                    Delivery.SetRange("Fulfillment No.", Rec."Fulfillment No.");
                    if Delivery.FindFirst() then
                        Error('Delivery already exists for fulfillment %1', Rec."Fulfillment No.");

                    Order.Reset();
                    Order.SetRange("Order No.", Rec."Order No.");
                    if not Order.FindFirst() then
                        Error('Order %1 associated with fulfillment %2 could not be found ', Rec."Order No.", Rec."Fulfillment No.");

                    Order.TestField("Customer No.");
                    CustomerProfile.Reset();
                    CustomerProfile.SetRange("Customer No.", Order."Customer No.");
                    if not CustomerProfile.FindFirst() then
                        Error('Customer %1 associated with order %2 could not be found', Order."Customer No.", Rec."Order No.");
                    CustomerProfile.TestField("Preferred Pickup Point");
                    PickupPointCode := CustomerProfile."Preferred Pickup Point";
                    if not PickupPoint.Get(PickupPointCode) then
                        Error('Pickup point %1 could not be found', PickupPointCode);
                    PickupPointLocation := CopyStr(PickupPoint.Name, 1, MaxStrLen(PickupPointLocation));
                    Destination := CopyStr(StrSubstNo('%1, Room %2', CustomerProfile.Estate, CustomerProfile.Room), 1, MaxStrLen(Destination));

                    DeliveryNo := DeliveryManagement.CreateDelivery(
                        Rec."Order No.",
                        Rec."Fulfillment No.",
                        PickupPointCode,
                        PickupPointLocation,
                        Destination
                    );
                    if DeliveryNo = '' then
                        Error('Delivery could not be created');
                    Message('Delivery successfully created.\Delivery No: %1', DeliveryNo);

                end;
            }

            action(AssignDelivery)
            {
                Caption = 'Assign Delivery Person';
                trigger OnAction()
                var
                    DeliveryPerson: Record "SD Delivery Person";
                    DeliveryManagement: Codeunit "SD Delivery Management";
                    DeliveryRecord: Record "SD Delivery";
                    DeliveryNo: Code[20];
                begin
                    DeliveryRecord.Reset();
                    DeliveryRecord.SetRange("Fulfillment No.", Rec."Fulfillment No.");

                    if not DeliveryRecord.FindFirst() then
                        Error('Delivery could not be found for this fulfillment');
                    DeliveryNo := DeliveryRecord."Delivery No.";
                    DeliveryPerson.Reset();
                    DeliveryPerson.SetRange(Active, true);
                    if Page.RunModal(
                        Page::"SD Delivery Person List", DeliveryPerson
                    ) = Action::LookupOK
                    then begin
                        DeliveryManagement.AssignDelivery(
                            DeliveryNo,
                            DeliveryPerson."Delivery Person No."
                        );
                        CurrPage.Update(false);
                        DeliveryManagement.AcceptDelivery(DeliveryNo);
                        DeliveryManagement.StartDeliveryToPickup(DeliveryNo);
                        DeliveryManagement.ArrivedAtPickup(DeliveryNo);
                    end;
                end;
            }
            action(DeliveryPickedUp)
            {
                Caption = 'Start Delivery';
                ApplicationArea = All;

                trigger OnAction()
                var
                    DeliveryMgt: Codeunit "SD Delivery Management";
                    DeliveryRecord: Record "SD Delivery";
                begin
                    DeliveryRecord.Reset();
                    DeliveryRecord.SetRange("Fulfillment No.", Rec."Fulfillment No.");
                    if not DeliveryRecord.FindFirst() then
                        Error('The delivery associated with this fulfillment could not be located');
                    DeliveryRecord.TestField("Delivery No.");
                    DeliveryMgt.MarkPickedUp(DeliveryRecord."Delivery No.");
                    DeliveryMgt.StartDeliveryToDestination(DeliveryRecord."Delivery No.");
                    Message('Delivery started successfully for fulfillment %1', Rec."Fulfillment No.");
                end;
            }

            action(CompleteDelivery)
            {
                Caption = 'Complete Delivery';
                ApplicationArea = All;

                trigger OnAction()
                var
                    DeliveryMgt: Codeunit "SD Delivery Management";
                    DeliveryRecord: Record "SD Delivery";
                    ProofOfDelivery: Text[250];
                begin
                    DeliveryRecord.Reset();
                    DeliveryRecord.SetRange("Fulfillment No.", Rec."Fulfillment No.");
                    if not DeliveryRecord.FindFirst() then
                        Error('The delivery associated with this fulfillment could not be located');
                    DeliveryRecord.TestField("Delivery No.");
                    DeliveryMgt.ArriveAtDestination(DeliveryRecord."Delivery No.");
                    DeliveryMgt.MarkDelivered(DeliveryRecord."Delivery No.", 'Delivered Successfully');
                    Message('Delivery successfully delivered for fulfillment %1', Rec."Fulfillment No.");
                end;
            }

            action(CompleteDeliveryAndMarkPaid)
            {
                Caption = 'Confirm Payment & Complete';
                ApplicationArea = All;

                trigger OnAction()
                var
                    DeliveryMgt: Codeunit "SD Delivery Management";
                    DeliveryRecord: Record "SD Delivery";
                    Payment: Record "SD Payment";
                begin
                    Payment.Reset();
                    Payment.SetRange("Order No.", Rec."Order No.");
                    if not Payment.FindFirst() then
                        Error('Payment cannot be found for order %1', Rec."Order No.");
                    DeliveryRecord.Reset();
                    DeliveryRecord.SetRange("Fulfillment No.", Rec."Fulfillment No.");
                    if not DeliveryRecord.FindFirst() then
                        Error('The delivery associated with this fulfillment could not be located');
                    DeliveryRecord.TestField("Delivery No.");
                    DeliveryMgt.CompleteDelivery(DeliveryRecord."Delivery No.");
                    Message('Delivery complete for fulfillment %1', Rec."Fulfillment No.");
                end;
            }

            action(OpenDelivery)
            {
                Caption = 'Open Delivery';
                ApplicationArea = All;
                Image = View;

                trigger OnAction()
                var
                    Delivery: Record "SD Delivery";
                begin
                    Delivery.Reset();
                    Delivery.SetRange("Fulfillment No.", Rec."Fulfillment No.");
                    if not Delivery.FindFirst() then
                        Error('No delivery exist for fulfillment %1', Rec."Fulfillment No.");

                    Page.Run(
                        Page::"SD Delivery Card", Delivery
                    );
                end;
            }
        }
    }


}