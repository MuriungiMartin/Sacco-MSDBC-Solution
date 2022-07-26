#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516056_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50056 "Insider Lending & Saving Sum."
{
    RDLCLayout = './Layouts/InsiderLending&SavingSum..rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = where("Insider Status" = filter(<> " "), "Outstanding Balance" = filter(> 1));
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
            column(VarBoardTotalLoans; VarBoardTotalLoans)
            {
            }
            column(VarBoardDeposit; VarBoardDeposit)
            {
            }
            column(VarBoardShareCapital; VarBoardShareCapital)
            {
            }
            column(VarBoardArrears; VarBoardArrears)
            {
            }
            column(VarStaffTotalLoans; VarStaffTotalLoans)
            {
            }
            column(VarStaffDeposit; VarStaffDeposit)
            {
            }
            column(VarStaffShareCapital; VarStaffShareCapital)
            {
            }
            column(VarStaffArrears; VarStaffArrears)
            {
            }
            column(VarFromDate; Format(VarFromDate, 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(VarToDate; Format(VarToDate, 0, '<Day,2> <Month Text,3> <Year4>'))
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
                VarDateFilter := '..' + Format(VarToDate);
                //===================================================================Board
                ObjLoans.Reset;
                ObjLoans.SetRange(ObjLoans."Insider Status", ObjLoans."insider status"::"Board Member");
                ObjLoans.SetFilter(ObjLoans."Date filter", VarDateFilter);
                if ObjLoans.FindSet then begin
                    VarBoardTotalLoans := 0;
                    VarBoardArrears := 0;
                    VarBoardDeposit := 0;
                    VarBoardShareCapital := 0;
                    VarStaffTotalLoans := 0;
                    VarStaffArrears := 0;
                    VarStaffDeposit := 0;
                    VarStaffShareCapital := 0;
                    repeat
                        ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                        VarBoardTotalLoans := VarBoardTotalLoans + ObjLoans."Outstanding Balance";
                    until ObjLoans.Next = 0;
                    ObjLoans.CalcSums(ObjLoans."Amount in Arrears");
                    VarBoardArrears := ObjLoans."Amount in Arrears";
                end;
                ObjCust.Reset;
                ObjCust.SetRange(ObjCust."Insider Status", ObjCust."insider status"::"Board Member");
                ObjCust.SetFilter(ObjCust."Date Filter", VarDateFilter);
                if ObjCust.FindSet then begin
                    repeat
                        ObjCust.CalcFields(ObjCust."Current Shares", ObjCust."Shares Retained");
                        VarBoardDeposit := VarBoardDeposit + ObjCust."Current Shares";
                        VarBoardShareCapital := VarBoardShareCapital + ObjCust."Shares Retained";
                    until ObjCust.Next = 0;
                end;
                //===================================================================Staff
                ObjLoans.Reset;
                ObjLoans.SetRange(ObjLoans."Insider Status", ObjLoans."insider status"::"Staff Member");
                ObjLoans.SetFilter(ObjLoans."Date filter", VarDateFilter);
                if ObjLoans.FindSet then begin
                    repeat
                        ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                        VarStaffTotalLoans := VarStaffTotalLoans + ObjLoans."Outstanding Balance";
                    until ObjLoans.Next = 0;
                    ObjLoans.CalcSums(ObjLoans."Amount in Arrears");
                    VarStaffArrears := ObjLoans."Amount in Arrears";
                end;
                ObjCust.Reset;
                ObjCust.SetRange(ObjCust."Insider Status", ObjCust."insider status"::"Staff Member");
                ObjCust.SetFilter(ObjCust."Date Filter", VarDateFilter);
                if ObjCust.FindSet then begin
                    repeat
                        ObjCust.CalcFields(ObjCust."Current Shares", ObjCust."Shares Retained");
                        VarStaffDeposit := VarStaffDeposit + ObjCust."Current Shares";
                        VarStaffShareCapital := VarStaffShareCapital + ObjCust."Shares Retained";
                    until ObjCust.Next = 0;
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
        ObjCust: Record "Members Register";
        VarBoardTotalLoans: Decimal;
        VarBoardDeposit: Decimal;
        VarBoardShareCapital: Decimal;
        VarBoardArrears: Decimal;
        VarStaffTotalLoans: Decimal;
        VarStaffDeposit: Decimal;
        VarStaffShareCapital: Decimal;
        VarStaffArrears: Decimal;
        VarFromDate: Date;
        VarToDate: Date;
        VarDateFilter: Text;
        ObjLoans: Record "Loans Register";

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516056_v6_3_0_2259;
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