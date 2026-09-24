codeunit 50101 "SD Fulfillment Management"
{
    // Caption = 'Serveez Fulfillment Management';

    procedure CreateFulfillment(
        OrderNo: Code[20];
        OrderLineNo: Integer): Code[20]
    var
        PortalOrder: Record "SD Portal Order";
        OrderLine: Record "SD Portal Order Line";
        Fulfillment: Record "SD Order Fulfillment";
        FulfillmentNo: Code[20];
    begin
        if not PortalOrder.Get(OrderNo) then
            Error('Order %1 does not exist.', OrderNo);

        if PortalOrder."Order Status" <> PortalOrder."Order Status"::Submitted then
            Error('Fulfillment can only be created for a submitted order.');

        if not OrderLine.Get(OrderNo, OrderLineNo) then
            Error('Order line %1 for order %2 does not exist.', OrderLineNo, OrderNo);

        if FulfillmentExists(OrderNo, OrderLineNo) then
            Error(
                'Fulfillment already exists for order %1, line %2.',
                OrderNo,
                OrderLineNo);

        FulfillmentNo := GetNextFulfillmentNo();

        Fulfillment.Init();
        Fulfillment."Fulfillment No." := FulfillmentNo;
        Fulfillment."Order No." := OrderNo;
        Fulfillment."Order Line No." := OrderLineNo;

        if OrderLine."Line Type" = OrderLine."Line Type"::Service then
            Fulfillment."Service Code" := OrderLine."Service Code"
        else
            Fulfillment."Item No." := OrderLine."Item No.";

        Fulfillment.Description := OrderLine.Description;
        Fulfillment.Quantity := OrderLine.Quantity;
        Fulfillment.Status := Fulfillment.Status::NotStarted;
        Fulfillment."Created At" := CurrentDateTime();
        Fulfillment."Modified At" := CurrentDateTime();

        Fulfillment.Insert(true);

        exit(FulfillmentNo);
    end;

    // procedure AssignFulfillment(
    //     FulfillmentNo: Code[20];
    //     AssignedTo: Code[20];
    //     ProviderNo: Code[20])
    // var
    //     Fulfillment: Record "SD Order Fulfillment";
    // begin
    //     GetFulfillment(Fulfillment, FulfillmentNo);

    //     if Fulfillment.Status <> Fulfillment.Status::NotStarted then
    //         Error('Fulfillment %1 is not available for assignment.', FulfillmentNo);

    //     // if AssignedTo = '' and ProviderNo = '' then
    //     //     Error('An assigned person or provider is required.');

    //     Fulfillment."Assigned To" := AssignedTo;
    //     Fulfillment."Provider No." := ProviderNo;
    //     Fulfillment.Status := Fulfillment.Status::Assigned;
    //     Fulfillment."Modified At" := CurrentDateTime();

    //     Fulfillment.Modify(true);
    //     UpdateOrderFulfillmentStatus(Fulfillment."Order No.");
    // end;

    procedure AssignFulfillment(
    FulfillmentNo: Code[20];
    AssignedTo: Code[20];
    ProviderNo: Code[20])
    var
        Fulfillment: Record "SD Order Fulfillment";
        Provider: Record "SD Service Provider";
        ProviderService: Record "SD Provider Service";
    begin
        GetFulfillment(
            Fulfillment,
            FulfillmentNo);

        if Fulfillment.Status <> Fulfillment.Status::NotStarted then
            Error(
                'Fulfillment %1 is not available for assignment.',
                FulfillmentNo);

        if Fulfillment."Service Code" <> '' then begin
            if ProviderNo <> '' then begin
                if not Provider.Get(ProviderNo) then
                    Error(
                        'Provider %1 does not exist.',
                        ProviderNo);

                if not Provider.Active then
                    Error(
                        'Provider %1 is not active.',
                        ProviderNo);

                if not ProviderService.Get(
                    ProviderNo,
                    Fulfillment."Service Code")
                then
                    Error(
                        'Provider %1 is not configured for service %2.',
                        ProviderNo,
                        Fulfillment."Service Code");

                if not ProviderService.Active then
                    Error(
                        'Provider %1 is inactive for service %2.',
                        ProviderNo,
                        Fulfillment."Service Code");
            end;
        end
        else
            if ProviderNo <> '' then begin
                if not Provider.Get(ProviderNo) then
                    Error(
                        'Provider %1 does not exist.',
                        ProviderNo);

                if not Provider.Active then
                    Error(
                        'Provider %1 is not active.',
                        ProviderNo);
            end;

        Fulfillment."Assigned To" := AssignedTo;
        Fulfillment."Provider No." := ProviderNo;
        Fulfillment.Status := Fulfillment.Status::Assigned;
        Fulfillment."Modified At" := CurrentDateTime();

        Fulfillment.Modify(true);

        UpdateOrderFulfillmentStatus(
            Fulfillment."Order No.");
    end;

    procedure AcceptFulfillment(FulfillmentNo: Code[20])
    var
        Fulfillment: Record "SD Order Fulfillment";
    begin
        GetFulfillment(Fulfillment, FulfillmentNo);

        if Fulfillment.Status <> Fulfillment.Status::Assigned then
            Error('Only assigned fulfillment can be accepted.');

        Fulfillment.Status := Fulfillment.Status::Accepted;
        Fulfillment."Modified At" := CurrentDateTime();

        Fulfillment.Modify(true);
        UpdateOrderFulfillmentStatus(Fulfillment."Order No.");
    end;

    procedure StartFulfillment(FulfillmentNo: Code[20])
    var
        Fulfillment: Record "SD Order Fulfillment";
    begin
        GetFulfillment(Fulfillment, FulfillmentNo);

        // if Fulfillment.Status <> Fulfillment.Status::Accepted then
        //     Error('Only accepted fulfillment can be started.');

        Fulfillment.Status := Fulfillment.Status::InProgress;
        Fulfillment."Started At" := CurrentDateTime();
        Fulfillment."Modified At" := CurrentDateTime();

        Fulfillment.Modify(true);
        UpdateOrderFulfillmentStatus(Fulfillment."Order No.");
    end;

    procedure MarkReady(FulfillmentNo: Code[20])
    var
        Fulfillment: Record "SD Order Fulfillment";
    begin
        GetFulfillment(Fulfillment, FulfillmentNo);

        if Fulfillment.Status <> Fulfillment.Status::InProgress then
            Error('Only fulfillment in progress can be marked as ready.');

        Fulfillment.Status := Fulfillment.Status::Ready;
        Fulfillment."Ready At" := CurrentDateTime();
        Fulfillment."Modified At" := CurrentDateTime();

        Fulfillment.Modify(true);
        UpdateOrderFulfillmentStatus(Fulfillment."Order No.");
    end;

    procedure MarkOutForDelivery(FulfillmentNo: Code[20])
    var
        Fulfillment: Record "SD Order Fulfillment";
    begin
        GetFulfillment(Fulfillment, FulfillmentNo);

        if Fulfillment.Status <> Fulfillment.Status::Ready then
            Error('Only ready fulfillment can be sent out for delivery.');

        Fulfillment.Status := Fulfillment.Status::OutForDelivery;
        Fulfillment."Modified At" := CurrentDateTime();

        Fulfillment.Modify(true);
        UpdateOrderFulfillmentStatus(Fulfillment."Order No.");
    end;

    procedure MarkDelivered(FulfillmentNo: Code[20])
    var
        Fulfillment: Record "SD Order Fulfillment";
    begin
        GetFulfillment(Fulfillment, FulfillmentNo);

        if Fulfillment.Status <> Fulfillment.Status::OutForDelivery then
            Error('Only fulfillment out for delivery can be marked as delivered.');

        Fulfillment.Status := Fulfillment.Status::Delivered;
        Fulfillment."Modified At" := CurrentDateTime();

        Fulfillment.Modify(true);
        UpdateOrderFulfillmentStatus(Fulfillment."Order No.");
    end;

    // procedure CompleteFulfillment(FulfillmentNo: Code[20])
    // var
    //     Fulfillment: Record "SD Order Fulfillment";
    // begin
    //     GetFulfillment(Fulfillment, FulfillmentNo);

    //     if Fulfillment.Status <> Fulfillment.Status::Delivered then
    //         Error('Only delivered fulfillment can be completed.');

    //     Fulfillment.Status := Fulfillment.Status::Completed;
    //     Fulfillment."Completed At" := CurrentDateTime();
    //     Fulfillment."Modified At" := CurrentDateTime();

    //     Fulfillment.Modify(true);
    //     UpdateOrderFulfillmentStatus(Fulfillment."Order No.");
    // end;

    procedure CompleteFulfillment(
    FulfillmentNo: Code[20])
    var
        Fulfillment: Record "SD Order Fulfillment";
        SettlementManagement: Codeunit "SD Settlement Management";
    begin
        GetFulfillment(
            Fulfillment,
            FulfillmentNo);

        if Fulfillment.Status <> Fulfillment.Status::Delivered then
            Error(
                'Only delivered fulfillment can be completed.');

        Fulfillment.Status := Fulfillment.Status::Completed;
        Fulfillment."Completed At" := CurrentDateTime();
        Fulfillment."Modified At" := CurrentDateTime();

        Fulfillment.Modify(true);

        UpdateOrderFulfillmentStatus(
            Fulfillment."Order No.");

        SettlementManagement.CreateSettlement(
            FulfillmentNo);
    end;

    procedure CancelFulfillment(FulfillmentNo: Code[20])
    var
        Fulfillment: Record "SD Order Fulfillment";
    begin
        GetFulfillment(Fulfillment, FulfillmentNo);

        if Fulfillment.Status = Fulfillment.Status::Completed then
            Error('Completed fulfillment cannot be cancelled.');

        if Fulfillment.Status = Fulfillment.Status::Cancelled then
            Error('Fulfillment %1 is already cancelled.', FulfillmentNo);

        Fulfillment.Status := Fulfillment.Status::Cancelled;
        Fulfillment."Modified At" := CurrentDateTime();

        Fulfillment.Modify(true);
        UpdateOrderFulfillmentStatus(Fulfillment."Order No.");
    end;

    local procedure GetFulfillment(
        var Fulfillment: Record "SD Order Fulfillment";
        FulfillmentNo: Code[20])
    begin
        if FulfillmentNo = '' then
            Error('Fulfillment number is required.');

        if not Fulfillment.Get(FulfillmentNo) then
            Error('Fulfillment %1 does not exist.', FulfillmentNo);
    end;

    local procedure FulfillmentExists(
        OrderNo: Code[20];
        OrderLineNo: Integer): Boolean
    var
        Fulfillment: Record "SD Order Fulfillment";
    begin
        Fulfillment.SetRange("Order No.", OrderNo);
        Fulfillment.SetRange("Order Line No.", OrderLineNo);

        exit(not Fulfillment.IsEmpty());
    end;

    local procedure GetNextFulfillmentNo(): Code[20]
    var
        Fulfillment: Record "SD Order Fulfillment";
        NextNumber: Integer;
        ExistingNo: Code[20];
    begin
        if Fulfillment.FindLast() then begin
            ExistingNo := Fulfillment."Fulfillment No.";

            if Evaluate(NextNumber, CopyStr(ExistingNo, 5)) then
                NextNumber += 1
            else
                NextNumber := 1;
        end
        else
            NextNumber := 1;

        exit('FUL-' + Format(NextNumber, 6, '<Integer,6><Filler Character,0>'));
    end;

    // local procedure UpdateOrderFulfillmentStatus(OrderNo: Code[20])
    // var
    //     PortalOrder: Record "SD Portal Order";
    //     Fulfillment: Record "SD Order Fulfillment";
    //     HasFulfillment: Boolean;
    //     HasAssigned: Boolean;
    //     HasAccepted: Boolean;
    //     HasInProgress: Boolean;
    //     HasReady: Boolean;
    //     HasOutForDelivery: Boolean;
    //     HasDelivered: Boolean;
    //     HasNotStarted: Boolean;
    //     AllCompleted: Boolean;
    // begin
    //     if not PortalOrder.Get(OrderNo) then
    //         exit;

    //     HasFulfillment := false;
    //     HasAssigned := false;
    //     HasAccepted := false;
    //     HasInProgress := false;
    //     HasReady := false;
    //     HasOutForDelivery := false;
    //     HasDelivered := false;
    //     HasNotStarted := false;
    //     AllCompleted := true;

    //     Fulfillment.Reset();
    //     Fulfillment.SetRange("Order No.", OrderNo);

    //     if Fulfillment.FindSet() then
    //         repeat
    //             HasFulfillment := true;

    //             case Fulfillment.Status of
    //                 Fulfillment.Status::NotStarted:
    //                     begin
    //                         HasNotStarted := true;
    //                         AllCompleted := false;
    //                     end;

    //                 Fulfillment.Status::Assigned:
    //                     begin
    //                         HasAssigned := true;
    //                         AllCompleted := false;
    //                     end;

    //                 Fulfillment.Status::Accepted:
    //                     begin
    //                         HasAccepted := true;
    //                         AllCompleted := false;
    //                     end;

    //                 Fulfillment.Status::InProgress:
    //                     begin
    //                         HasInProgress := true;
    //                         AllCompleted := false;
    //                     end;

    //                 Fulfillment.Status::Ready:
    //                     begin
    //                         HasReady := true;
    //                         AllCompleted := false;
    //                     end;

    //                 Fulfillment.Status::OutForDelivery:
    //                     begin
    //                         HasOutForDelivery := true;
    //                         AllCompleted := false;
    //                     end;

    //                 Fulfillment.Status::Delivered:
    //                     begin
    //                         HasDelivered := true;
    //                         AllCompleted := false;
    //                     end;

    //                 Fulfillment.Status::Completed:
    //                     begin
    //                     end;

    //                 Fulfillment.Status::Cancelled:
    //                     begin
    //                     end;
    //             end;
    //         until Fulfillment.Next() = 0;

    //     if not HasFulfillment then
    //         PortalOrder."Fulfillment Status" :=
    //             PortalOrder."Fulfillment Status"::NotStarted
    //     else
    //         if AllCompleted then
    //             PortalOrder."Fulfillment Status" :=
    //                 PortalOrder."Fulfillment Status"::Completed
    //         else
    //             if HasOutForDelivery then
    //                 PortalOrder."Fulfillment Status" :=
    //                     PortalOrder."Fulfillment Status"::OutForDelivery
    //             else
    //                 if HasDelivered then
    //                     PortalOrder."Fulfillment Status" :=
    //                         PortalOrder."Fulfillment Status"::Delivered
    //                 else
    //                     if HasReady then
    //                         PortalOrder."Fulfillment Status" :=
    //                             PortalOrder."Fulfillment Status"::Ready
    //                     else
    //                         if HasInProgress then
    //                             PortalOrder."Fulfillment Status" :=
    //                                 PortalOrder."Fulfillment Status"::InProgress
    //                         else
    //                             if HasAccepted then
    //                                 PortalOrder."Fulfillment Status" :=
    //                                     PortalOrder."Fulfillment Status"::Accepted
    //                             else
    //                                 if HasAssigned then
    //                                     PortalOrder."Fulfillment Status" :=
    //                                         PortalOrder."Fulfillment Status"::Assigned
    //                                 else
    //                                     if HasNotStarted then
    //                                         PortalOrder."Fulfillment Status" :=
    //                                             PortalOrder."Fulfillment Status"::NotStarted;

    //     PortalOrder."Modified At" := CurrentDateTime();
    //     PortalOrder.Modify(true);
    // end;

    local procedure UpdateOrderFulfillmentStatus(OrderNo: Code[20])
    var
        PortalOrder: Record "SD Portal Order";
        Fulfillment: Record "SD Order Fulfillment";
        HasFulfillment: Boolean;
        HasNotStarted: Boolean;
        HasAssigned: Boolean;
        HasAccepted: Boolean;
        HasInProgress: Boolean;
        HasReady: Boolean;
        HasOutForDelivery: Boolean;
        HasDelivered: Boolean;
        HasCompleted: Boolean;
        HasCancelled: Boolean;
        ActiveFulfillmentExists: Boolean;
        AllCancelled: Boolean;
    begin
        if not PortalOrder.Get(OrderNo) then
            exit;

        HasFulfillment := false;
        HasNotStarted := false;
        HasAssigned := false;
        HasAccepted := false;
        HasInProgress := false;
        HasReady := false;
        HasOutForDelivery := false;
        HasDelivered := false;
        HasCompleted := false;
        HasCancelled := false;
        ActiveFulfillmentExists := false;
        AllCancelled := true;

        Fulfillment.Reset();
        Fulfillment.SetRange("Order No.", OrderNo);

        if Fulfillment.FindSet() then
            repeat
                HasFulfillment := true;

                case Fulfillment.Status of
                    Fulfillment.Status::NotStarted:
                        begin
                            HasNotStarted := true;
                            ActiveFulfillmentExists := true;
                            AllCancelled := false;
                        end;

                    Fulfillment.Status::Assigned:
                        begin
                            HasAssigned := true;
                            ActiveFulfillmentExists := true;
                            AllCancelled := false;
                        end;

                    Fulfillment.Status::Accepted:
                        begin
                            HasAccepted := true;
                            ActiveFulfillmentExists := true;
                            AllCancelled := false;
                        end;

                    Fulfillment.Status::InProgress:
                        begin
                            HasInProgress := true;
                            ActiveFulfillmentExists := true;
                            AllCancelled := false;
                        end;

                    Fulfillment.Status::Ready:
                        begin
                            HasReady := true;
                            ActiveFulfillmentExists := true;
                            AllCancelled := false;
                        end;

                    Fulfillment.Status::OutForDelivery:
                        begin
                            HasOutForDelivery := true;
                            ActiveFulfillmentExists := true;
                            AllCancelled := false;
                        end;

                    Fulfillment.Status::Delivered:
                        begin
                            HasDelivered := true;
                            ActiveFulfillmentExists := true;
                            AllCancelled := false;
                        end;

                    Fulfillment.Status::Completed:
                        begin
                            HasCompleted := true;
                            AllCancelled := false;
                        end;

                    Fulfillment.Status::Cancelled:
                        begin
                            HasCancelled := true;
                        end;
                end;
            until Fulfillment.Next() = 0;

        if not HasFulfillment then begin
            PortalOrder."Fulfillment Status" :=
                PortalOrder."Fulfillment Status"::NotStarted;
        end
        else begin
            if ActiveFulfillmentExists then begin
                if HasOutForDelivery then
                    PortalOrder."Fulfillment Status" :=
                        PortalOrder."Fulfillment Status"::OutForDelivery
                else
                    if HasDelivered then
                        PortalOrder."Fulfillment Status" :=
                            PortalOrder."Fulfillment Status"::Delivered
                    else
                        if HasReady then
                            PortalOrder."Fulfillment Status" :=
                                PortalOrder."Fulfillment Status"::Ready
                        else
                            if HasInProgress then
                                PortalOrder."Fulfillment Status" :=
                                    PortalOrder."Fulfillment Status"::InProgress
                            else
                                if HasAccepted then
                                    PortalOrder."Fulfillment Status" :=
                                        PortalOrder."Fulfillment Status"::Accepted
                                else
                                    if HasAssigned then
                                        PortalOrder."Fulfillment Status" :=
                                            PortalOrder."Fulfillment Status"::Assigned
                                    else
                                        PortalOrder."Fulfillment Status" :=
                                            PortalOrder."Fulfillment Status"::NotStarted;

                if HasOutForDelivery or HasDelivered or HasReady or
                   HasInProgress then
                    PortalOrder."Order Status" :=
                        PortalOrder."Order Status"::InProgress
                else
                    if HasAccepted or HasAssigned then
                        PortalOrder."Order Status" :=
                            PortalOrder."Order Status"::Confirmed
                    else
                        PortalOrder."Order Status" :=
                            PortalOrder."Order Status"::Submitted;
            end
            else
                if AllCancelled or (HasCancelled and not HasCompleted) then begin
                    PortalOrder."Fulfillment Status" :=
                        PortalOrder."Fulfillment Status"::NotStarted;

                    PortalOrder."Order Status" :=
                        PortalOrder."Order Status"::Cancelled;
                end
                else begin
                    PortalOrder."Fulfillment Status" :=
                        PortalOrder."Fulfillment Status"::Completed;

                    PortalOrder."Order Status" :=
                        PortalOrder."Order Status"::Completed;
                end;
        end;

        PortalOrder."Modified At" := CurrentDateTime();
        PortalOrder.Modify(true);
    end;

}