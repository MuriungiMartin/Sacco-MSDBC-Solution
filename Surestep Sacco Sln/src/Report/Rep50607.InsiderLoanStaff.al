#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516607_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50607 "Insider Loan Staff"
{
    RDLCLayout = './Layouts/InsiderLoanStaff.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = where("Outstanding Balance" = filter(> 0), "Insider-Employee" = const(true));
            column(ReportForNavId_1; 1) { } // Autogenerated by ForNav - Do not delete
            column(StartDate; StartDate)
            {
            }
            column(MStartDate; MStartDate)
            {
            }
            column(MEndDate; MEndDate)
            {
            }
            column(AsAt; AsAt)
            {
            }
            column(EmplNme; EmplNme)
            {
            }
            column(EmplNme1; EmplNme1)
            {
            }
            column(LoanNo_LoansRegister; "Loans Register"."Loan  No.")
            {
            }
            column(qwe; qwe)
            {
            }
            column(EmplNmeboard; EmplNmeboard)
            {
            }
            column(EmplNme1board; EmplNme1board)
            {
            }
            column(LoanNo; LoanNo)
            {
            }
            column(LoanNo1; LoanNo1)
            {
            }
            column(LoanNo2; LoanNo2)
            {
            }
            column(RequestedAmount_LoansRegister; "Loans Register"."Requested Amount")
            {
            }
            column(LoanNo3; LoanNo3)
            {
            }
            column(InsiderBoard_LoansRegister; "Loans Register"."Insider-Board")
            {
            }
            column(insiderEmployee_LoansRegister; "Loans Register"."Insider-Employee")
            {
            }
            column(t; T)
            {
            }
            column(MEMBERNUMBER; MEMBERNUMBER)
            {
            }
            column(POSITIONHELD; POSITIONHELD)
            {
            }
            column(AMOUNTGRANTED; AMOUNTGRANTED)
            {
            }
            column(DATEAPPROVED; DATEAPPROVED)
            {
            }
            column(AMOUNTrequested; AMOUNT)
            {
            }
            column(AMOUNTOFBOSADEPOSITS; AMOUNTOFBOSADEPOSITS)
            {
            }
            column(NATUREOFSECURITY; NATUREOFSECURITY)
            {
            }
            column(REPAYMENTCOMMENCEMENT; REPAYMENTCOMMENCEMENT)
            {
            }
            column(REPAYMENTPERIOD; REPAYMENTPERIOD)
            {
            }
            column(LOANTYPENAME; LOANTYPENAME)
            {
            }
            column(OUTSTANDINGAMOUNT; OUTSTANDINGAMOUNT)
            {
            }
            column(PERFORMANCE; PERFORMANCE)
            {
            }
            column(LoansCategorySASRA_LoansRegister; "Loans Register"."Loans Category-SASRA")
            {
            }
            column(name; CompanyProperty.DisplayName)
            {
            }
            column(LoansCategory_LoansRegister; "Loans Register"."Loans Category")
            {
            }
            column(SN; SN)
            {
            }
            trigger OnAfterGetRecord();
            begin
                qwe := '';
                T := true;
                F := false;
                AMOUNT := 0;
                AMOUNTGRANTED := 0;
                MEMBERNUMBER := '';
                LoanNo1 := '';
                EmplNme1 := '';
                SN := SN + 1;
                LoanApp.Reset;
                LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                LoanApp.SetRange(LoanApp."Client Code", "Loans Register"."Client Code");
                LoanApp.SetAutocalcFields("Current Shares", "Outstanding Balance");
                if LoanApp.Find('-') then begin
                    if "Loans Register"."Insider-Employee" = true then begin
                        EmplNme := LoanApp."Client Name";
                        MEMBERNUMBER := LoanApp."Client Code";
                        POSITIONHELD := 'Employee';
                        AMOUNT := LoanApp."Requested Amount";
                        AMOUNTGRANTED := LoanApp."Approved Amount";
                        AMOUNTOFBOSADEPOSITS := (LoanApp."Current Shares");
                        DATEAPPROVED := LoanApp."Issued Date";
                        REPAYMENTCOMMENCEMENT := LoanApp."Repayment Start Date";
                        REPAYMENTPERIOD := LoanApp."Instalment Period";
                        LOANTYPENAME := LoanApp."Loan Product Type Name";
                        // LoanNo:="Loans Register"."Loan  No.";
                        if LoanApp."Issued Date" > MStartDate then
                            EmplNme1 := LoanApp."Client Name";
                        LoanNo1 := LoanApp."Loan  No.";
                        MEMBERNUMBER := LoanApp."Client Code";
                        POSITIONHELD := 'Employee';
                        AMOUNT := LoanApp."Requested Amount";
                        AMOUNTGRANTED := LoanApp."Approved Amount";
                        AMOUNTOFBOSADEPOSITS := (LoanApp."Current Shares");
                        DATEAPPROVED := LoanApp."Issued Date";
                        REPAYMENTCOMMENCEMENT := LoanApp."Repayment Start Date";
                        REPAYMENTPERIOD := LoanApp."Instalment Period";
                        LOANTYPENAME := LoanApp."Loan Product Type Name";
                        //PERFORMANCE:=LoanApp."Loans Category-SASRA";
                        OUTSTANDINGAMOUNT := LoanApp."Outstanding Balance";
                    end;
                end; //ELSE CurrReport.SKIP;
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
                field(AsAt; AsAt)
                {
                    ApplicationArea = Basic;
                    Caption = 'AsAt....';
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
        StartDate := CalcDate('-CY', AsAt);
        MStartDate := CalcDate('-CM', AsAt);
        MEndDate := CalcDate('CM', AsAt);
        NEWLoanFilter := Format(MStartDate) + '..' + Format(MEndDate);
        //MESSAGE('%1',NEWLoanFilter);
        OldLoanFilter := '..' + Format(MStartDate);
        ;
        ReportsForNavPre;
    end;

    var
        StartDate: Date;
        MStartDate: Date;
        MEndDate: Date;
        NEWLoanFilter: Text;
        OldLoanFilter: Text;
        AsAt: Date;
        LoanApp: Record "Loans Register";
        EmplNme: Text;
        EmplNme1: Text[50];
        LoansRegister: Record "Loans Register";
        qwe: Text[50];
        EmplNmeboard: Text;
        EmplNme1board: Text;
        LoanNo: Code[20];
        LoanNo1: Code[20];
        LoanNo2: Code[20];
        LoanNo3: Code[20];
        T: Boolean;
        F: Boolean;
        MEMBERNUMBER: Code[30];
        POSITIONHELD: Text;
        LOANTYPENAME: Text;
        AMOUNT: Decimal;
        AMOUNTGRANTED: Decimal;
        DATEAPPROVED: Date;
        AMOUNTOFBOSADEPOSITS: Decimal;
        NATUREOFSECURITY: Text;
        REPAYMENTCOMMENCEMENT: Date;
        REPAYMENTPERIOD: DateFormula;
        OUTSTANDINGAMOUNT: Decimal;
        PERFORMANCE: Text;
        SN: Integer;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516607_v6_3_0_2259;
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
