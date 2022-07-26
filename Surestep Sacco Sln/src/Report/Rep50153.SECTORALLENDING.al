#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516153_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50153 "SECTORAL LENDING"
{
    RDLCLayout = './Layouts/SECTORALLENDING.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Main Sector"; "Main Sector")
        {
            column(ReportForNavId_1; 1) { } // Autogenerated by ForNav - Do not delete
            column(name; CompanyProperty.DisplayName)
            {
            }
            column(Code_MainSector; "Main Sector".Code)
            {
            }
            column(Description_MainSector; "Main Sector".Description)
            {
            }
            dataitem("Sub Sector"; "Sub Sector")
            {
                DataItemLink = No = field(Code);
                column(ReportForNavId_4; 4) { } // Autogenerated by ForNav - Do not delete
                column(Code_SubSector; "Sub Sector".Code)
                {
                }
                column(Description_SubSector; "Sub Sector".Description)
                {
                }
                dataitem("Specific Sector"; "Specific Sector")
                {
                    DataItemLink = No = field(Code);
                    column(ReportForNavId_7; 7) { } // Autogenerated by ForNav - Do not delete
                    column(Code_SpecificSector; "Specific Sector".Code)
                    {
                    }
                    column(Description_SpecificSector; "Specific Sector".Description)
                    {
                    }
                    column(AMount; AMount)
                    {
                    }
                    column(startdate; StartDate)
                    {
                    }
                    column(enddate; EndDate)
                    {
                    }
                    column(DateTday; DateTday)
                    {
                    }
                    column(DateTo; DateTo)
                    {
                    }
                    column(FinacialYear; FinacialYear)
                    {
                    }
                    trigger OnAfterGetRecord();
                    begin
                        AMount := 0;
                        LoansR.Reset;
                        LoansR.SetRange(LoansR."Sector Specific", "Specific Sector".Code);
                        LoansR.SetFilter("Issued Date", Datefilter);
                        if LoansR.FindFirst then begin
                            repeat
                                LoansR.CalcFields("Outstanding Balance");
                                AMount := AMount + LoansR."Approved Amount";
                            until LoansR.Next = 0;
                        end;
                    end;

                }
            }
        }
    }

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                field(StartDate; StartDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Starting Date';
                }
                field(EndDate; EndDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Ending Date';
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
        Datefilter := Format(StartDate) + '..' + Format(EndDate);
        GenLedgerSetup.Get();
        DateTday := Format(GenLedgerSetup."Allow Posting From");
        DateTo := Format(GenLedgerSetup."Allow Posting To");
        FinacialYear := Date2dmy(StartDate, 3);
        ;
        ReportsForNavPre;
    end;

    var
        LoansR: Record "Loans Register";
        AMount: Decimal;
        StartDate: Date;
        EndDate: Date;
        Datefilter: Text;
        GenLedgerSetup: Record "General Ledger Setup";
        DateTday: Text;
        DateTo: Text;
        FinacialYear: Integer;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516153_v6_3_0_2259;
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
