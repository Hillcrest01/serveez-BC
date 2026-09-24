codeunit 50108 "SD Support Request Management"
{
    // Caption = 'Serveez Support Request Management';

    procedure CreateSupportRequest(
        CustomerNo: Code[20];
        OrderNo: Code[20];
        Category: Option General,Order,Payment,Delivery,Fulfillment,Product,Service,Technical,Other;
        Priority: Option Low,Normal,High,Urgent;
        Subject: Text[150];
        Description: Text[250]): Code[20]
    var
        Customer: Record Customer;
        PortalOrder: Record "SD Portal Order";
        SupportRequest: Record "SD Support Request";
        SupportNo: Code[20];
    begin
        if CustomerNo = '' then
            Error('Customer number is required.');

        if not Customer.Get(CustomerNo) then
            Error('Customer %1 does not exist.', CustomerNo);

        if OrderNo <> '' then begin
            if not PortalOrder.Get(OrderNo) then
                Error('Order %1 does not exist.', OrderNo);

            if PortalOrder."Customer No." <> CustomerNo then
                Error(
                    'Order %1 does not belong to customer %2.',
                    OrderNo,
                    CustomerNo);
        end;

        if Subject = '' then
            Error('Support request subject is required.');

        if Description = '' then
            Error('Support request description is required.');

        SupportNo := GetNextSupportNo();

        SupportRequest.Init();
        SupportRequest."Support No." := SupportNo;
        SupportRequest."Customer No." := CustomerNo;
        SupportRequest."Order No." := OrderNo;
        SupportRequest.Category := Category;
        SupportRequest.Priority := Priority;
        SupportRequest.Status := SupportRequest.Status::Open;
        SupportRequest.Subject := Subject;
        SupportRequest.Description := Description;
        SupportRequest."Created At" := CurrentDateTime();
        SupportRequest."Modified At" := CurrentDateTime();

        SupportRequest.Insert(true);

        exit(SupportNo);
    end;

    procedure AssignSupportRequest(
        SupportNo: Code[20];
        AssignedTo: Code[20])
    var
        SupportRequest: Record "SD Support Request";
    begin
        GetSupportRequest(SupportRequest, SupportNo);

        if SupportRequest.Status = SupportRequest.Status::Closed then
            Error('Closed support request %1 cannot be assigned.', SupportNo);

        if SupportRequest.Status = SupportRequest.Status::Cancelled then
            Error('Cancelled support request %1 cannot be assigned.', SupportNo);

        if AssignedTo = '' then
            Error('Assigned user is required.');

        SupportRequest."Assigned To" := AssignedTo;
        SupportRequest.Status := SupportRequest.Status::InProgress;
        SupportRequest."Modified At" := CurrentDateTime();

        SupportRequest.Modify(true);
    end;

    procedure StartSupportRequest(SupportNo: Code[20])
    var
        SupportRequest: Record "SD Support Request";
    begin
        GetSupportRequest(SupportRequest, SupportNo);

        if SupportRequest.Status <> SupportRequest.Status::Open then
            Error('Only open support requests can be started.');

        if SupportRequest."Assigned To" = '' then
            Error('Support request %1 must be assigned before it can be started.', SupportNo);

        SupportRequest.Status := SupportRequest.Status::InProgress;
        SupportRequest."Modified At" := CurrentDateTime();

        SupportRequest.Modify(true);
    end;

    procedure WaitForCustomer(SupportNo: Code[20])
    var
        SupportRequest: Record "SD Support Request";
    begin
        GetSupportRequest(SupportRequest, SupportNo);

        if SupportRequest.Status <> SupportRequest.Status::InProgress then
            Error(
                'Only support requests in progress can be placed on hold for the customer.');

        SupportRequest.Status := SupportRequest.Status::WaitingForCustomer;
        SupportRequest."Modified At" := CurrentDateTime();

        SupportRequest.Modify(true);
    end;

    procedure ResumeSupportRequest(SupportNo: Code[20])
    var
        SupportRequest: Record "SD Support Request";
    begin
        GetSupportRequest(SupportRequest, SupportNo);

        if SupportRequest.Status <> SupportRequest.Status::WaitingForCustomer then
            Error(
                'Only support requests waiting for the customer can be resumed.');

        SupportRequest.Status := SupportRequest.Status::InProgress;
        SupportRequest."Modified At" := CurrentDateTime();

        SupportRequest.Modify(true);
    end;

    procedure ResolveSupportRequest(
        SupportNo: Code[20];
        ResolutionNotes: Text[250])
    var
        SupportRequest: Record "SD Support Request";
    begin
        GetSupportRequest(SupportRequest, SupportNo);

        if SupportRequest.Status <> SupportRequest.Status::InProgress then
            Error('Only support requests in progress can be resolved.');

        if ResolutionNotes = '' then
            Error('Resolution notes are required.');

        SupportRequest.Status := SupportRequest.Status::Resolved;
        SupportRequest."Resolution Notes" := ResolutionNotes;
        SupportRequest."Resolved At" := CurrentDateTime();
        SupportRequest."Modified At" := CurrentDateTime();

        SupportRequest.Modify(true);
    end;

    procedure CloseSupportRequest(SupportNo: Code[20])
    var
        SupportRequest: Record "SD Support Request";
    begin
        GetSupportRequest(SupportRequest, SupportNo);

        if SupportRequest.Status <> SupportRequest.Status::Resolved then
            Error('Only resolved support requests can be closed.');

        SupportRequest.Status := SupportRequest.Status::Closed;
        SupportRequest."Closed At" := CurrentDateTime();
        SupportRequest."Modified At" := CurrentDateTime();

        SupportRequest.Modify(true);
    end;

    procedure CancelSupportRequest(SupportNo: Code[20])
    var
        SupportRequest: Record "SD Support Request";
    begin
        GetSupportRequest(SupportRequest, SupportNo);

        if SupportRequest.Status = SupportRequest.Status::Closed then
            Error('Closed support request %1 cannot be cancelled.', SupportNo);

        if SupportRequest.Status = SupportRequest.Status::Cancelled then
            Error(
                'Support request %1 is already cancelled.',
                SupportNo);

        SupportRequest.Status := SupportRequest.Status::Cancelled;
        SupportRequest."Modified At" := CurrentDateTime();

        SupportRequest.Modify(true);
    end;

    local procedure GetSupportRequest(
        var SupportRequest: Record "SD Support Request";
        SupportNo: Code[20])
    begin
        if SupportNo = '' then
            Error('Support request number is required.');

        if not SupportRequest.Get(SupportNo) then
            Error(
                'Support request %1 does not exist.',
                SupportNo);
    end;

    local procedure GetNextSupportNo(): Code[20]
    var
        SupportRequest: Record "SD Support Request";
        NextNumber: Integer;
        ExistingNo: Code[20];
    begin
        if SupportRequest.FindLast() then begin
            ExistingNo := SupportRequest."Support No.";

            if Evaluate(NextNumber, CopyStr(ExistingNo, 5)) then
                NextNumber += 1
            else
                NextNumber := 1;
        end
        else
            NextNumber := 1;

        exit(
            'SUP-' +
            Format(
                NextNumber,
                6,
                '<Integer,6><Filler Character,0>'));
    end;
}