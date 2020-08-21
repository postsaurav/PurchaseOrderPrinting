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
        DataTypeManagement.GetRecordRef(RecordVariant, PurchaseHeaderRecordRef);

        IF PurchaseHeaderRecordRef.NUMBER <> DATABASE::"Purchase Header" THEN
            EXIT;

        IF ReportUsage <> TempReportSelections.Usage::"P.Order" THEN
            EXIT;

        PurchaseHeader := RecordVariant;

        CASE PurchaseHeader."SDH Order Type" OF
            PurchaseHeader."SDH Order Type"::" ":
                EXIT;
            PurchaseHeader."SDH Order Type"::option1:
                REPORT.RUNMODAL(Report::"Purchase Order Opt 1", IsGUI, FALSE, RecordVariant);
            PurchaseHeader."SDH Order Type"::option2:
                REPORT.RUNMODAL(Report::"Purchase Order Opt 2", IsGUI, FALSE, RecordVariant);
            PurchaseHeader."SDH Order Type"::option3:
                REPORT.RUNMODAL(Report::"Purchase Order Opt 3", IsGUI, FALSE, RecordVariant);
        end;

        Handled := TRUE;
    end;
}