tableextension 50000 SDHPurchaseHeader extends "Purchase Header"
{
    fields
    {
        field(50000; "SDH Order Type"; Option)
        {
            Caption = 'Order Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,option 1,option 2,option 3';
            OptionMembers = " ","option1","option2","option3";
        }
    }
}