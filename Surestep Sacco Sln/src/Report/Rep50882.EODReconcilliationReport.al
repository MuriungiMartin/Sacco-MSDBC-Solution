#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516882_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50882 "EOD Reconcilliation Report"
{
    RDLCLayout = './Layouts/EODReconcilliationReport.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Treasury Transactions"; "Treasury Transactions")
        {
            RequestFilterFields = "To Account", "From Account", "Transaction Date";
            column(ReportForNavId_1102755000; 1102755000) { } // Autogenerated by ForNav - Do not delete
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
            column(No_TreasuryTransactions; "Treasury Transactions".No)
            {
            }
            column(TransactionDate; Format("Treasury Transactions"."Transaction Date"))
            {
            }
            column(TransactionType_TreasuryTransactions; "Treasury Transactions"."Transaction Type")
            {
            }
            column(ToAccountName_TreasuryTransactions; "Treasury Transactions"."To Account Name")
            {
            }
            column(ExcessAmount; "Treasury Transactions"."Excess Amount")
            {
            }
            column(ShortageAmount; "Treasury Transactions"."Shortage Amount")
            {
            }
            column(TreasuryCoinage; "Treasury Transactions"."Total Cash on Treasury Coinage")
            {
            }
            column(SourceAccountBalance; "Treasury Transactions"."Source Account Balance")
            {
            }
            column(TInterTeller; VarTInterTeller)
            {
            }
            column(TCashDeposit; VarTCashDeposit)
            {
            }
            column(TCashWithdrawals; VarTCashWithdrawal)
            {
            }
            column(CashTransWith; VarCashTransWith)
            {
            }
            column(TellerReceiptAmount; VarTellerReceiptAmount)
            {
            }
            column(TissuetoTeller; VarTissuetoTeller)
            {
            }
            column(TotalReceipts; VarTotalReceipts)
            {
            }
            column(TotalAmountReceived; VarTotalAmountReceived)
            {
            }
            column(TotalPayment; VarTotalPayment)
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
            column(TotalCashonTreasuryCoinage; "Treasury Transactions"."Total Cash on Treasury Coinage")
            {
            }
            column(TillTreasuryBalance_TreasuryTransactions; "Treasury Transactions"."Till/Treasury Balance")
            {
            }
            column(ExcessShortageAmount_TreasuryTransactions; "Treasury Transactions"."Excess/Shortage Amount")
            {
            }
            column(ExcessAmount_TreasuryTransactions; "Treasury Transactions"."Excess Amount")
            {
            }
            column(ShortageAmount_TreasuryTransactions; "Treasury Transactions"."Shortage Amount")
            {
            }
            dataitem("Treasury Coinage"; "Treasury Coinage")
            {
                DataItemLink = No = field(No);
                DataItemTableView = sorting(Value) order(descending);
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
            trigger OnPreDataItem();
            begin
                Company.Get();
                Company.CalcFields(Company.Picture);
            end;

            trigger OnAfterGetRecord();
            begin
                VarissuetoTeller := 0;
                VarissuetoTeller := 0;
                ObjTreasuryTrans.Reset;
                ObjTreasuryTrans.SetRange(ObjTreasuryTrans."From Account", "From Account");
                ObjTreasuryTrans.SetRange(ObjTreasuryTrans."Date Posted", "Treasury Transactions"."Transaction Date");
                ObjTreasuryTrans.SetRange(ObjTreasuryTrans."Transaction Type", ObjTreasuryTrans."transaction type"::"Inter Teller Transfers");
                if ObjTreasuryTrans.Find('-') then begin
                    ObjTreasuryTrans.CalcSums(ObjTreasuryTrans.Amount);
                    TVarTInterTeller := ObjTreasuryTrans.Amount;
                end;
                ObjTreasuryTrans.Reset;
                ObjTreasuryTrans.SetRange(ObjTreasuryTrans."From Account", "To Account");
                ObjTreasuryTrans.SetRange(ObjTreasuryTrans."Date Posted", "Treasury Transactions"."Transaction Date");
                ObjTreasuryTrans.SetRange(ObjTreasuryTrans."Transaction Type", ObjTreasuryTrans."transaction type"::"Issue To Teller");
                if ObjTreasuryTrans.Find('-') then begin
                    ObjTreasuryTrans.CalcSums(ObjTreasuryTrans.Amount);
                    VarTInterTeller := ObjTreasuryTrans.Amount;
                end;
                VarTCashDeposit := 0;
                ObjCashDep.Reset;
                ObjCashDep.SetRange(ObjCashDep."Bank Account", "From Teller");
                ObjCashDep.SetRange(ObjCashDep."Date Posted", "Transaction Date");
                ObjCashDep.SetRange(ObjCashDep."Type _Transactions", ObjCashDep."type _transactions"::"Cash Deposit");
                if ObjCashDep.Find('-') then begin
                    ObjCashDep.CalcSums(ObjCashDep.Amount);
                    VarTCashDeposit := ObjCashDep.Amount;
                end;
                VarCashTransWith := 0;
                ObjCashWith.Reset;
                ObjCashWith.SetRange(ObjCashWith."Bank Account", "From Account");
                ObjCashWith.SetRange(ObjCashWith."Date Posted", "Transaction Date");
                ObjCashWith.SetRange(ObjCashWith."Type _Transactions", ObjCashWith."type _transactions"::Withdrawal);
                if ObjCashWith.FindSet then begin
                    ObjCashWith.CalcSums(ObjCashWith.Amount);
                    VarCashTransWith := ObjCashWith.Amount;
                end;
                VarTellerReceiptAmount := 0;
                ObjTellerReceipts.Reset;
                ObjTellerReceipts.SetRange(ObjTellerReceipts."Bank Account", "From Account");
                ObjTellerReceipts.SetRange(ObjTellerReceipts."Date Posted", "Transaction Date");
                ObjTellerReceipts.SetRange(ObjTellerReceipts."Type _Transactions", ObjTellerReceipts."type _transactions"::"Batch Deposit");
                if ObjTellerReceipts.FindSet then begin
                    ObjTellerReceipts.CalcSums(ObjTellerReceipts.Amount);
                    VarTellerReceiptAmount := ObjTellerReceipts.Amount;
                end;
                VarFReceiptAm := 0;
                ObjReceipts.Reset;
                ObjReceipts.SetRange(ObjReceipts."Posted By", "Posted By");
                ObjReceipts.SetRange(ObjReceipts."Date Posted", "Date Posted");
                if ObjReceipts.Find('-') then begin
                    ObjReceipts.CalcSums(ObjReceipts."Amount Received");
                    VarTBReceiptAm := ObjReceipts."Amount Received";
                end;
                VarBReceiptAm := 0;
                ObjBosaReceipts.Reset;
                ObjBosaReceipts.SetRange(ObjBosaReceipts."Employer No.", "From Account");
                ObjBosaReceipts.SetRange(ObjBosaReceipts."Transaction Date", "Treasury Transactions"."Transaction Date");
                if ObjBosaReceipts.Find('-') then begin
                    ObjBosaReceipts.CalcSums(ObjBosaReceipts.Amount);
                    VarTBReceiptAm := ObjBosaReceipts.Amount;
                end;
                VarTotalReceipts := VarTBReceiptAm;
                VarTotalAmountReceived := VarTotalReceipts + VarTCashDeposit + VarTInterTeller + VarTellerReceiptAmount;
                VarTotalPayment := VarTCashWithdrawal
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
        ObjTreasuryTrans: Record "Treasury Transactions";
        VarTInterTeller: Decimal;
        ObjCashDep: Record Transactions;
        VarTCashDeposit: Decimal;
        VarTCashWithdrawal: Decimal;
        VarTissuetoTeller: Decimal;
        VarissuetoTeller: Decimal;
        VarInterTeller: Decimal;
        VarCashDeposit: Decimal;
        VarCashWithdrawal: Decimal;
        ObjReceipts: Record "Receipt Header";
        ObjBosaReceipts: Record "Receipts & Payments";
        VarFReceiptAm: Decimal;
        VarTFReceiptAm: Decimal;
        VarBReceiptAm: Decimal;
        VarTBReceiptAm: Decimal;
        VarTotalReceipts: Decimal;
        VarTotalAmountReceived: Decimal;
        VarTotalPayment: Decimal;
        Company: Record "Company Information";
        ObjCashWith: Record Transactions;
        VarCashTransWith: Decimal;
        ObjTellerReceipts: Record Transactions;
        VarTellerReceiptAmount: Decimal;
        TVarTInterTeller: Decimal;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516882_v6_3_0_2259;
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
