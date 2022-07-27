#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516367_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50367 "Loan Defaulter Notified"
{
    RDLCLayout = './Layouts/LoanDefaulterNotified.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Loans; "Loans Register")
        {
            DataItemTableView = sorting("Loan  No.") where(Source = const(" "));
            RequestFilterFields = "Loan Product Type", "Application Date", "Appraisal Status", "Loan Status", "Issued Date";
            column(ReportForNavId_1102755000; 1102755000) { } // Autogenerated by ForNav - Do not delete
            column(Loan_No; Loans."Loan  No.")
            {
            }
            column(Member_No; Loans."Client Code")
            {
            }
            column(ClientName_Loans; Loans."Client Name")
            {
            }
            column(Personal_No; Loans."Staff No")
            {
            }
            column(Employer_Name; Loans."Employer Name")
            {
            }
            column(Loan_Type; Loans."Loan Product Type")
            {
            }
            column(Approved_Amount; Loans."Approved Amount")
            {
            }
            column(Outstanding_Bal; Loans."Outstanding Balance")
            {
            }
            column(Issued_Date; Loans."Issued Date")
            {
            }
            column(Interest_Due; Loans."Interest Due")
            {
            }
            column(Penalty_Charged; Loans."Penalty Charged")
            {
            }
            column(LastPay_date; Loans."Last Pay Date")
            {
            }
            column(Remarks; Loans.Remarks)
            {
            }
            trigger OnAfterGetRecord();
            begin
                RPeriod := Loans.Installments;
                if (Loans."Outstanding Balance" > 0) and (Loans.Repayment > 0) then
                    RPeriod := Loans."Outstanding Balance" / Loans.Repayment;
                Cust.Reset;
                Cust.SetRange(Cust."No.", "Client Code");
                if Cust.Find('-') then begin
                    EmpCode := Cust."Employer Code";
                    PersonalNo := Cust."Payroll No";
                end;
                Intcount += 1;
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
        RPeriod: Decimal;
        Cust: Record "Members Register";
        EmpCode: Code[30];
        Intcount: Integer;
        Month: Code[10];
        PersonalNo: Code[30];
        StartDate: Date;
        EndDate: Date;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516367_v6_3_0_2259;
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
