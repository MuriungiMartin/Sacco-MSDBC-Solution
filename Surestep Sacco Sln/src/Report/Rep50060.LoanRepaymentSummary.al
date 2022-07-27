#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516060_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50060 "Loan Repayment Summary"
{
    RDLCLayout = './Layouts/LoanRepaymentSummary.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Loan Products Setup"; "Loan Products Setup")
        {
            DataItemTableView = where(Code = filter(<> '406'));
            column(ReportForNavId_4645; 4645) { } // Autogenerated by ForNav - Do not delete
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Address_2; Company."Address 2")
            {
            }
            column(Company_Phone_No; Company."Phone No.")
            {
            }
            column(Company_Fax_No; Company."Fax No.")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            column(CurrReport_PAGENO; Format(ReportForNav.PageNo))
            {
            }
            column(UserId; UserId)
            {
            }
            column(VarEntryNo; VarEntryNo)
            {
            }
            column(Code_LoanProductsSetup; "Loan Products Setup".Code)
            {
            }
            column(ProductDescription_LoanProductsSetup; "Loan Products Setup"."Product Description")
            {
            }
            column(VarToDate; Format(VarToDate, 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(VarFromDate; Format(VarFromDate, 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(VarActualPrincipleRepayment; VarActualPrincipleRepayment)
            {
            }
            column(VarExpectedPrincipleRepayment; VarExpectedPrincipleRepayment)
            {
            }
            column(VarActualInterestRepayment; VarActualInterestRepayment)
            {
            }
            column(VarExpectedInterestRepayment; VarExpectedInterestRepayment)
            {
            }
            column(VarActualPenaltyRepayment; VarActualPenaltyRepayment)
            {
            }
            column(VarExpectedPenaltyRepayment; VarExpectedPenaltyRepayment)
            {
            }
            column(VarTotalActualPrinciple; VarTotalActualPrinciple)
            {
            }
            column(VarTotalActualInterest; VarTotalActualInterest)
            {
            }
            column(VarTotalActualPenalty; VarTotalActualPenalty)
            {
            }
            trigger OnPreDataItem();
            begin
                Company.Get();
                Company.CalcFields(Company.Picture);
            end;

            trigger OnAfterGetRecord();
            begin
                VarEntryNo := VarEntryNo + 1;
                VarDateFilter := Format(VarFromDate) + '..' + Format(VarToDate);
                BalDateFilter := '..' + Format(VarToDate);
                VarActualPrincipleRepayment := 0;
                VarActualPrincipleRepaymentHistorical := 0;
                VarActualInterestRepayment := 0;
                VarActualInterestRepaymentHistorical := 0;
                VarActualPenaltyRepayment := 0;
                VarActualPenaltyRepaymentHistorical := 0;
                VarExpectedPrincipleRepayment := 0;
                VarExpectedInterestRepayment := 0;
                VarExpectedPenaltyRepayment := 0;
                //=======================================================================================Expected Repayments
                //====================================================================================Principle
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                ObjLoans.Reset;
                ObjLoans.SetRange(ObjLoans."Loan Product Type", Code);
                ObjLoans.SetFilter(ObjLoans."Date filter", BalDateFilter);
                ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 1);
                if ObjLoans.FindSet then begin
                    repeat
                        ObjLoanRepaymentSchedule.CalcFields(ObjLoanRepaymentSchedule."Loan Product Code");
                        ObjLoanRepaymentSchedule.Reset;
                        ObjLoanRepaymentSchedule.SetRange(ObjLoanRepaymentSchedule."Loan Product Code", Code);
                        ObjLoanRepaymentSchedule.SetRange(ObjLoanRepaymentSchedule."Loan No.", ObjLoans."Loan  No.");
                        ObjLoanRepaymentSchedule.SetFilter(ObjLoanRepaymentSchedule."Repayment Date", VarDateFilter);
                        if ObjLoanRepaymentSchedule.FindSet then begin
                            ObjLoanRepaymentSchedule.CalcSums(ObjLoanRepaymentSchedule."Principal Repayment");
                            VarExpectedPrincipleRepayment := VarExpectedPrincipleRepayment + ObjLoanRepaymentSchedule."Principal Repayment";
                        end;
                    until ObjLoans.Next = 0;
                end;
                //====================================================================================Interest
                ObjInterestAccrued.CalcFields(ObjInterestAccrued."Loan Type");
                ObjInterestAccrued.Reset;
                ObjInterestAccrued.SetRange(ObjInterestAccrued."Loan Type", Code);
                ObjInterestAccrued.SetFilter(ObjInterestAccrued."Posting Date", VarDateFilter);
                if ObjInterestAccrued.FindSet then begin
                    ObjInterestAccrued.CalcSums(ObjInterestAccrued.Amount);
                    VarExpectedInterestRepayment := ObjInterestAccrued.Amount;
                    //ERROR('Code %1, VarExpectedInterestRepayment %2',Code, VarExpectedInterestRepayment);
                end;
                //====================================================================================Penalty
                ObjPenaltyCharged.CalcFields(ObjPenaltyCharged."Loan Product Code");
                ObjPenaltyCharged.Reset;
                ObjPenaltyCharged.SetRange(ObjPenaltyCharged."Loan Product Code", Code);
                ObjPenaltyCharged.SetFilter(ObjPenaltyCharged."Posting Date", VarDateFilter);
                if ObjPenaltyCharged.FindSet then begin
                    ObjPenaltyCharged.CalcSums(ObjPenaltyCharged.Amount);
                    VarExpectedPenaltyRepayment := ObjPenaltyCharged.Amount;
                end;
                //=======================================================================================Actual Repayments
                //================================================Principle Repayment
                ObjMemberLedger.CalcFields(ObjMemberLedger."Loan Type");
                ObjMemberLedger.Reset;
                ObjMemberLedger.SetRange(ObjMemberLedger."Loan Type", Code);
                ObjMemberLedger.SetFilter(ObjMemberLedger."Posting Date", VarDateFilter);
                ObjMemberLedger.SetRange(ObjMemberLedger."Transaction Type", ObjMemberLedger."transaction type"::"Loan Repayment");
                if ObjMemberLedger.FindSet then begin
                    ObjMemberLedger.CalcSums(ObjMemberLedger.Amount);
                    VarActualPrincipleRepayment := ObjMemberLedger.Amount;
                end;
                ObjHistorical.Reset;
                ObjHistorical.SetRange(ObjHistorical."Product ID", Code);
                ObjHistorical.SetFilter(ObjHistorical."Posting Date", VarDateFilter);
                ObjHistorical.SetFilter(ObjHistorical."Transaction Type", '<>%1', ObjHistorical."transaction type"::"Loan Disbursement");
                if ObjHistorical.FindSet then begin
                    ObjHistorical.CalcSums(ObjHistorical.Amount);
                    VarActualPrincipleRepaymentHistorical := ObjHistorical.Amount;
                end;
                VarTotalActualPrinciple := (VarActualPrincipleRepayment + VarActualPrincipleRepaymentHistorical) * -1;
                //================================================Interest Payment
                ObjMemberLedger.CalcFields(ObjMemberLedger."Loan Type");
                ObjMemberLedger.Reset;
                ObjMemberLedger.SetRange(ObjMemberLedger."Loan Type", Code);
                ObjMemberLedger.SetFilter(ObjMemberLedger."Posting Date", VarDateFilter);
                ObjMemberLedger.SetRange(ObjMemberLedger."Transaction Type", ObjMemberLedger."transaction type"::"Interest Paid");
                if ObjMemberLedger.FindSet then begin
                    ObjMemberLedger.CalcSums(ObjMemberLedger.Amount);
                    VarActualInterestRepayment := ObjMemberLedger.Amount;
                end;
                ObjHistorical.Reset;
                ObjHistorical.SetRange(ObjHistorical."Product ID", Code);
                ObjHistorical.SetFilter(ObjHistorical."Posting Date", VarDateFilter);
                ObjHistorical.SetRange(ObjHistorical."Transaction Type", ObjHistorical."transaction type"::"Interest Paid");
                if ObjHistorical.FindSet then begin
                    ObjHistorical.CalcSums(ObjHistorical.Amount);
                    VarActualInterestRepaymentHistorical := ObjHistorical.Amount;
                end;
                VarTotalActualInterest := (VarActualInterestRepayment * -1) + VarActualInterestRepaymentHistorical;
                //================================================Penalty Payment
                ObjMemberLedger.CalcFields(ObjMemberLedger."Loan Type");
                ObjMemberLedger.Reset;
                ObjMemberLedger.SetRange(ObjMemberLedger."Loan Type", Code);
                ObjMemberLedger.SetFilter(ObjMemberLedger."Posting Date", VarDateFilter);
                ObjMemberLedger.SetRange(ObjMemberLedger."Transaction Type", ObjMemberLedger."transaction type"::"Loan Penalty Paid");
                if ObjMemberLedger.FindSet then begin
                    ObjMemberLedger.CalcSums(ObjMemberLedger.Amount);
                    VarActualPenaltyRepayment := ObjMemberLedger.Amount;
                end;
                ObjHistorical.Reset;
                ObjHistorical.SetRange(ObjHistorical."Product ID", Code);
                ObjHistorical.SetFilter(ObjHistorical."Posting Date", VarDateFilter);
                ObjHistorical.SetRange(ObjHistorical."Transaction Type", ObjHistorical."transaction type"::"Penalty Paid");
                if ObjHistorical.FindSet then begin
                    ObjHistorical.CalcSums(ObjHistorical.Amount);
                    VarActualPenaltyRepaymentHistorical := ObjHistorical.Amount;
                end;
                VarTotalActualPenalty := (VarActualPenaltyRepayment * -1) + VarActualPenaltyRepaymentHistorical;
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
                field(VarFromDate; VarFromDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'From Date';
                }
                field(VarToDate; VarToDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'To Date';
                }
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
        AsAt: Date;
        Company: Record "Company Information";
        SFactory: Codeunit "SURESTEP Factory";
        ObjGensetup: Record "Sacco General Set-Up";
        CurrReport_PAGENOCaptionLbl: label 'Page';
        RISK_CLASSIFICATION_OF_ASSETS_AND_PROVISIONINGCaptionLbl: label 'RISK CLASSIFICATION OF ASSETS AND PROVISIONING';
        FORM_4CaptionLbl: label 'FORM 4';
        SASRA_2_004CaptionLbl: label 'SASRA 2/004';
        R__46_CaptionLbl: label 'R.(46)';
        ObjMembers: Record "Members Register";
        VarEntryNo: Integer;
        ObjDetailedVendLedger: Record "Detailed Vendor Ledg. Entry";
        VarFromDate: Date;
        VarToDate: Date;
        VarDateFilter: Text;
        VarAccountTypeBalance: Decimal;
        ObjLoans: Record "Loans Register";
        ObjLoanRepaymentSchedule: Record "Loan Repayment Schedule";
        ObjMemberLedger: Record "Member Ledger Entry";
        ObjInterestAccrued: Record "Interest Due Ledger Entry";
        ObjPenaltyCharged: Record "Daily Interest/Penalty Buffer";
        VarActualPrincipleRepayment: Decimal;
        VarActualPrincipleRepaymentHistorical: Decimal;
        VarExpectedPrincipleRepayment: Decimal;
        VarActualInterestRepayment: Decimal;
        VarActualInterestRepaymentHistorical: Decimal;
        VarExpectedInterestRepayment: Decimal;
        VarActualPenaltyRepayment: Decimal;
        VarActualPenaltyRepaymentHistorical: Decimal;
        VarExpectedPenaltyRepayment: Decimal;
        ObjHistorical: Record "Member Loans Historical Ledger";
        VarTotalActualPrinciple: Decimal;
        VarTotalActualInterest: Decimal;
        VarTotalActualPenalty: Decimal;
        BalDateFilter: Text;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516060_v6_3_0_2259;
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
