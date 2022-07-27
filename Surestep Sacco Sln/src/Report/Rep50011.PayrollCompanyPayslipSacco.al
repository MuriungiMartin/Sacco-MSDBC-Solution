#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport50011_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50621 "Payroll Company Payslip Sacco"
{
    RDLCLayout = './Layouts/PayrollCompanyPayslipSacco.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Payroll Employee."; "Payroll Employee.")
        {
            RequestFilterFields = "No.", "Last Payroll Period";
            column(ReportForNavId_1; 1) { } // Autogenerated by ForNav - Do not delete
            column(No; "Payroll Employee."."No.")
            {
            }
            column(Surname; "Payroll Employee.".Surname)
            {
            }
            column(FirstName; "Payroll Employee.".Firstname)
            {
            }
            column(Lastname; "Payroll Employee.".Lastname)
            {
            }
            column(FullName; "Payroll Employee."."Full Name")
            {
            }
            column(CName; CompanyInfo.Name)
            {
            }
            column(CAddress; CompanyInfo.Address)
            {
            }
            column(CPic; CompanyInfo.Picture)
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            column(PINNo; CompPINNo)
            {
            }
            column(NSSFNo; EmployerNSSNo)
            {
            }
            column(NHIFNo; EmployerNHIFNo)
            {
            }
            column(BankName; "Payroll Employee."."Bank Name")
            {
            }
            column(BranchName; "Payroll Employee."."Branch Name")
            {
            }
            column(Department; "Payroll Employee.".Department)
            {
            }
            column(UserId; UserId)
            {
            }
            column(BankAccNo; "Payroll Employee."."Bank Account No")
            {
            }
            dataitem("prPeriod Transactions."; "prPeriod Transactions.")
            {
                DataItemLink = "Employee Code" = field("No.");
                RequestFilterFields = "Payroll Period";
                column(ReportForNavId_6; 6) { } // Autogenerated by ForNav - Do not delete
                column(TCode; "prPeriod Transactions."."Transaction Code")
                {
                }
                column(TName; "prPeriod Transactions."."Transaction Name")
                {
                }
                column(Grouping; "prPeriod Transactions."."Group Order")
                {
                }
                column(TBalances; "prPeriod Transactions.".Balance)
                {
                }
                column(SubGroupOrder; "prPeriod Transactions."."Sub Group Order")
                {
                }
                column(Amount; "prPeriod Transactions.".Amount)
                {
                }
                column(PeriodMonth_prPeriodTransactions; "prPeriod Transactions."."Period Month")
                {
                }
                column(PeriodYear_prPeriodTransactions; "prPeriod Transactions."."Period Year")
                {
                }
                trigger OnAfterGetRecord();
                begin
                    PayrollCalender.Reset;
                    PayrollCalender.SetRange(PayrollCalender."Date Opened", "Payroll Period");
                    if PayrollCalender.FindLast then begin
                        PeriodName := PayrollCalender."Period Name" + '-' + Format(PayrollCalender."Period Year");
                    end;
                end;

            }
            trigger OnAfterGetRecord();
            begin
                /*PayrollCalender.RESET;
                PayrollCalender.SETRANGE(PayrollCalender."Date Opened","Date Filter");
                IF PayrollCalender.FINDLAST THEN BEGIN
                  PeriodName:=PayrollCalender."Period Name";
                END;*/

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
        if UserSetup.Get(UserId) then begin
            if not UserSetup."View Payroll" then
                Error(PemissionDenied);
        end else begin
            Error(UserNotFound, UserId);
        end;
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
        CompanyInfo.Get;
        CompanyInfo.CalcFields(CompanyInfo.Picture);
        /*PayrollEmp.RESET;
        PayrollEmp.SETRANGE(PayrollEmp.Status,PayrollEmp.Status::Active);
        IF PayrollEmp.FINDFIRST THEN BEGIN
          PayrollCalender.RESET;
          PayrollCalender.SETRANGE(PayrollCalender."Date Opened",PayrollEmp."Date Filter");
          IF PayrollCalender.FINDLAST THEN BEGIN
               PeriodName:=PayrollCalender."Period Name";
          END;
        END;*/
        if CompInfoSetup.Get() then
            EmployerNSSNo := CompInfoSetup."N.S.S.F No.";
        EmployerNHIFNo := CompInfoSetup."N.H.I.F No";
        CompPINNo := CompInfoSetup."Company P.I.N";
        // Address:=CompInfoSetup.Address;
        //Tel:=CompInfoSetup."Phone No.";
        ;
        ReportsForNavPre;

    end;

    var
        CompanyInfo: Record "Company Information";
        PayrollCalender: Record "Payroll Calender.";
        "Payroll Period": Date;
        PeriodName: Text;
        PayrollEmp: Record "Payroll Employee.";
        UserNotFound: label 'User Setup %1 not found.';
        PemissionDenied: label 'User Account is not Setup for Payroll Use. Contact System Administrator.';
        UserSetup: Record "User Setup";
        CompInfoSetup: Record "Control-Information.";
        EmployerNSSNo: Code[50];
        CompPINNo: Code[50];
        EmployerNHIFNo: Code[50];

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport50011_v6_3_0_2259;
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
