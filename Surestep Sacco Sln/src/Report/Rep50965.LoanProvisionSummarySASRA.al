#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516965_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50965 "Loan Provision Summary - SASRA"
{
    RDLCLayout = './Layouts/LoanProvisionSummary-SASRA.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Loan Portfolio Provision"; "Loan Portfolio Provision")
        {
            DataItemTableView = sorting("Loan No", "Report Date");
            RequestFilterFields = "Loan No", "Member No", Classification, Rescheduled, "Report Date";
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
            column(LoanNo_LoanPortfolioProvision; "Loan Portfolio Provision"."Loan No")
            {
            }
            column(MemberNo_LoanPortfolioProvision; "Loan Portfolio Provision"."Member No")
            {
            }
            column(MemberName_LoanPortfolioProvision; "Loan Portfolio Provision"."Member Name")
            {
            }
            column(Performing_LoanPortfolioProvision; "Loan Portfolio Provision".Performing)
            {
            }
            column(Watch_LoanPortfolioProvision; "Loan Portfolio Provision".Watch)
            {
            }
            column(Substandard_LoanPortfolioProvision; "Loan Portfolio Provision".Substandard)
            {
            }
            column(Doubtful_LoanPortfolioProvision; "Loan Portfolio Provision".Doubtful)
            {
            }
            column(Loss_LoanPortfolioProvision; "Loan Portfolio Provision".Loss)
            {
            }
            column(OutstandingBalance_LoanPortfolioProvision; "Loan Portfolio Provision"."Outstanding Balance")
            {
            }
            column(ArrearsAmount_LoanPortfolioProvision; "Loan Portfolio Provision"."Arrears Amount")
            {
            }
            column(ArrearsDays_LoanPortfolioProvision; "Loan Portfolio Provision"."Arrears Days")
            {
            }
            column(Classification_LoanPortfolioProvision; "Loan Portfolio Provision".Classification)
            {
            }
            column(Rescheduled_LoanPortfolioProvision; "Loan Portfolio Provision".Rescheduled)
            {
            }
            column(ReportDate_LoanPortfolioProvision; "Loan Portfolio Provision"."Report Date")
            {
            }
            column(VarPerformingCount; VarPerformingCount)
            {
            }
            column(VarPerformingTotal; VarPerformingTotal)
            {
            }
            column(VarPerformingReqProvision; VarPerformingReqProvision)
            {
            }
            column(VarPerformimgProvisionPercentage; "VarPerformimgProvision%")
            {
            }
            column(VarWatchCount; VarWatchCount)
            {
            }
            column(VarWatchTotal; VarWatchTotal)
            {
            }
            column(VarWatchReqProvision; VarWatchReqProvision)
            {
            }
            column(VarWatchProvisionPercentage; "VarWatchProvision%")
            {
            }
            column(VarSubstandardCount; VarSubstandardCount)
            {
            }
            column(VarSubstandardTotal; VarSubstandardTotal)
            {
            }
            column(VarSubstandardProvisionPercentage; "VarSubstandardProvision%")
            {
            }
            column(VarDoubtfulCount; VarDoubtfulCount)
            {
            }
            column(VarDoubtfulTotal; VarDoubtfulTotal)
            {
            }
            column(VarDoubtfulReqProvision; VarDoubtfulReqProvision)
            {
            }
            column(VarDoubtfulProvisionPercentage; "VarDoubtfulProvision%")
            {
            }
            column(VarLossCount; VarLossCount)
            {
            }
            column(VarLossTotal; VarLossTotal)
            {
            }
            column(VarLossReqProvision; VarLossReqProvision)
            {
            }
            column(VarLossProvisionPercenatage; "VarLossProvision%")
            {
            }
            column(VarPerformingCountResheduled; VarPerformingCountResheduled)
            {
            }
            column(VarPerformingTotalResheduled; VarPerformingTotalResheduled)
            {
            }
            column(VarPerformingReqProvisionResheduled; VarPerformingReqProvisionResheduled)
            {
            }
            column(VarPerformimgProvisionPercentageResheduled; "VarPerformimgProvision%Resheduled")
            {
            }
            column(VarWatchCountResheduled; VarWatchCountResheduled)
            {
            }
            column(VarWatchTotalResheduled; VarWatchTotalResheduled)
            {
            }
            column(VarWatchReqProvisionResheduled; VarWatchReqProvisionResheduled)
            {
            }
            column(VarWatchProvisionPercentageResheduled; "VarWatchProvision%Resheduled")
            {
            }
            column(VarSubstandardCountResheduled; VarSubstandardCountResheduled)
            {
            }
            column(VarSubstandardTotalResheduled; VarSubstandardTotalResheduled)
            {
            }
            column(VarSubstandardReqProvisionResheduled; VarSubstandardReqProvisionResheduled)
            {
            }
            column(VarSubstandardReqProvision; VarSubstandardReqProvision)
            {
            }
            column(VarSubstandardProvisionPercantageResheduled; "VarSubstandardProvision%Resheduled")
            {
            }
            column(VarDoubtfulCountResheduled; VarDoubtfulCountResheduled)
            {
            }
            column(VarDoubtfulTotalResheduled; VarDoubtfulTotalResheduled)
            {
            }
            column(VarDoubtfulReqProvisionResheduled; VarDoubtfulReqProvisionResheduled)
            {
            }
            column(VarDoubtfulProvisionPercentageResheduled; "VarDoubtfulProvision%Resheduled")
            {
            }
            column(VarLossCountResheduled; VarLossCountResheduled)
            {
            }
            column(VarLossTotalResheduled; VarLossTotalResheduled)
            {
            }
            column(VarLossReqProvisionResheduled; VarLossReqProvisionResheduled)
            {
            }
            column(VarLossProvisionPercenatageResheduled; "VarLossProvision%Resheduled")
            {
            }
            column(VarReportDate; VarReportDate)
            {
            }
            trigger OnPreDataItem();
            begin
                Company.Get();
                Company.CalcFields(Company.Picture);
                SFactory.FnUpdateLoanPortfolio(VarReportDate);
                FnRunLoansNotRescheduled;
                FnRunLoansRescheduled;
                "Loan Portfolio Provision".SetFilter("Loan Portfolio Provision"."Report Date", '%1', VarReportDate);
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
                field(VarReportDate; VarReportDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Report Date';
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
        VarPerformingCount: Integer;
        VarPerformingTotal: Decimal;
        VarPerformingReqProvision: Decimal;
        "VarPerformimgProvision%": Decimal;
        VarWatchCount: Integer;
        VarWatchTotal: Decimal;
        VarWatchReqProvision: Decimal;
        "VarWatchProvision%": Decimal;
        VarSubstandardCount: Integer;
        VarSubstandardTotal: Decimal;
        VarSubstandardReqProvision: Decimal;
        "VarSubstandardProvision%": Decimal;
        VarDoubtfulCount: Integer;
        VarDoubtfulTotal: Decimal;
        VarDoubtfulReqProvision: Decimal;
        "VarDoubtfulProvision%": Decimal;
        VarLossCount: Integer;
        VarLossTotal: Decimal;
        VarLossReqProvision: Decimal;
        "VarLossProvision%": Decimal;
        VarPerformingCountResheduled: Integer;
        VarPerformingTotalResheduled: Decimal;
        VarPerformingReqProvisionResheduled: Decimal;
        "VarPerformimgProvision%Resheduled": Decimal;
        VarWatchCountResheduled: Integer;
        VarWatchTotalResheduled: Decimal;
        VarWatchReqProvisionResheduled: Decimal;
        "VarWatchProvision%Resheduled": Decimal;
        VarSubstandardCountResheduled: Integer;
        VarSubstandardTotalResheduled: Decimal;
        VarSubstandardReqProvisionResheduled: Decimal;
        "VarSubstandardProvision%Resheduled": Decimal;
        VarDoubtfulCountResheduled: Integer;
        VarDoubtfulTotalResheduled: Decimal;
        VarDoubtfulReqProvisionResheduled: Decimal;
        "VarDoubtfulProvision%Resheduled": Decimal;
        VarLossCountResheduled: Integer;
        VarLossTotalResheduled: Decimal;
        VarLossReqProvisionResheduled: Decimal;
        "VarLossProvision%Resheduled": Decimal;
        ObjLoanProvision: Record "Loan Portfolio Provision";
        CurrReport_PAGENOCaptionLbl: label 'Page';
        RISK_CLASSIFICATION_OF_ASSETS_AND_PROVISIONINGCaptionLbl: label 'RISK CLASSIFICATION OF ASSETS AND PROVISIONING';
        FORM_4CaptionLbl: label 'FORM 4';
        SASRA_2_004CaptionLbl: label 'SASRA 2/004';
        R__46_CaptionLbl: label 'R.(46)';
        VarReportDate: Date;

    local procedure FnRunLoansNotRescheduled()
    begin
        ObjGensetup.Get();
        //========================================================Performing
        ObjLoanProvision.Reset;
        ObjLoanProvision.SetRange(ObjLoanProvision.Classification, ObjLoanProvision.Classification::Perfoming);
        ObjLoanProvision.SetFilter(ObjLoanProvision."Report Date", '%1', VarReportDate);
        ObjLoanProvision.SetRange(ObjLoanProvision.Rescheduled, false);
        if ObjLoanProvision.FindSet then begin
            VarPerformingCount := ObjLoanProvision.Count;
            ObjLoanProvision.CalcSums(ObjLoanProvision."Outstanding Balance");
            VarPerformingTotal := ObjLoanProvision."Outstanding Balance";
            "VarPerformimgProvision%" := ObjGensetup."Performing Required Provision%";
            VarPerformingReqProvision := VarPerformingTotal * "VarPerformimgProvision%";
        end;
        //========================================================Watch
        ObjLoanProvision.Reset;
        ObjLoanProvision.SetRange(ObjLoanProvision.Classification, ObjLoanProvision.Classification::Watch);
        ObjLoanProvision.SetFilter(ObjLoanProvision."Report Date", '%1', VarReportDate);
        ObjLoanProvision.SetRange(ObjLoanProvision.Rescheduled, false);
        if ObjLoanProvision.FindSet then begin
            VarWatchCount := ObjLoanProvision.Count;
            ObjLoanProvision.CalcSums(ObjLoanProvision."Outstanding Balance");
            VarWatchTotal := ObjLoanProvision."Outstanding Balance";
            "VarWatchProvision%" := ObjGensetup."Watch Required Provision%";
            VarWatchReqProvision := VarWatchTotal * "VarWatchProvision%";
        end;
        //========================================================Substandard
        ObjLoanProvision.Reset;
        ObjLoanProvision.SetRange(ObjLoanProvision.Classification, ObjLoanProvision.Classification::Substandard);
        ObjLoanProvision.SetFilter(ObjLoanProvision."Report Date", '%1', VarReportDate);
        ObjLoanProvision.SetRange(ObjLoanProvision.Rescheduled, false);
        if ObjLoanProvision.FindSet then begin
            VarSubstandardCount := ObjLoanProvision.Count;
            ObjLoanProvision.CalcSums(ObjLoanProvision."Outstanding Balance");
            VarSubstandardTotal := ObjLoanProvision."Outstanding Balance";
            "VarSubstandardProvision%" := ObjGensetup."Substandar Required Provision%";
            VarSubstandardReqProvision := VarSubstandardTotal * "VarSubstandardProvision%";
        end;
        //========================================================Doubtful
        ObjLoanProvision.Reset;
        ObjLoanProvision.SetRange(ObjLoanProvision.Classification, ObjLoanProvision.Classification::Doubtful);
        ObjLoanProvision.SetFilter(ObjLoanProvision."Report Date", '%1', VarReportDate);
        ObjLoanProvision.SetRange(ObjLoanProvision.Rescheduled, false);
        if ObjLoanProvision.FindSet then begin
            VarDoubtfulCount := ObjLoanProvision.Count;
            ObjLoanProvision.CalcSums(ObjLoanProvision."Outstanding Balance");
            VarDoubtfulTotal := ObjLoanProvision."Outstanding Balance";
            "VarDoubtfulProvision%" := ObjGensetup."Doubtful Required Provision%";
            VarDoubtfulReqProvision := VarDoubtfulTotal * "VarDoubtfulProvision%";
        end;
        //========================================================Loss
        ObjLoanProvision.Reset;
        ObjLoanProvision.SetRange(ObjLoanProvision.Classification, ObjLoanProvision.Classification::Loss);
        ObjLoanProvision.SetFilter(ObjLoanProvision."Report Date", '%1', VarReportDate);
        ObjLoanProvision.SetRange(ObjLoanProvision.Rescheduled, false);
        if ObjLoanProvision.FindSet then begin
            VarLossCount := ObjLoanProvision.Count;
            ObjLoanProvision.CalcSums(ObjLoanProvision."Outstanding Balance");
            VarLossTotal := ObjLoanProvision."Outstanding Balance";
            "VarLossProvision%" := ObjGensetup."Loss Required Provision%";
            VarLossReqProvision := VarLossTotal * "VarLossProvision%";
        end;
    end;

    local procedure FnRunLoansRescheduled()
    begin
        ObjGensetup.Get();
        //========================================================Performing
        ObjLoanProvision.Reset;
        ObjLoanProvision.SetRange(ObjLoanProvision.Classification, ObjLoanProvision.Classification::Perfoming);
        ObjLoanProvision.SetFilter(ObjLoanProvision."Report Date", '%1', VarReportDate);
        ObjLoanProvision.SetRange(ObjLoanProvision.Rescheduled, true);
        if ObjLoanProvision.FindSet then begin
            VarPerformingCountResheduled := ObjLoanProvision.Count;
            ObjLoanProvision.CalcSums(ObjLoanProvision."Outstanding Balance");
            VarPerformingTotalResheduled := ObjLoanProvision."Outstanding Balance";
            "VarPerformimgProvision%Resheduled" := ObjGensetup."Performing Required Provision%";
            VarPerformingReqProvisionResheduled := VarPerformingTotalResheduled * "VarPerformimgProvision%Resheduled";
        end;
        //========================================================Watch
        ObjLoanProvision.Reset;
        ObjLoanProvision.SetRange(ObjLoanProvision.Classification, ObjLoanProvision.Classification::Watch);
        ObjLoanProvision.SetFilter(ObjLoanProvision."Report Date", '%1', VarReportDate);
        ObjLoanProvision.SetRange(ObjLoanProvision.Rescheduled, true);
        if ObjLoanProvision.FindSet then begin
            VarWatchCountResheduled := ObjLoanProvision.Count;
            ObjLoanProvision.CalcSums(ObjLoanProvision."Outstanding Balance");
            VarWatchTotalResheduled := ObjLoanProvision."Outstanding Balance";
            "VarWatchProvision%Resheduled" := ObjGensetup."Watch Required Provision%";
            VarWatchReqProvisionResheduled := VarWatchTotalResheduled * "VarWatchProvision%Resheduled";
        end;
        //========================================================Substandard
        ObjLoanProvision.Reset;
        ObjLoanProvision.SetRange(ObjLoanProvision.Classification, ObjLoanProvision.Classification::Substandard);
        ObjLoanProvision.SetFilter(ObjLoanProvision."Report Date", '%1', VarReportDate);
        ObjLoanProvision.SetRange(ObjLoanProvision.Rescheduled, true);
        if ObjLoanProvision.FindSet then begin
            VarSubstandardCountResheduled := ObjLoanProvision.Count;
            ObjLoanProvision.CalcSums(ObjLoanProvision."Outstanding Balance");
            VarSubstandardTotalResheduled := ObjLoanProvision."Outstanding Balance";
            "VarSubstandardProvision%Resheduled" := ObjGensetup."Substandar Required Provision%";
            VarSubstandardReqProvisionResheduled := VarSubstandardTotalResheduled * "VarSubstandardProvision%Resheduled";
        end;
        //========================================================Doubtful
        ObjLoanProvision.Reset;
        ObjLoanProvision.SetRange(ObjLoanProvision.Classification, ObjLoanProvision.Classification::Doubtful);
        ObjLoanProvision.SetFilter(ObjLoanProvision."Report Date", '%1', VarReportDate);
        ObjLoanProvision.SetRange(ObjLoanProvision.Rescheduled, true);
        if ObjLoanProvision.FindSet then begin
            VarDoubtfulCountResheduled := ObjLoanProvision.Count;
            ObjLoanProvision.CalcSums(ObjLoanProvision."Outstanding Balance");
            VarDoubtfulTotalResheduled := ObjLoanProvision."Outstanding Balance";
            "VarDoubtfulProvision%Resheduled" := ObjGensetup."Doubtful Required Provision%";
            VarDoubtfulReqProvisionResheduled := VarDoubtfulTotalResheduled * "VarDoubtfulProvision%Resheduled";
        end;
        //========================================================Loss
        ObjLoanProvision.Reset;
        ObjLoanProvision.SetRange(ObjLoanProvision.Classification, ObjLoanProvision.Classification::Loss);
        ObjLoanProvision.SetFilter(ObjLoanProvision."Report Date", '%1', VarReportDate);
        ObjLoanProvision.SetRange(ObjLoanProvision.Rescheduled, true);
        if ObjLoanProvision.FindSet then begin
            VarLossCountResheduled := ObjLoanProvision.Count;
            ObjLoanProvision.CalcSums(ObjLoanProvision."Outstanding Balance");
            VarLossTotalResheduled := ObjLoanProvision."Outstanding Balance";
            "VarLossProvision%Resheduled" := ObjGensetup."Loss Required Provision%";
            VarLossReqProvisionResheduled := VarLossTotalResheduled * "VarLossProvision%Resheduled";
        end;
    end;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516965_v6_3_0_2259;
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
