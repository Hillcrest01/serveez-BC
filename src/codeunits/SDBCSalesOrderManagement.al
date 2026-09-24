codeunit 50106 "SD BC Sales Order Management"
{
    // Caption = 'Serveez BC Sales Order Management';

    procedure CreateSalesOrder(OrderNo: Code[20]): Code[20]
    var
        PortalOrder: Record "SD Portal Order";
        OrderLine: Record "SD Portal Order Line";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        Service: Record "SD Service";
        Product: Record "SD Product";
        Customer: Record Customer;
        LineNo: Integer;
    begin
        if OrderNo = '' then
            Error('Order number is required.');

        if not PortalOrder.Get(OrderNo) then
            Error('Order %1 does not exist.', OrderNo);

        if PortalOrder."Order Status" <> PortalOrder."Order Status"::Submitted then
            Error('Only submitted orders can be converted to a BC Sales Order.');

        if PortalOrder."BC Sales Order No." <> '' then
            Error(
                'Order %1 already has BC Sales Order %2.',
                OrderNo,
                PortalOrder."BC Sales Order No.");

        if not Customer.Get(PortalOrder."Customer No.") then
            Error(
                'Customer %1 does not exist.',
                PortalOrder."Customer No.");

        OrderLine.Reset();
        OrderLine.SetRange("Order No.", OrderNo);

        if OrderLine.IsEmpty() then
            Error(
                'Order %1 cannot be converted without order lines.',
                OrderNo);

        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
        SalesHeader.Insert(true);

        SalesHeader.Validate(
            "Sell-to Customer No.",
            PortalOrder."Customer No.");

        SalesHeader."External Document No." := OrderNo;

        SalesHeader.Modify(true);

        LineNo := 10000;

        if OrderLine.FindSet() then
            repeat
                SalesLine.Init();
                SalesLine."Document Type" := SalesHeader."Document Type";
                SalesLine."Document No." := SalesHeader."No.";
                SalesLine."Line No." := LineNo;

                case OrderLine."Line Type" of
                    OrderLine."Line Type"::Service:
                        begin
                            if OrderLine."Service Code" = '' then
                                Error(
                                    'Service line %1 does not have a service code.',
                                    OrderLine."Line No.");

                            if not Service.Get(OrderLine."Service Code") then
                                Error(
                                    'Service %1 does not exist.',
                                    OrderLine."Service Code");

                            if Service."Sales Account No." = '' then
                                Error(
                                    'Service %1 does not have a Sales Account No.',
                                    OrderLine."Service Code");

                            SalesLine.Validate(
                                Type,
                                SalesLine.Type::"G/L Account");

                            SalesLine.Validate(
                                "No.",
                                Service."Sales Account No.");
                        end;

                    OrderLine."Line Type"::Product:
                        begin
                            if OrderLine."Item No." = '' then
                                Error(
                                    'Product line %1 does not have an item number.',
                                    OrderLine."Line No.");

                            if not Product.Get(OrderLine."Item No.") then
                                Error(
                                    'Product %1 is not configured as a Serveez product.',
                                    OrderLine."Item No.");

                            if not Product.Active then
                                Error(
                                    'Product %1 is no longer active.',
                                    OrderLine."Item No.");

                            SalesLine.Validate(
                                Type,
                                SalesLine.Type::Item);

                            SalesLine.Validate(
                                "No.",
                                OrderLine."Item No.");
                        end;
                end;

                SalesLine.Description := OrderLine.Description;

                SalesLine.Validate(
                    Quantity,
                    OrderLine.Quantity);

                SalesLine.Validate(
                    "Unit Price",
                    OrderLine."Unit Price");

                SalesLine.Insert(true);

                LineNo += 10000;
            until OrderLine.Next() = 0;

        PortalOrder."BC Sales Order No." := SalesHeader."No.";
        PortalOrder."Modified At" := CurrentDateTime();
        PortalOrder.Modify(true);

        exit(SalesHeader."No.");
    end;
}