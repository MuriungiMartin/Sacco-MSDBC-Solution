#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516114_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50114 "Purchase Requisition Form"
{
    RDLCLayout = './Layouts/PurchaseRequisitionForm.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            column(ReportForNavId_1; 1) { } // Autogenerated by ForNav - Do not delete
            column(PRN_No; "Purchase Header"."No.")
            {
            }
            column(Department; "Purchase Header"."Shortcut Dimension 2 Code")
            {
            }
            column(Date; "Purchase Header"."Document Date")
            {
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(ReportForNavId_5; 5) { } // Autogenerated by ForNav - Do not delete
                column(ItemNo; "Purchase Line"."No.")
                {
                }
                column(Description; "Purchase Line".Description)
                {
                }
                column(UnitofMeasure; "Purchase Line"."Unit of Measure")
                {
                }
                column(Quantity; "Purchase Line".Quantity)
                {
                }
                column(EstimatedUnitCost; "Purchase Line"."Unit Cost")
                {
                }
                column(EstimatedTotalCost; "Purchase Line"."Amt. Rcd. Not Invoiced")
                {
                }
                column(ActualCost; "Purchase Line"."Direct Unit Cost")
                {
                }
                column(TenderQuotationRef; "Purchase Line"."No.")
                {
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

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516114_v6_3_0_2259;
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
