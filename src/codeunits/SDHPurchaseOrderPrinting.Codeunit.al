codeunit 50000 "SDH Purchase Order Printing"
{
    [EventSubscriber(ObjectType::Table, Database::"Report Selections", 'OnBeforePrintWithGUIYesNoVendor', '', true, true)]
    local procedure PrintPurchaseOrder(RecordVariant: Variant; ReportUsage: Integer; IsGUI: Boolean; var Handled: Boolean)
    var
        PurchaseHeader: Record "Purchase Header";
        DataTypeManagement: Codeunit "Data Type Management";
        PurchaseHeaderRecordRef: RecordRef;
        TempReportSelections: Record "Report Selections" temporary;

    begin
        if Handled then
          exit();
          
        DataTypeManagement.GetRecordRef(RecordVariant, PurchaseHeaderRecordRef);

        IF PurchaseHeaderRecordRef.Number <> DATABASE::"Purchase Header" then
            exit();

        IF ReportUsage <> TempReportSelections.Usage::"P.Order" then
            exit();

        PurchaseHeader := RecordVariant;

        case PurchaseHeader."SDH Order Type" of
            PurchaseHeader."SDH Order Type"::" ":
                exit();
            PurchaseHeader."SDH Order Type"::option1:
                Report.RunModal(Report::"Purchase Order Opt 1", IsGUI, false, RecordVariant);
            PurchaseHeader."SDH Order Type"::option2:
                Report.RunModal(Report::"Purchase Order Opt 2", IsGUI, false, RecordVariant);
            PurchaseHeader."SDH Order Type"::option3:
                Report.RunModal(Report::"Purchase Order Opt 3", IsGUI, false, RecordVariant);
        end;

        Handled := true;
    end;
}
