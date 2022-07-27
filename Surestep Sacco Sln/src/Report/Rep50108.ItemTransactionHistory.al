#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516108_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50108 "Item Transaction History"
{
    RDLCLayout = './Layouts/ItemTransactionHistory.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            column(ReportForNavId_1; 1) { } // Autogenerated by ForNav - Do not delete
            column(Posting_Date; "Item Ledger Entry"."Posting Date")
            {
            }
            column(Entry_Type; "Item Ledger Entry"."Entry Type")
            {
            }
            column(Quantity; "Item Ledger Entry".Quantity)
            {
            }
            column(UOM; "Item Ledger Entry"."Unit of Measure Code")
            {
            }
            column(Rate; UnitCost)
            {
            }
            column(MR_No; "Item Ledger Entry"."Document No.")
            {
            }
            column(Company_Name; CompName)
            {
            }
            column(Item_No; "Item Ledger Entry"."Item No.")
            {
            }
            column(Department; "Item Ledger Entry"."Global Dimension 1 Code")
            {
            }
            column(Item_Desc; "Item Ledger Entry".Description)
            {
            }
            column(Cost_Center; "Item Ledger Entry"."Global Dimension 2 Code")
            {
            }
            column(Ent_Type; "Item Ledger Entry"."Entry Type Two")
            {
            }
            column(Item_Name; ItemName)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(Branch; Branch)
            {
            }
            column(CostCenter; CostCenter)
            {
            }
            column(VendName; VendName)
            {
            }
            column(Amount; Amount)
            {
            }
            trigger OnPreDataItem();
            begin
                if CompInfo.Get then
                    CompName := CompInfo.Name;
                //if Vend.get("Purchase Line"."Buy-from Vendor No.") then
                //VendName:=Vend.Name;
                if EndDate = 0D then
                    EndDate := WorkDate;
            end;

            trigger OnAfterGetRecord();
            begin
                DimValue.Reset;
                DimValue.SetRange(DimValue.Code, "Item Ledger Entry"."Global Dimension 1 Code");
                if DimValue.Find('-') then
                    Branch := DimValue.Name;
                DimValue.Reset;
                DimValue.SetRange(DimValue.Code, "Item Ledger Entry"."Global Dimension 2 Code");
                if DimValue.Find('-') then
                    CostCenter := DimValue.Name;
                if "Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."entry type"::Purchase then
                    "Item Ledger Entry"."Document No." := '';
                if "Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."entry type"::Purchase then
                    "Item Ledger Entry"."Entry Type Two" := 'RECEIPTS';
                "Item Ledger Entry".Modify;
                if "Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."entry type"::"Negative Adjmt." then
                    "Item Ledger Entry"."Entry Type Two" := 'ISSUES';
                "Item Ledger Entry".Modify;
                Vend.Reset;
                Vend.SetRange(Vend."No.", "Item Ledger Entry"."Source No.");
                if Vend.Find('-') then
                    VendName := Vend.Name;
                if "Item Ledger Entry"."Entry Type Two" = 'ISSUES' then VendName := '';
                Reset;
                SetRange("Item Ledger Entry"."Posting Date", StartDate, EndDate);
                if ItemNum <> '' then
                    SetRange("Item Ledger Entry"."Item No.", ItemNum);
                Amount := 0;
                Items.Reset;
                Items.SetRange(Items."No.", "Item Ledger Entry"."Item No.");
                if Items.Find('-') then
                    UnitCost := Items."Unit Cost";
                if "Item Ledger Entry"."Entry Type Two" = 'ISSUES' then
                    Amount := (-1 * "Item Ledger Entry".Quantity) * UnitCost else
                    Amount := "Item Ledger Entry".Quantity * UnitCost;
                if Items.Get("Item Ledger Entry"."Item No.") then
                    ItemName := Items.Description;
                //"Item Ledger Entry"."Posting Date":=CALCDATE(0D,"Item Ledger Entry"."Posting Date");
                //"Item Ledger Entry".MODIFY;
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
                field(StartDate; StartDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Starting From';
                }
                field(EndDate; EndDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Ending On';
                }
                field(ItemNum; ItemNum)
                {
                    ApplicationArea = Basic;
                    Caption = 'Item No';
                    TableRelation = Item."No.";
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
        if StartDate = 0D then Error('You must enter start date!');
        ;
        ReportsForNavPre;
    end;

    var
        Location: Code[20];
        Product: Code[20];
        StartDate: Date;
        EndDate: Date;
        ProdGroup: Code[20];
        Value: Decimal;
        PostDate: Date;
        DimValue: Record "Dimension Value";
        CostCenter: Text[100];
        Branch: Text[100];
        CompInfo: Record "Company Information";
        CompName: Text[100];
        Vend: Record Vendor;
        VendName: Text[100];
        Items: Record Item;
        UnitCost: Decimal;
        ItemName: Text[50];
        ItemNum: Code[20];
        Amount: Decimal;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516108_v6_3_0_2259;
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
