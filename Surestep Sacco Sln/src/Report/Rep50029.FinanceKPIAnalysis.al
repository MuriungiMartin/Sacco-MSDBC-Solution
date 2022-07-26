#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516029_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50029 "Finance KPI Analysis"
{
    RDLCLayout = './Layouts/FinanceKPIAnalysis.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Finance KPI Buffer"; "Finance KPI Buffer")
        {
            PrintOnlyIfDetail = false;
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
            column(Description_FinanceKPIBuffer; "Finance KPI Buffer".Description)
            {
            }
            column(KSACCOTargets_FinanceKPIBuffer; "Finance KPI Buffer"."KSACCO Targets")
            {
            }
            column(BenchMarks_FinanceKPIBuffer; "Finance KPI Buffer".BenchMarks)
            {
            }
            column(Caption_FinanceKPIBuffer; "Finance KPI Buffer".Caption)
            {
            }
            column(YearEnding; Format(CalcDate('CY', WorkDate), 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(VarActualPercentage; VarActualPercentage)
            {
                DecimalPlaces = 2 : 2;
            }
            trigger OnAfterGetRecord();
            begin
                VarDateFilter := '..' + Format(VarReportDate);
                VarBaseGLBalance := 0;
                VarDenominatorGLBalance := 0;
                //==================================================================================================Single Base Accounts
                if ("Base G/L Account" <> '') or ("Denominator G/L Account" <> '') then begin
                    //===============================================================Base Balance
                    ObjGLAccounts.Reset;
                    ObjGLAccounts.SetRange(ObjGLAccounts."No.", "Base G/L Account");
                    ObjGLAccounts.SetFilter(ObjGLAccounts."Date Filter", VarDateFilter);
                    if ObjGLAccounts.FindSet then begin
                        ObjGLAccounts.CalcFields(ObjGLAccounts.Balance);
                        VarBaseGLBalance := ObjGLAccounts.Balance
                    end;
                    //===============================================================Denominator Balance
                    ObjGLAccounts.Reset;
                    ObjGLAccounts.SetRange(ObjGLAccounts."No.", "Denominator G/L Account");
                    ObjGLAccounts.SetFilter(ObjGLAccounts."Date Filter", VarDateFilter);
                    if ObjGLAccounts.FindSet then begin
                        ObjGLAccounts.CalcFields(ObjGLAccounts.Balance);
                        VarDenominatorGLBalance := ObjGLAccounts.Balance
                    end;
                end;
                //==================================================================================================End Single Base Accounts
                //==================================================================================================Multiple Base Accounts
                VarTotalBaseSumGLBalance := 0;
                VarTotalBaseLessGLBalance := 0;
                VarTotalDenominatorSumGLBalance := 0;
                VarTotalDenominatorLessGLBalance := 0;
                if ("Base G/L Account" = '') and ("Base G/L Account to Sum" <> '') then begin
                    //===============================================================Base Balance
                    ObjGLAccounts.Reset;
                    ObjGLAccounts.SetFilter(ObjGLAccounts."No.", "Base G/L Account to Sum");
                    ObjGLAccounts.SetFilter(ObjGLAccounts."Date Filter", VarDateFilter);
                    if ObjGLAccounts.FindSet then begin
                        repeat
                            ObjGLAccounts.CalcFields(ObjGLAccounts.Balance);
                            VarTotalBaseSumGLBalance := VarTotalBaseSumGLBalance + ObjGLAccounts.Balance;
                        until ObjGLAccounts.Next = 0;
                    end;
                    ObjGLAccounts.Reset;
                    ObjGLAccounts.SetFilter(ObjGLAccounts."No.", "Base G/L Account to Less");
                    ObjGLAccounts.SetFilter(ObjGLAccounts."Date Filter", VarDateFilter);
                    if ObjGLAccounts.FindSet then begin
                        repeat
                            ObjGLAccounts.CalcFields(ObjGLAccounts.Balance);
                            VarTotalBaseLessGLBalance := VarTotalBaseLessGLBalance + ObjGLAccounts.Balance;
                        until ObjGLAccounts.Next = 0;
                    end;
                    VarBaseGLBalance := VarTotalBaseSumGLBalance - VarTotalBaseLessGLBalance;
                    //===============================================================Denominator Balance
                    ObjGLAccounts.Reset;
                    ObjGLAccounts.SetFilter(ObjGLAccounts."No.", "Denominator G/L Account to Sum");
                    ObjGLAccounts.SetFilter(ObjGLAccounts."Date Filter", VarDateFilter);
                    if ObjGLAccounts.FindSet then begin
                        repeat
                            ObjGLAccounts.CalcFields(ObjGLAccounts.Balance);
                            VarTotalDenominatorSumGLBalance := VarTotalDenominatorSumGLBalance + ObjGLAccounts.Balance;
                        until ObjGLAccounts.Next = 0;
                    end;
                    ObjGLAccounts.Reset;
                    ObjGLAccounts.SetFilter(ObjGLAccounts."No.", "Denominator G/L Account to Les");
                    ObjGLAccounts.SetFilter(ObjGLAccounts."Date Filter", VarDateFilter);
                    if ObjGLAccounts.FindSet then begin
                        repeat
                            ObjGLAccounts.CalcFields(ObjGLAccounts.Balance);
                            VarTotalDenominatorLessGLBalance := VarTotalDenominatorLessGLBalance + ObjGLAccounts.Balance;
                        until ObjGLAccounts.Next = 0;
                    end;
                    VarDenominatorGLBalance := VarTotalDenominatorSumGLBalance - VarTotalDenominatorLessGLBalance;
                end;
                //==================================================================================================End Multiple Base Accounts
                VarActualPercentage := 0;
                if (VarBaseGLBalance <> 0) and (VarDenominatorGLBalance <> 0) then begin
                    VarActualPercentage := (VarBaseGLBalance / VarDenominatorGLBalance) * 100;
                end;
                FnRunInsiderBalances;
                FnRunDeliquentLoansOver1Year;
                if ("Use Deliquent Loans Over 1Y D" = true) and (VarDeliquentLoansOver1Year <> 0) then begin
                    VarActualPercentage := (VarBaseGLBalance / VarDeliquentLoansOver1Year) * 100;
                end;
                if VarTotalInsiderLoans <> 0 then begin
                    if "Insider Lending/T.Asset Staff" = true then begin
                        VarActualPercentage := (VarTotalInsiderLoans / VarInsiderLoansStaff) * 100;
                    end;
                    if "Insider Lending/T.Asset Board" = true then begin
                        VarActualPercentage := (VarTotalInsiderLoans / VarInsiderLoansBoard) * 100;
                    end;
                    if ("Total Insider/Total assets" = true) or ("Total Insider/Total Loans" = true) then begin
                        VarActualPercentage := (VarTotalInsiderLoans / VarDenominatorGLBalance) * 100;
                    end;
                    if "Insider Loans/Deposit Board" = true then begin
                        VarActualPercentage := (VarTotalInsiderLoans / VarInsiderDepositsBoard) * 100;
                    end;
                    if "Insider Loans/Deposit Staff" = true then begin
                        VarActualPercentage := (VarTotalInsiderLoans / VarInsiderDepositsStaff) * 100;
                    end;
                end;
                if "Show Amount" = true then begin
                    VarActualPercentage := VarBaseGLBalance;
                end;
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
                    field(VarReportDate; VarReportDate)
                    {
                        ApplicationArea = Basic;
                        Caption = 'At At';
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
        Company.Get();
        Company.CalcFields(Company.Picture);
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
        Company: Record "Company Information";
        SFactory: Codeunit "SURESTEP Factory";
        ObjGLAccounts: Record "G/L Account";
        VarDateFilter: Text;
        VarReportDate: Date;
        VarBaseGLBalance: Decimal;
        VarDenominatorGLBalance: Decimal;
        VarBaseGLAccounts: Text;
        VarDenominatorGLAccounts: Text;
        VarTotalBaseSumGLBalance: Decimal;
        VarTotalBaseLessGLBalance: Decimal;
        VarTotalDenominatorSumGLBalance: Decimal;
        VarTotalDenominatorLessGLBalance: Decimal;
        VarActualPercentage: Decimal;
        VarTotalInsiderLoans: Decimal;
        VarTotalInsiderDeposits: Decimal;
        VarInsiderLoansStaff: Decimal;
        VarInsiderLoansBoard: Decimal;
        VarInsiderDepositsStaff: Decimal;
        VarInsiderDepositsBoard: Decimal;
        ObjLoans: Record "Loans Register";
        ObjMembers: Record "Members Register";
        VarDeliquentLoansOver1Year: Decimal;
        ObjLoanPortfolioProvision: Record "Loan Portfolio Provision";

    local procedure FnRunInsiderBalances()
    begin
        //=====================================================================Total Insider Loans
        ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
        ObjLoans.Reset;
        ObjLoans.SetFilter(ObjLoans."Insider Status", '<>%1', ObjLoans."insider status"::" ");
        ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
        if ObjLoans.FindSet then begin
            repeat
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                VarTotalInsiderLoans := VarTotalInsiderLoans + ObjLoans."Outstanding Balance";
            until ObjLoans.Next = 0;
        end;
        ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
        ObjLoans.Reset;
        ObjLoans.SetFilter(ObjLoans."Insider Status", '%1', ObjLoans."insider status"::"Staff Member");
        ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
        if ObjLoans.FindSet then begin
            repeat
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                VarInsiderLoansStaff := VarInsiderLoansStaff + ObjLoans."Outstanding Balance";
            until ObjLoans.Next = 0;
        end;
        ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
        ObjLoans.Reset;
        ObjLoans.SetFilter(ObjLoans."Insider Status", '%1', ObjLoans."insider status"::"Board Member");
        ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
        if ObjLoans.FindSet then begin
            repeat
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                VarInsiderLoansBoard := VarInsiderLoansBoard + ObjLoans."Outstanding Balance";
            until ObjLoans.Next = 0;
        end;
        //=====================================================================End Total Insider Loans
        //======================================================================Insider Savings
        ObjMembers.CalcFields(ObjMembers."Current Shares");
        ObjMembers.Reset;
        ObjMembers.SetFilter(ObjMembers."Insider Status", '<>%1', ObjMembers."insider status"::" ");
        ObjMembers.SetFilter(ObjMembers."Current Shares", '>%1', 0);
        if ObjMembers.FindSet then begin
            repeat
                ObjMembers.CalcFields(ObjMembers."Current Shares");
                VarTotalInsiderDeposits := VarTotalInsiderDeposits + ObjMembers."Current Shares";
            until ObjMembers.Next = 0;
        end;
        ObjMembers.CalcFields(ObjMembers."Current Shares");
        ObjMembers.Reset;
        ObjMembers.SetFilter(ObjMembers."Insider Status", '%1', ObjMembers."insider status"::"Staff Member");
        ObjMembers.SetFilter(ObjMembers."Current Shares", '>%1', 0);
        if ObjMembers.FindSet then begin
            repeat
                ObjMembers.CalcFields(ObjMembers."Current Shares");
                VarInsiderDepositsStaff := VarInsiderDepositsStaff + ObjMembers."Current Shares";
            until ObjMembers.Next = 0;
        end;
        ObjMembers.CalcFields(ObjMembers."Current Shares");
        ObjMembers.Reset;
        ObjMembers.SetFilter(ObjMembers."Insider Status", '%1', ObjMembers."insider status"::"Board Member");
        ObjMembers.SetFilter(ObjMembers."Current Shares", '>%1', 0);
        if ObjMembers.FindSet then begin
            repeat
                ObjMembers.CalcFields(ObjMembers."Current Shares");
                VarInsiderDepositsBoard := VarInsiderDepositsBoard + ObjMembers."Current Shares";
            until ObjMembers.Next = 0;
        end;
        //==================================================================End Total Insider Savings
    end;

    local procedure FnRunDeliquentLoansOver1Year()
    begin
        ObjLoanPortfolioProvision.Reset;
        ObjLoanPortfolioProvision.SetFilter(ObjLoanPortfolioProvision."Report Date", '%1', VarReportDate);
        ObjLoanPortfolioProvision.SetFilter(ObjLoanPortfolioProvision."Arrears Days", '>%1', 365);
        if ObjLoanPortfolioProvision.FindSet then begin
            ObjLoanPortfolioProvision.CalcSums(ObjLoanPortfolioProvision."Outstanding Balance");
            VarDeliquentLoansOver1Year := ObjLoanPortfolioProvision."Outstanding Balance";
        end;
    end;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516029_v6_3_0_2259;
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
