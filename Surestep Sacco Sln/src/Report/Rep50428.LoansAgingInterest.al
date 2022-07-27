#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516428_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50428 "Loans Aging - Interest"
{
    RDLCLayout = './Layouts/LoansAging-Interest.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Loans; "Loans Register")
        {
            DataItemTableView = sorting("Loan  No.") where("Interest Due" = filter(> 0));
            RequestFilterFields = "Transacting Branch", "Loan Product Type", "Issued Date", "Date filter";
            column(ReportForNavId_4645; 4645) { } // Autogenerated by ForNav - Do not delete
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; Format(ReportForNav.PageNo))
            {
            }
            column(UserId; UserId)
            {
            }
            column(Loans__Loan__No__; Loans."Loan  No.")
            {
            }
            column(Loans__Loan_Product_Type_; Loans."Loan Product Type")
            {
            }
            column(Loans__Client_Code_; Loans."Client Code")
            {
            }
            column(Loans__Client_Name_; Loans."Client Name")
            {
            }
            column(Loans_Loans__Interest_Due_; Loans."Interest Due")
            {
            }
            column(V1Month_; "1Month")
            {
            }
            column(V2Month_; "2Month")
            {
            }
            column(V3Month_; "3Month")
            {
            }
            column(Over3Month; Over3Month)
            {
            }
            column(Loans__Last_Interest_Pay_Date_; Loans."Last Interest Due Date")
            {
            }
            column(Over3Month_Control1102760000; Over3Month)
            {
            }
            column(V3Month__Control1102760001; "3Month")
            {
            }
            column(V2Month__Control1102760002; "2Month")
            {
            }
            column(V1Month__Control1102760003; "1Month")
            {
            }
            column(Loans_Loans__Interest_Due__Control1102760005; Loans."Interest Due")
            {
            }
            column(V1MonthC_; "1MonthC")
            {
            }
            column(V2MonthC_; "2MonthC")
            {
            }
            column(V3MonthC_; "3MonthC")
            {
            }
            column(Over3MonthC; Over3MonthC)
            {
            }
            column(NoLoans; NoLoans)
            {
            }
            column(Loans_Interest_Aging_AnalysisCaption; Loans_Interest_Aging_AnalysisCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Loans__Loan__No__Caption; FieldCaption("Loan  No."))
            {
            }
            column(Loan_TypeCaption; Loan_TypeCaptionLbl)
            {
            }
            column(Loans__Client_Code_Caption; FieldCaption("Client Code"))
            {
            }
            column(Loans__Client_Name_Caption; FieldCaption("Client Name"))
            {
            }
            column(V0___1_MonthsCaption; V0___1_MonthsCaptionLbl)
            {
            }
            column(Oustanding_InterestCaption; Oustanding_InterestCaptionLbl)
            {
            }
            column(V2___3_MonthsCaption; V2___3_MonthsCaptionLbl)
            {
            }
            column(V1___2_MonthsCaption; V1___2_MonthsCaptionLbl)
            {
            }
            column(Over_3_MonthsCaption; Over_3_MonthsCaptionLbl)
            {
            }
            column(Loans__Last_Interest_Pay_Date_Caption; FieldCaption("Last Interest Pay Date"))
            {
            }
            column(TotalsCaption; TotalsCaptionLbl)
            {
            }
            column(CountCaption; CountCaptionLbl)
            {
            }
            trigger OnPreDataItem();
            begin

            end;

            trigger OnAfterGetRecord();
            begin
                NoLoans := NoLoans + 1;
                if AsAt = 0D then
                    AsAt := Today;
                Evaluate(DFormula, '1Q');
                "1Month" := 0;
                "2Month" := 0;
                "3Month" := 0;
                Over3Month := 0;
                Loans.CalcFields(Loans."Last Interest Due Date", Loans."Interest Due");
                if Loans."Instalment Period" = DFormula then
                    LastDueDate := CalcDate('1Q', Loans."Last Interest Due Date")
                else
                    LastDueDate := Loans."Last Interest Pay Date";
                if LastDueDate = 0D then begin
                    if Loans."Issued Date" <> 0D then begin
                        if LoanProduct.Get(Loans."Loan Product Type") then begin
                            if LoanProduct."Check Off Recovery" = false then begin
                                FirstMonthDate := Dmy2date(1, Date2dmy(Loans."Issued Date", 2), Date2dmy(Loans."Issued Date", 3));
                                EndMonthDate := CalcDate('-1D', CalcDate('1M', FirstMonthDate));
                                //LastDueDate:=CALCDATE('-2D',FirstMonthDate);//Loans."Issued Date"
                                if Date2dmy(Loans."Issued Date", 1) < 20 then
                                    LastDueDate := CalcDate('-2D', FirstMonthDate)
                                else
                                    LastDueDate := EndMonthDate;
                            end else begin
                                FirstMonthDate := Dmy2date(1, Date2dmy(Loans."Issued Date", 2), Date2dmy(Loans."Issued Date", 3));
                                EndMonthDate := CalcDate('-1D', CalcDate('1M', FirstMonthDate));
                                LastDueDate := EndMonthDate;//Loans."Issued Date";//CALCDATE('1M',Loans."Issued Date");
                            end;
                        end;
                    end;
                end;
                if LastDueDate > CalcDate('-1M', AsAt) then begin
                    "1Month" := Loans."Interest Due";
                    "1MonthC" := "1MonthC" + 1;
                end else
                    if LastDueDate > CalcDate('-2M', AsAt) then begin
                        "2Month" := Loans."Interest Due";
                        "2MonthC" := "2MonthC" + 1;
                    end else
                        if LastDueDate > CalcDate('-3M', AsAt) then begin
                            "3Month" := Loans."Interest Due";
                            "3MonthC" := "3MonthC" + 1;
                        end else
                            if LastDueDate > CalcDate('-4M', AsAt) then begin
                                Over3Month := Loans."Interest Due";
                                Over3MonthC := Over3MonthC + 1;
                            end else begin
                                Over3Month := Loans."Interest Due";
                                Over3MonthC := Over3MonthC + 1;
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
        "1Month": Decimal;
        "2Month": Decimal;
        "3Month": Decimal;
        Over3Month: Decimal;
        ShowLoan: Boolean;
        AsAt: Date;
        LastDueDate: Date;
        DFormula: DateFormula;
        "1MonthC": Integer;
        "2MonthC": Integer;
        "3MonthC": Integer;
        Over3MonthC: Integer;
        NoLoans: Integer;
        DRate: Decimal;
        LoanProduct: Record "Loan Products Setup";
        FirstMonthDate: Date;
        EndMonthDate: Date;
        Loans_Interest_Aging_AnalysisCaptionLbl: label 'Loans Interest Aging Analysis';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Loan_TypeCaptionLbl: label 'Loan Type';
        V0___1_MonthsCaptionLbl: label '0 - 1 Months';
        Oustanding_InterestCaptionLbl: label 'Oustanding Interest';
        V2___3_MonthsCaptionLbl: label '2 - 3 Months';
        V1___2_MonthsCaptionLbl: label '1 - 2 Months';
        Over_3_MonthsCaptionLbl: label 'Over 3 Months';
        TotalsCaptionLbl: label 'Totals';
        CountCaptionLbl: label 'Count';

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516428_v6_3_0_2259;
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
