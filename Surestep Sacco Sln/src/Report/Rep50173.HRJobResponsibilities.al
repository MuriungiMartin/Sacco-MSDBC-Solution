#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516173_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50173 "HR Job Responsibilities"
{
    RDLCLayout = './Layouts/HRJobResponsibilities.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("HR Jobss"; "HR Jobss")
        {
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Job ID";
            column(ReportForNavId_9002; 9002) { } // Autogenerated by ForNav - Do not delete
            column(JobDescription_HRJobs; "HR Jobss"."Job Description")
            {
                IncludeCaption = true;
            }
            column(CI_Name; CI.Name)
            {
                IncludeCaption = true;
            }
            column(CI_Address; CI.Address)
            {
                IncludeCaption = true;
            }
            column(CI_Address2; CI."Address 2")
            {
                IncludeCaption = true;
            }
            column(CI_City; CI.City)
            {
                IncludeCaption = true;
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
                IncludeCaption = true;
            }
            column(CI_Picture; CI.Picture)
            {
                IncludeCaption = true;
            }
            dataitem("HR Job Responsiblities"; "HR Job Responsiblities")
            {
                DataItemLink = "Job ID" = field("Job ID");
                DataItemTableView = sorting("Job ID", "Responsibility Code");
                PrintOnlyIfDetail = false;
                column(ReportForNavId_3841; 3841) { } // Autogenerated by ForNav - Do not delete
                column(JobID_HRJobResponsiblities; "HR Job Responsiblities"."Job ID")
                {
                    IncludeCaption = true;
                }
                column(ResponsibilityDescription_HRJobResponsiblities; "HR Job Responsiblities"."Responsibility Description")
                {
                    IncludeCaption = true;
                }
                column(Remarks_HRJobResponsiblities; "HR Job Responsiblities".Remarks)
                {
                    IncludeCaption = true;
                }
                column(ResponsibilityCode_HRJobResponsiblities; "HR Job Responsiblities"."Responsibility Code")
                {
                    IncludeCaption = true;
                }
                trigger OnPreDataItem();
                begin
                    No := 0;
                end;

                trigger OnAfterGetRecord();
                begin
                    No := No + 1;
                end;

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
        CI.Get();
        CI.CalcFields(CI.Picture);
        No := 1;
        ;
        ReportsForNavPre;
    end;

    var
        CI: Record "Company Information";
        No: Integer;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516173_v6_3_0_2259;
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