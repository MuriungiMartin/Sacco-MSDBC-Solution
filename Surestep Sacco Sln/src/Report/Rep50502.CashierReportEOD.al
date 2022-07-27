#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516502_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50502 "Cashier Report EOD"
{
    RDLCLayout = './Layouts/CashierReportEOD.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Treasury Transactions"; "Treasury Transactions")
        {
            column(ReportForNavId_1102755000; 1102755000) { } // Autogenerated by ForNav - Do not delete
            column(No_TreasuryTransactions; "Treasury Transactions".No)
            {
            }
            column(TransactionDate_TreasuryTransactions; Format("Treasury Transactions"."Transaction Date"))
            {
            }
            column(TransactionType_TreasuryTransactions; "Treasury Transactions"."Transaction Type")
            {
            }
            column(ToAccountName_TreasuryTransactions; "Treasury Transactions"."To Account Name")
            {
            }
            column(TInterTeller; TInterTeller)
            {
            }
            column(TCashDeposit; TCashDeposit)
            {
            }
            column(TCashWithdrawals; TCashWithdrawal)
            {
            }
            column(TissuetoTeller; TissuetoTeller)
            {
            }
            column(TotalReceipts; TotalReceipts)
            {
            }
            column(TotalAmountReceived; TotalAmountReceived)
            {
            }
            column(TotalPayment; TotalPayment)
            {
            }
            column(ActualCashAtHand_TreasuryTransactions; "Treasury Transactions"."Actual Cash At Hand")
            {
            }
            column(FromAccountName_TreasuryTransactions; "Treasury Transactions"."From Account Name")
            {
            }
            column(FromAccount_TreasuryTransactions; "Treasury Transactions"."From Account")
            {
            }
            column(ToAccount_TreasuryTransactions; "Treasury Transactions"."To Account")
            {
            }
            column(Description_TreasuryTransactions; "Treasury Transactions".Description)
            {
            }
            column(Amount_TreasuryTransactions; "Treasury Transactions".Amount)
            {
            }
            column(Posted_TreasuryTransactions; "Treasury Transactions".Posted)
            {
            }
            column(DatePosted_TreasuryTransactions; "Treasury Transactions"."Date Posted")
            {
            }
            column(TimePosted_TreasuryTransactions; "Treasury Transactions"."Time Posted")
            {
            }
            column(PostedBy_TreasuryTransactions; "Treasury Transactions"."Posted By")
            {
            }
            column(NoSeries_TreasuryTransactions; "Treasury Transactions"."No. Series")
            {
            }
            column(TransactionTime_TreasuryTransactions; "Treasury Transactions"."Transaction Time")
            {
            }
            column(CoinageAmount_TreasuryTransactions; "Treasury Transactions"."Coinage Amount")
            {
            }
            column(CurrencyCode_TreasuryTransactions; "Treasury Transactions"."Currency Code")
            {
            }
            column(Issued_TreasuryTransactions; "Treasury Transactions".Issued)
            {
            }
            column(DateIssued_TreasuryTransactions; "Treasury Transactions"."Date Issued")
            {
            }
            column(TimeIssued_TreasuryTransactions; "Treasury Transactions"."Time Issued")
            {
            }
            column(IssueReceived_TreasuryTransactions; "Treasury Transactions"."Issue Received")
            {
            }
            column(DateReceived_TreasuryTransactions; "Treasury Transactions"."Date Received")
            {
            }
            column(TimeReceived_TreasuryTransactions; "Treasury Transactions"."Time Received")
            {
            }
            column(IssuedBy_TreasuryTransactions; "Treasury Transactions"."Issued By")
            {
            }
            column(ReceivedBy_TreasuryTransactions; "Treasury Transactions"."Received By")
            {
            }
            column(Received_TreasuryTransactions; "Treasury Transactions".Received)
            {
            }
            column(RequestNo_TreasuryTransactions; "Treasury Transactions"."Request No")
            {
            }
            column(BankNo_TreasuryTransactions; "Treasury Transactions"."Bank No")
            {
            }
            column(DenominationTotal_TreasuryTransactions; "Treasury Transactions"."Denomination Total")
            {
            }
            column(ExternalDocumentNo_TreasuryTransactions; "Treasury Transactions"."External Document No.")
            {
            }
            column(ChequeNo_TreasuryTransactions; "Treasury Transactions"."Cheque No.")
            {
            }
            column(TransactingBranch_TreasuryTransactions; "Treasury Transactions"."Transacting Branch")
            {
            }
            column(Approved_TreasuryTransactions; "Treasury Transactions".Approved)
            {
            }
            column(EndofDayTransTime_TreasuryTransactions; "Treasury Transactions"."End of Day Trans Time")
            {
            }
            column(EndofDay_TreasuryTransactions; "Treasury Transactions"."End of Day")
            {
            }
            column(LastTransaction_TreasuryTransactions; "Treasury Transactions"."Last Transaction")
            {
            }
            column(TotalCashonTreasuryCoinage_TreasuryTransactions; "Treasury Transactions"."Total Cash on Treasury Coinage")
            {
            }
            column(TillTreasuryBalance_TreasuryTransactions; "Treasury Transactions"."Till/Treasury Balance")
            {
            }
            column(ExcessShortageAmount_TreasuryTransactions; "Treasury Transactions"."Excess/Shortage Amount")
            {
            }
            dataitem("Treasury Coinage"; "Treasury Coinage")
            {
                DataItemLink = No = field(No);
                column(ReportForNavId_1102755001; 1102755001) { } // Autogenerated by ForNav - Do not delete
                column(No_TreasuryCoinage; "Treasury Coinage".No)
                {
                }
                column(Code_TreasuryCoinage; "Treasury Coinage".Code)
                {
                }
                column(Description_TreasuryCoinage; "Treasury Coinage".Description)
                {
                }
                column(Type_TreasuryCoinage; "Treasury Coinage".Type)
                {
                }
                column(Value_TreasuryCoinage; "Treasury Coinage".Value)
                {
                }
                column(Quantity_TreasuryCoinage; "Treasury Coinage".Quantity)
                {
                }
                column(TotalAmount_TreasuryCoinage; "Treasury Coinage"."Total Amount")
                {
                }
            }
            trigger OnAfterGetRecord();
            begin
                //TInterTeller:=0;
                issuetoTeller := 0;
                InterTeller := 0;
                TreasuryTrans.Reset;
                //TreasuryTrans.SETRANGE(TreasuryTrans.No,"Treasury Transactions".No);
                TreasuryTrans.SetRange(TreasuryTrans."From Account", "From Account");
                TreasuryTrans.SetRange(TreasuryTrans."Date Posted", "Treasury Transactions"."Date Posted");
                TreasuryTrans.SetRange(TreasuryTrans."Transaction Type", TreasuryTrans."transaction type"::"Inter Teller Transfers");
                if TreasuryTrans.Find('-') then begin
                    repeat
                        InterTeller := TreasuryTrans.Amount;
                        TInterTeller := TInterTeller + InterTeller;
                    until TreasuryTrans.Next = 0;
                end;
                TreasuryTrans.Reset;
                //TreasuryTrans.SETRANGE(TreasuryTrans."Posted By","Posted By");
                TreasuryTrans.SetRange(TreasuryTrans."From Account", "To Account");
                TreasuryTrans.SetRange(TreasuryTrans."Date Posted", "Treasury Transactions"."Date Posted");
                TreasuryTrans.SetRange(TreasuryTrans."Transaction Type", TreasuryTrans."transaction type"::"Issue To Teller");
                if TreasuryTrans.Find('-') then begin
                    repeat
                        issuetoTeller := TreasuryTrans.Amount;
                        TissuetoTeller := TissuetoTeller + issuetoTeller;
                    until TreasuryTrans.Next = 0;
                end;
                CashDeposit := 0;
                CashDep.Reset;
                CashDep.SetRange(CashDep.Cashier, "Treasury Transactions"."Issued By");
                CashDep.SetRange(CashDep."Date Posted", "Treasury Transactions"."Date Posted");
                CashDep.SetRange(CashDep.Type, 'Cash Deposit');
                if CashDep.Find('-') then begin
                    repeat
                        CashDeposit := CashDep.Amount;
                        TCashDeposit := TCashDeposit + CashDeposit;
                    until CashDep.Next = 0;
                end;
                CashWithdrawal := 0;
                CashDep.Reset;
                CashDep.SetRange(CashDep.Cashier, "Treasury Transactions"."Issued By");
                CashDep.SetRange(CashDep."Date Posted", "Treasury Transactions"."Date Posted");
                CashDep.SetRange(CashDep.Type, 'Withdrawal');
                if CashDep.Find('-') then begin
                    repeat
                        CashWithdrawal := CashDep.Amount;
                        TCashWithdrawal := TCashWithdrawal + CashWithdrawal;
                    until CashDep.Next = 0;
                end;
                FReceiptAm := 0;
                Receipts.Reset;
                Receipts.SetRange(Receipts."Posted By", "Posted By");
                Receipts.SetRange(Receipts."Date Posted", "Date Posted");
                if Receipts.Find('-') then begin
                    repeat
                        FReceiptAm := Receipts."Amount Received";
                        TFReceiptAm := TFReceiptAm + FReceiptAm;
                    until Receipts.Next = 0;
                end;
                BReceiptAm := 0;
                BosaReceipts.Reset;
                BosaReceipts.SetRange(BosaReceipts."Employer No.", "From Account");
                BosaReceipts.SetRange(BosaReceipts."Transaction Date", "Date Posted");
                if BosaReceipts.Find('-') then begin
                    repeat
                        BReceiptAm := BosaReceipts.Amount;
                        TBReceiptAm := TBReceiptAm + BReceiptAm;
                    until BosaReceipts.Next = 0;
                end;
                TotalReceipts := TFReceiptAm + TBReceiptAm;
                //MESSAGE('TotalReceipts is %1',TotalReceipts);
                TotalAmountReceived := TotalReceipts + TCashDeposit + TissuetoTeller;
                TotalPayment := TCashWithdrawal
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
        TreasuryTrans: Record "Treasury Transactions";
        TInterTeller: Decimal;
        CashDep: Record Transactions;
        TCashDeposit: Decimal;
        TCashWithdrawal: Decimal;
        TissuetoTeller: Decimal;
        issuetoTeller: Decimal;
        InterTeller: Decimal;
        CashDeposit: Decimal;
        CashWithdrawal: Decimal;
        Receipts: Record "Receipt Header";
        BosaReceipts: Record "Receipts & Payments";
        FReceiptAm: Decimal;
        TFReceiptAm: Decimal;
        BReceiptAm: Decimal;
        TBReceiptAm: Decimal;
        TotalReceipts: Decimal;
        TotalAmountReceived: Decimal;
        TotalPayment: Decimal;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516502_v6_3_0_2259;
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
