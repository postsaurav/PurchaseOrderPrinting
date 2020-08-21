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

        IF ReportUsage <> TempReportSelections.Usage::"P.Order".AsInteger() THEN
            EXIT;

        PurchaseHeader := RecordVariant;

        CASE PurchaseHeader."SDH Order Type" OF
            PurchaseHeader."SDH Order Type"::" ":
                EXIT;
            PurchaseHeader."SDH Order Type"::option1:
                REPORT.RUNMODAL(60000, IsGUI, FALSE, RecordVariant);
            PurchaseHeader."SDH Order Type"::option2:
                REPORT.RUNMODAL(60001, IsGUI, FALSE, RecordVariant);
            PurchaseHeader."SDH Order Type"::option3:
                REPORT.RUNMODAL(60002, IsGUI, FALSE, RecordVariant);
        end;

        Handled := TRUE;
    end;
}