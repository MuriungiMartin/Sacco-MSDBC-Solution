#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516437_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50437 "Members List-2016"
{
    RDLCLayout = './Layouts/MembersList-2016.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Members Register"; "Members Register")
        {
            RequestFilterFields = "No.", "Employer Code", Gender, "Registration Date", Status, "Current Shares", "Shares Retained", "Account Category";
            column(ReportForNavId_1000000000; 1000000000) { } // Autogenerated by ForNav - Do not delete
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Address2; Company."Address 2")
            {
            }
            column(Company_PhoneNo; Company."Phone No.")
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(CurrReport_PAGENO; Format(ReportForNav.PageNo))
            {
            }
            column(UserId; UserId)
            {
            }
            column(Personal_No; "Members Register"."Payroll No")
            {
            }
            column(Registration_Date; Format("Members Register"."Registration Date"))
            {
            }
            column(Share_Capital; "Members Register"."Shares Retained")
            {
            }
            column(Deposits; "Members Register"."Monthly Contribution")
            {
                AutoCalcField = true;
            }
            column(EMail_MembersRegister; "Members Register"."E-Mail")
            {
            }
            column(No_MembersRegister; "Members Register"."No.")
            {
            }
            column(Name_MembersRegister; "Members Register".Name)
            {
            }
            column(Address_MembersRegister; "Members Register".Address)
            {
            }
            column(PhoneNo_MembersRegister; "Members Register"."Phone No.")
            {
            }
            column(RiskFund_MembersRegister; "Members Register"."Risk Fund")
            {
            }
            column(FOSAAccountNo_MembersRegister; "Members Register"."FOSA Account No.")
            {
            }
            column(SharesRetained_MembersRegister; "Members Register"."Shares Retained")
            {
            }
            column(CurrentShares_MembersRegister; "Members Register"."Current Shares")
            {
            }
            column(Status_MembersRegister; "Members Register".Status)
            {
            }
            column(DividendAmount_MembersRegister; "Members Register"."Dividend Amount")
            {
            }
            column(FOSAShares_MembersRegister; "Members Register"."FOSA Shares")
            {
            }
            column(mobile_number; "Members Register"."Mobile Phone No")
            {
            }
            column(id; "Members Register"."ID No.")
            {
            }
            column(branch; "Members Register"."Global Dimension 2 Code")
            {
            }
            column(category; "Members Register"."Account Category")
            {
            }
            column(SN; SN)
            {
            }
            trigger OnPreDataItem();
            begin
                Company.Get();
            end;

            trigger OnAfterGetRecord();
            begin
                SN := SN + 1
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
        Company: Record "Company Information";
        SN: Integer;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516437_v6_3_0_2259;
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
