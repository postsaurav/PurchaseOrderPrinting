pageextension 50000 SHDPurchaseOrder extends "Purchase Order"
{
    layout
    {
        addlast(General)
        {
            field("SDH Order Type"; "SDH Order Type")
            {
                ApplicationArea = All;
                Importance = Promoted;
            }
        }
    }
}