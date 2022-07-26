#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport50006_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50616 "Delete Data"
{
    RDLCLayout = './Layouts/DeleteData.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            column(ReportForNavId_1; 1) { } // Autogenerated by ForNav - Do not delete
            trigger OnPreDataItem();
            begin
                /*ObjMemberLedger.DELETEALL;
				ObjBankLedger.DELETEALL;
				ObjCustLedger.DELETEALL;
				ObjDetailedCustLedger.DELETEALL;
				ObjDetailedVendorLedger.DELETEALL;
				ObjGLEntry.DELETEALL;
				ObjVendorLedger.DELETEALL;*/
                /*"Membership Applications".Created:=FALSE;
				"Membership Applications".MODIFY;*/

            end;

            trigger OnAfterGetRecord();
            begin
                /*{"Loans Register"."Loan Status":="Loans Register"."Loan Status"::Disbursed;
				"Loans Register".Posted:=TRUE;
				"Loans Register"."Approval Status":="Loans Register"."Approval Status"::Approved;
				"Loans Register".MODIFY;} Blocked:=Blocked::" ";
				MODIFY;
				*/
                "Loans Register"."Repayment Method" := "Loans Register"."repayment method"::"Reducing Balance";
                "Loans Register".Modify;

            end;

        }
    }

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ForNavOpenDesigner; ReportForNavOpenDesigner)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Design';
                        Visible = ReportForNavAllowDesign;
                        trigger OnValidate()
                        begin
                            ReportForNav.LaunchDesigner(ReportForNavOpenDesigner);
                            CurrReport.RequestOptionsPage.Close();
                        end;

                    }
                }
            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin
            ReportForNavOpenDesigner := false;
        end;
    }

    trigger OnInitReport()
    begin
        ;
        ReportsForNavInit;

    end;

    trigger OnPostReport()
    begin
        ;
        ReportForNav.Post;
    end;

    trigger OnPreReport()
    begin
        ;
        ReportsForNavPre;
    end;

    var
        ObjLoans: Record "Loans Register";
        ObjLoanType: Record "Loan Products Setup";
        ObjAccount: Record Vendor;
        ObjMemberCells: Record "Phone Number Buffer";
        ObjGenSetup: Record "Sacco General Set-Up";
        ObjExcessRuleProducts: Record "Excess Repayment Rules Product";
        ObjMember: Record "Members Register";
        Name: Decimal;
        SFactory: Codeunit "SURESTEP Factory";
        ObjLoanSchedule: Record "Loan Repayment Schedule";
        ObjAccounts: Record Vendor;
        VarAccountTypes: Text[1024];
        ObjAccountType: Record "Account Types-Saving Products";
        VarAccountDescription: Text[1024];
        ObjGLEntry: Record "G/L Entry";
        ObjMemberLedger: Record "Member Ledger Entry";
        ObjBankLedger: Record "Bank Account Ledger Entry";
        ObjVendorLedger: Record "Vendor Ledger Entry";
        ObjDetailedVendorLedger: Record "Detailed Vendor Ledg. Entry";
        ObjCustLedger: Record "Cust. Ledger Entry";
        ObjDetailedCustLedger: Record "Detailed Cust. Ledg. Entry";
        ObjLoanGuarantors: Record "Loans Guarantee Details";
        ObjLoanCollateral: Record "Loan Collateral Details";
        WeekDay: Text;
        ObjATMApp: Record "ATM Card Applications";

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport50006_v6_3_0_2259;
        ReportForNavOpenDesigner: Boolean;
        [InDataSet]
        ReportForNavAllowDesign: Boolean;

    local procedure ReportsForNavInit();
    var
        ApplicationSystemConstants: Codeunit "Application System Constants";
        addInFileName: Text;
        tempAddInFileName: Text;
        path: DotNet Path;
        ReportForNavObject: Variant;
    begin
        addInFileName := ApplicationPath() + 'Add-ins\ReportsForNAV_6_3_0_2259\ForNav.Reports.6.3.0.2259.dll';
        if not File.Exists(addInFileName) then begin
            tempAddInFileName := path.GetTempPath() + '\Microsoft Dynamics NAV\Add-Ins\' + ApplicationSystemConstants.PlatformFileVersion() + '\ForNav.Reports.6.3.0.2259.dll';
            if not File.Exists(tempAddInFileName) then
                Error('Please install the ForNAV DLL version 6.3.0.2259 in your service tier Add-ins folder under the file name "%1"\\If you already have the ForNAV DLL on the server, you should move it to this folder and rename it to match this file name.', addInFileName);
        end;
        ReportForNavObject := ReportForNav.GetLatest(CurrReport.OBJECTID, CurrReport.Language, SerialNumber, UserId, CompanyName);
        ReportForNav := ReportForNavObject;
        ReportForNav.Init();
    end;

    local procedure ReportsForNavPre();
    begin
        ReportForNav.OpenDesigner := ReportForNavOpenDesigner;
        if not ReportForNav.Pre() then CurrReport.Quit();
    end;

    // Reports ForNAV Autogenerated code - do not delete or modify -->
}