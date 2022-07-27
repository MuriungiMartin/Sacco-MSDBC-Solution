#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516506_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50506 "Transactions HighRisk Accounts"
{
    RDLCLayout = './Layouts/TransactionsHighRiskAccounts.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Members Register"; "Members Register")
        {
            DataItemTableView = where("Member Risk Level" = const("High Risk"));
            column(ReportForNavId_1; 1) { } // Autogenerated by ForNav - Do not delete
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_City; Company.City)
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(Company_Email; Company."E-Mail")
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
            column(SN; SN)
            {
            }
            column(MemberRiskLevel_MembersRegister; "Members Register"."Member Risk Level")
            {
            }
            column(Name_MembersRegister; "Members Register".Name)
            {
            }
            column(No_MembersRegister; "Members Register"."No.")
            {
            }
            column(CreatedBy_MembersRegister; "Members Register"."Created By")
            {
            }
            dataitem(Transactions; Transactions)
            {
                DataItemLink = "Member No" = field("No.");
                DataItemTableView = where(Posted = const(true));
                column(ReportForNavId_30; 30) { } // Autogenerated by ForNav - Do not delete
                column(TransactionDeclaration_Transactions; Transactions."Transaction Declaration")
                {
                }
                column(EvidenceObtained_Transactions; Transactions."Evidence Obtained")
                {
                }
                column(TransactionType_Transactions; Transactions."Transaction Type")
                {
                }
                column(MemberNo_Transactions; Transactions."Member No")
                {
                }
                column(CheckedBy_Transactions; Transactions."Checked By")
                {
                }
                column(TransactionDate_Transactions; Transactions."Transaction Date")
                {
                }
                column(Amount_Transactions; Transactions.Amount)
                {
                }
                column(PostedBy_Transactions; Transactions."Posted By")
                {
                }
                column(SN2; SN)
                {
                }
                trigger OnPreDataItem();
                begin
                    Company.Get();
                    Company.CalcFields(Picture);
                end;

                trigger OnAfterGetRecord();
                begin
                    SN := SN + 1;
                end;

            }
            trigger OnPreDataItem();
            begin
                Company.Get();
                Company.CalcFields(Picture);
            end;

            trigger OnAfterGetRecord();
            begin
                SN := SN + 1;
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
        ReportForNav: DotNet ForNavReport51516506_v6_3_0_2259;
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
