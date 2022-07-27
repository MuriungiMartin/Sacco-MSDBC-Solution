#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516467_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50467 "Generate Over Draft"
{
    RDLCLayout = './Layouts/GenerateOverDraft.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = sorting("No.") where("Creditor Type" = const("FOSA Account"), "Account Type" = filter('SAVINGS' | 'SAVINGSREL'), "Balance (LCY)" = filter(< 1.000), "Account Category" = filter(<> Branch), Status = filter(<> Dormant | Deceased), Blocked = const(" "), "Account Category" = filter(<> Branch));
            PrintOnlyIfDetail = false;
            RequestFilterHeading = 'Account';
            column(ReportForNavId_4645; 4645) { } // Autogenerated by ForNav - Do not delete
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
            trigger OnPreDataItem();
            begin
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                GenJournalLine.SetRange("Journal Batch Name", 'INTCALC');
                GenJournalLine.DeleteAll;
                if DocNo = '' then
                    Error('Please specify the Document No.');
                if PDate = 0D then
                    Error('Please specify the Posting Date.');
                if AccountType.Get('SAVINGS') then begin
                    Charges.Reset;
                    Charges.SetRange(Charges.Code, AccountType."Overdraft Charge");
                    if Charges.Find('-') then begin
                        Charges.TestField(Charges."Percentage of Amount");
                        Charges.TestField(Charges."GL Account");
                        ODAccount := Charges."GL Account";
                        ODRate := Charges."Percentage of Amount";
                    end;
                end;
            end;

            trigger OnAfterGetRecord();
            begin
                if Vendor."Balance (LCY)" < 0 then
                    ODAmount := Abs(Vendor."Balance (LCY)") + 1000
                else
                    ODAmount := 1000 - Abs(Vendor."Balance (LCY)");
                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'PURCHASES';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Journal Batch Name" := 'INTCALC';
                GenJournalLine."Document No." := DocNo;
                GenJournalLine."External Document No." := Vendor."No.";
                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No." := Vendor."No.";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := PDate;
                GenJournalLine.Description := 'Overdraft Charges';
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                GenJournalLine.Amount := ((ODRate / 100) * ODAmount);
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Bal. Account No." := ODAccount;
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;
            end;

            trigger OnPostDataItem();
            begin
                //Post New
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                GenJournalLine.SetRange("Journal Batch Name", 'INTCALC');
                if GenJournalLine.Find('-') then begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                end;
                //Post New
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
                field(Document_No; DocNo)
                {
                    ApplicationArea = Basic;
                    Caption = 'Document_No';
                }
                field(Posting_Date; PDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Posting_Date';
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
        Company: Record "Company Information";
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        Account: Record Vendor;
        AccountType: Record "Account Types-Saving Products";
        LineNo: Integer;
        ChequeType: Record "Cheque Types";
        FDInterestCalc: Record "FD Interest Calculation Crite";
        InterestBuffer: Record "Interest Buffer";
        IntRate: Decimal;
        DocNo: Code[10];
        PDate: Date;
        IntBufferNo: Integer;
        MidMonthFactor: Decimal;
        DaysInMonth: Integer;
        ODAccount: Code[20];
        ODRate: Decimal;
        Charges: Record Charges;
        ODAmount: Decimal;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516467_v6_3_0_2259;
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
