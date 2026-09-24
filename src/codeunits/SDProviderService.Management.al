codeunit 50112 "SD Provider Service Management"
{
    // Caption = 'Serveez Provider Service Management';

    procedure AddProviderService(
        ProviderNo: Code[20];
        ServiceCode: Code[20])
    var
        Provider: Record "SD Service Provider";
        Service: Record "SD Service";
        ProviderService: Record "SD Provider Service";
    begin
        if ProviderNo = '' then
            Error('Provider number is required.');

        if ServiceCode = '' then
            Error('Service code is required.');

        if not Provider.Get(ProviderNo) then
            Error(
                'Provider %1 does not exist.',
                ProviderNo);

        if not Provider.Active then
            Error(
                'Provider %1 is not active.',
                ProviderNo);

        if not Service.Get(ServiceCode) then
            Error(
                'Service %1 does not exist.',
                ServiceCode);

        if not Service.Active then
            Error(
                'Service %1 is not active.',
                ServiceCode);

        if ProviderService.Get(
            ProviderNo,
            ServiceCode)
        then
            Error(
                'Provider %1 is already configured for service %2.',
                ProviderNo,
                ServiceCode);

        ProviderService.Init();
        ProviderService."Provider No." := ProviderNo;
        ProviderService."Service Code" := ServiceCode;
        ProviderService.Active := true;
        ProviderService."Created At" := CurrentDateTime();
        ProviderService."Modified At" := CurrentDateTime();

        ProviderService.Insert(true);
    end;

    procedure ActivateProviderService(
        ProviderNo: Code[20];
        ServiceCode: Code[20])
    var
        ProviderService: Record "SD Provider Service";
        Provider: Record "SD Service Provider";
        Service: Record "SD Service";
    begin
        if not Provider.Get(ProviderNo) then
            Error(
                'Provider %1 does not exist.',
                ProviderNo);

        if not Provider.Active then
            Error(
                'Provider %1 is not active.',
                ProviderNo);

        if not Service.Get(ServiceCode) then
            Error(
                'Service %1 does not exist.',
                ServiceCode);

        if not Service.Active then
            Error(
                'Service %1 is not active.',
                ServiceCode);

        if not ProviderService.Get(
            ProviderNo,
            ServiceCode)
        then
            Error(
                'Provider %1 is not configured for service %2.',
                ProviderNo,
                ServiceCode);

        ProviderService.Active := true;
        ProviderService."Modified At" := CurrentDateTime();

        ProviderService.Modify(true);
    end;

    procedure DeactivateProviderService(
        ProviderNo: Code[20];
        ServiceCode: Code[20])
    var
        ProviderService: Record "SD Provider Service";
    begin
        if not ProviderService.Get(
            ProviderNo,
            ServiceCode)
        then
            Error(
                'Provider %1 is not configured for service %2.',
                ProviderNo,
                ServiceCode);

        if not ProviderService.Active then
            Error(
                'Provider %1 is already inactive for service %2.',
                ProviderNo,
                ServiceCode);

        ProviderService.Active := false;
        ProviderService."Modified At" := CurrentDateTime();

        ProviderService.Modify(true);
    end;

    procedure RemoveProviderService(
        ProviderNo: Code[20];
        ServiceCode: Code[20])
    var
        ProviderService: Record "SD Provider Service";
    begin
        if not ProviderService.Get(
            ProviderNo,
            ServiceCode)
        then
            Error(
                'Provider %1 is not configured for service %2.',
                ProviderNo,
                ServiceCode);

        ProviderService.Delete(true);
    end;

    procedure IsProviderAvailableForService(
        ProviderNo: Code[20];
        ServiceCode: Code[20]): Boolean
    var
        Provider: Record "SD Service Provider";
        Service: Record "SD Service";
        ProviderService: Record "SD Provider Service";
    begin
        if not Provider.Get(ProviderNo) then
            exit(false);

        if not Provider.Active then
            exit(false);

        if not Service.Get(ServiceCode) then
            exit(false);

        if not Service.Active then
            exit(false);

        if not ProviderService.Get(
            ProviderNo,
            ServiceCode)
        then
            exit(false);

        exit(ProviderService.Active);
    end;
}