#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516065_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50065 "House Groups Report"
{
    RDLCLayout = './Layouts/HouseGroupsReport.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Member House Groups"; "Member House Groups")
        {
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Cell Group Code", "Global Dimension 2 Code";
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
            column(EntryNo; EntryNo)
            {
            }
            column(CellGroupCode_MemberHouseGroups; "Member House Groups"."Cell Group Code")
            {
            }
            column(CellGroupName_MemberHouseGroups; "Member House Groups"."Cell Group Name")
            {
            }
            column(DateFormed_MemberHouseGroups; Format("Member House Groups"."Date Formed", 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(MeetingDate_MemberHouseGroups; Format("Member House Groups"."Meeting Date", 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(GroupLeader_MemberHouseGroups; "Member House Groups"."Group Leader")
            {
            }
            column(GroupLeaderName_MemberHouseGroups; "Member House Groups"."Group Leader Name")
            {
            }
            column(AssistantgroupLeader_MemberHouseGroups; "Member House Groups"."Assistant group Leader")
            {
            }
            column(AssistantGroupName_MemberHouseGroups; "Member House Groups"."Assistant Group Name")
            {
            }
            column(MeetingPlace_MemberHouseGroups; "Member House Groups"."Meeting Place")
            {
            }
            column(CreatedBy_MemberHouseGroups; "Member House Groups"."Created By")
            {
            }
            column(CreatedOn_MemberHouseGroups; Format("Member House Groups"."Created On", 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(NoSeries_MemberHouseGroups; "Member House Groups"."No. Series")
            {
            }
            column(GroupLeaderEmail_MemberHouseGroups; "Member House Groups"."Group Leader Email")
            {
            }
            column(AssistantGroupLeaderEmail_MemberHouseGroups; "Member House Groups"."Assistant Group Leader Email")
            {
            }
            column(GroupSatatus_MemberHouseGroups; "Member House Groups"."Group Satatus")
            {
            }
            column(GlobalDimension2Code_MemberHouseGroups; "Member House Groups"."Global Dimension 2 Code")
            {
            }
            column(GroupLeaderPhoneNo_MemberHouseGroups; "Member House Groups"."Group Leader Phone No")
            {
            }
            column(AssistantGroupLeaderPhoneN_MemberHouseGroups; "Member House Groups"."Assistant Group Leader Phone N")
            {
            }
            column(NoofMembers_MemberHouseGroups; "Member House Groups"."No of Members")
            {
            }
            column(CreditOfficer_MemberHouseGroups; "Member House Groups"."Credit Officer")
            {
            }
            column(FieldOfficer_MemberHouseGroups; "Member House Groups"."Field Officer")
            {
            }
            column(VarGroupDeposit; VarGroupDeposit)
            {
            }
            column(VarGroupLoans; VarGroupLoans)
            {
            }
            column(VarGroupArrears; VarGroupArrears)
            {
            }
            column(VarShareCapital; VarShareCapital)
            {
            }
            trigger OnAfterGetRecord();
            begin
                EntryNo := EntryNo + 1;
                VarGroupDeposit := 0;
                VarGroupLoans := 0;
                VarGroupArrears := 0;
                VarShareCapital := 0;
                //=================================================Get Group Deposits
                VarReportDateFilter := '..' + Format(VarReportDate);
                ObjCust.Reset;
                ObjCust.SetRange(ObjCust."Member House Group", "Cell Group Code");
                ObjCust.SetFilter(ObjCust."Date Filter", VarReportDateFilter);
                if ObjCust.FindSet then begin
                    repeat
                        ObjCust.CalcFields(ObjCust."Current Shares");
                        ObjCust.CalcFields(ObjCust."Shares Retained");
                        VarGroupDeposit := VarGroupDeposit + ObjCust."Current Shares";
                        VarShareCapital := VarShareCapital + ObjCust."Shares Retained";
                    until ObjCust.Next = 0;
                end;
                //================================================Get Group Loans and Arrears
                ObjPortfolioProvision.Reset;
                ObjPortfolioProvision.SetRange(ObjPortfolioProvision."Group Code", "Cell Group Code");
                ObjPortfolioProvision.SetFilter(ObjPortfolioProvision."Report Date", '%1', VarReportDate);
                if ObjPortfolioProvision.FindSet then begin
                    ObjPortfolioProvision.CalcSums(ObjPortfolioProvision."Outstanding Balance", ObjPortfolioProvision."Arrears Amount");
                    VarGroupLoans := ObjPortfolioProvision."Outstanding Balance";
                    VarGroupArrears := ObjPortfolioProvision."Arrears Amount";
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
                field("As At"; VarReportDate)
                {
                    ApplicationArea = Basic;
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
        Loans_RegisterCaptionLbl: label 'Approved Loans Report';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Loan_TypeCaptionLbl: label 'Loan Type';
        Client_No_CaptionLbl: label 'Client No.';
        Outstanding_LoanCaptionLbl: label 'Outstanding Loan';
        PeriodCaptionLbl: label 'Period';
        Approved_DateCaptionLbl: label 'Approved Date';
        Loan_TypeCaption_Control1102760043Lbl: label 'Loan Type';
        Verified_By__________________________________________________CaptionLbl: label 'Verified By..................';
        Confirmed_By__________________________________________________CaptionLbl: label 'Confirmed By..................';
        Sign________________________CaptionLbl: label 'Sign...............';
        Sign________________________Caption_Control1102755003Lbl: label 'Sign...............';
        Date________________________CaptionLbl: label 'Date..............';
        Date________________________Caption_Control1102755005Lbl: label 'Date..............';
        NameCreditOff: label 'Name.......................';
        NameCreditDate: label 'Date........................';
        NameCreditSign: label 'Signature..................';
        NameCreditMNG: label 'Name.......................';
        NameCreditMNGDate: label 'Date........................';
        NameCreditMNGSign: label 'Signature..................';
        NameCEO: label 'Name......................';
        NameCEOSign: label 'Signature.................';
        NameCEODate: label 'Date.......................';
        CreditCom1: label 'Name......................';
        CreditCom1Sign: label 'Signature.................';
        CreditCom1Date: label 'Date.......................';
        CreditCom2: label 'Name......................';
        CreditCom2Sign: label 'Signature.................';
        CreditCom2Date: label 'Date......................';
        CreditCom3: label 'Name.....................';
        CreditComDate3: label 'Date......................';
        CreditComSign3: label 'Signature.................';
        Comment: label '....................';
        Company: Record "Company Information";
        EntryNo: Integer;
        ObjCust: Record "Members Register";
        VarReportDate: Date;
        VarReportDateFilter: Text;
        VarGroupDeposit: Decimal;
        VarGroupLoans: Decimal;
        VarGroupArrears: Decimal;
        ObjPortfolioProvision: Record "Loan Portfolio Provision";
        VarShareCapital: Decimal;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516065_v6_3_0_2259;
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
