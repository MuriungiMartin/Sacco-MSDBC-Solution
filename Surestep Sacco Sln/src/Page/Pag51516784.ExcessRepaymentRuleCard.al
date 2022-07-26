#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50784 "Excess Repayment Rule Card"
{
    PageType = Card;
    SourceTable = "Excess Repayment Rules";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field("Account Type Affected"; "Account Type Affected")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; "Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Recovery Priority"; "Loan Recovery Priority")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Products; "Excess Repayment Rule Products")
            {
                SubPageLink = Code = field(Code);
            }
        }
    }

    actions
    {
    }
}

