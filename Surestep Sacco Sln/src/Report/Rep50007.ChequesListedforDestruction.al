#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516007_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50007 "Cheques Listed for Destruction"
{
    RDLCLayout = './Layouts/ChequesListedforDestruction.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Cheque Book Application"; "Cheque Book Application")
        {
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
            column(No_ChequeBookApplication; "Cheque Book Application"."No.")
            {
            }
            column(AccountNo_ChequeBookApplication; "Cheque Book Application"."Account No.")
            {
            }
            column(BranchCode_ChequeBookApplication; "Cheque Book Application"."Branch Code")
            {
            }
            column(Name_ChequeBookApplication; "Cheque Book Application".Name)
            {
            }
            column(ChequeBookType_ChequeBookApplication; "Cheque Book Application"."Cheque Book Type")
            {
            }
            column(ApplicationDate_ChequeBookApplication; Format("Cheque Book Application"."Application Date", 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(ChequeBookOrdered_ChequeBookApplication; "Cheque Book Application"."Cheque Book Ordered")
            {
            }
            column(OrderedBy_ChequeBookApplication; "Cheque Book Application"."Ordered By")
            {
            }
            column(OrderedOn_ChequeBookApplication; Format("Cheque Book Application"."Ordered On", 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(ChequeBookReceived_ChequeBookApplication; "Cheque Book Application"."Cheque Book Received")
            {
            }
            column(ReceivedBy_ChequeBookApplication; "Cheque Book Application"."Received By")
            {
            }
            column(ReceivedOn_ChequeBookApplication; Format("Cheque Book Application"."Received On", 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(VarAccountType; VarAccountType)
            {
            }
            column(VarDaysElapsedAfterReceipt; VarDaysElapsedAfterReceipt * -1)
            {
            }
            column(VarListedforDistruction; VarListedforDistruction)
            {
            }
            column(ListedForDestruction_ChequeBookApplication; "Cheque Book Application"."Listed For Destruction")
            {
            }
            trigger OnPreDataItem();
            begin
                Company.Get();
                Company.CalcFields(Company.Picture);
            end;

            trigger OnAfterGetRecord();
            begin
                ObjGensetup.Get;
                ObjChequeBookApplications.Reset;
                ObjChequeBookApplications.SetRange(ObjChequeBookApplications."No.", "No.");
                ObjChequeBookApplications.SetRange(ObjChequeBookApplications."Cheque Book Received", true);
                ObjChequeBookApplications.SetRange(ObjChequeBookApplications.Collected, false);
                if ObjChequeBookApplications.FindSet then begin
                    if CalcDate(ObjGensetup."ATM Destruction Period", ObjChequeBookApplications."Received On") < WorkDate then begin
                        VarListedforDistruction := true;
                        ObjChequeBookApplications."Listed For Destruction" := true;
                        VarDaysElapsedAfterReceipt := ObjChequeBookApplications."Received On" - WorkDate;
                        ObjChequeBookApplications.Modify;
                        VarEntryNo := VarEntryNo + 1;
                    end;
                end;
                if ObjAccounts.Get("Account No.") then begin
                    if ObjAccountType.Get(ObjAccounts."Account Type") then begin
                        VarAccountType := ObjAccountType.Description;
                    end;
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
        ObjDetailedVendLedger: Record "Detailed Vendor Ledg. Entry";
        VarReportDate: Date;
        VarLedgerDateFilter: Text;
        VarAccountTypeBalance: Decimal;
        ObjChequeBookApplications: Record "Cheque Book Application";
        VarListedforDistruction: Boolean;
        VarAccountType: Code[50];
        ObjAccounts: Record Vendor;
        ObjAccountType: Record "Account Types-Saving Products";
        VarDaysElapsedAfterReceipt: Integer;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516007_v6_3_0_2259;
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