#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50546 "Account Agent App Card"
{
    PageType = Card;
    SourceTable = "Account Agents App Details";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA No."; "BOSA No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Agent Member No';
                }
                field(Names; Names)
                {
                    ApplicationArea = Basic;
                    Caption = 'Agent Name';
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile No."; "Mobile No.")
                {
                    ApplicationArea = Basic;
                }
                field("Email Address"; "Email Address")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Birth"; "Date Of Birth")
                {
                    ApplicationArea = Basic;
                }
                field("Allowed Balance Enquiry"; "Allowed Balance Enquiry")
                {
                    ApplicationArea = Basic;
                }
                field("Allowed  Correspondence"; "Allowed  Correspondence")
                {
                    ApplicationArea = Basic;
                }
                field("Allowed FOSA Withdrawals"; "Allowed FOSA Withdrawals")
                {
                    ApplicationArea = Basic;
                }
                field("Allowed Loan Processing"; "Allowed Loan Processing")
                {
                    ApplicationArea = Basic;
                }
                field("Expiry Date"; "Expiry Date")
                {
                    ApplicationArea = Basic;
                }
                field(Designation; Designation)
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control7; "Account Agent Picture-App")
            {
                ApplicationArea = All;
                Caption = 'Picture';
            }
            part(Control8; "Account Agent Signature-App")
            {
                ApplicationArea = All;
                Caption = 'Signature';
            }
        }
    }

    actions
    {
    }
}

