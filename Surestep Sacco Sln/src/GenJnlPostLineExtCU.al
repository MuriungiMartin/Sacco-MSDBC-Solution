// Codeunit 50165 GenjnlPostLineExtCU
// {
//     trigger OnRun()
//     begin

//     end;

//      var
//         NeedsRoundingErr: label '%1 needs to be rounded';
//         PurchaseAlreadyExistsErr: label 'Purchase %1 %2 already exists for this vendor.', Comment='%1 = Document Type; %2 = Document No.';
//         BankPaymentTypeMustNotBeFilledErr: label 'Bank Payment Type must not be filled if Currency Code is different in Gen. Journal Line and Bank Account.';
//         DocNoMustBeEnteredErr: label 'Document No. must be entered when Bank Payment Type is %1.';
//         CheckAlreadyExistsErr: label 'Check %1 already exists for this Bank Account.';
//         GLSetup: Record "General Ledger Setup";
//         GlobalGLEntry: Record "G/L Entry";
//         TempGLEntryBuf: Record "G/L Entry" temporary;
//         TempGLEntryVAT: Record "G/L Entry" temporary;
//         GLReg: Record "G/L Register";
//         AddCurrency: Record Currency;
//         CurrExchRate: Record "Currency Exchange Rate";
//         VATEntry: Record "VAT Entry";
//         TaxDetail: Record "Tax Detail";
//         UnrealizedCustLedgEntry: Record "Cust. Ledger Entry";
//         UnrealizedVendLedgEntry: Record "Vendor Ledger Entry";
//         GLEntryVATEntryLink: Record "G/L Entry - VAT Entry Link";
//         TempVATEntry: Record "VAT Entry" temporary;
//         GenJnlCheckLine: Codeunit "Gen. Jnl.-Check Line";
//         PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
//         DeferralUtilities: Codeunit "Deferral Utilities";
//         DeferralDocType: Option Purchase,Sales,"G/L";
//         LastDocType: Option " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder;
//         AddCurrencyCode: Code[10];
//         GLSourceCode: Code[10];
//         LastDocNo: Code[20];
//         FiscalYearStartDate: Date;
//         CurrencyDate: Date;
//         LastDate: Date;
//         BalanceCheckAmount: Decimal;
//         BalanceCheckAmount2: Decimal;
//         BalanceCheckAddCurrAmount: Decimal;
//         BalanceCheckAddCurrAmount2: Decimal;
//         CurrentBalance: Decimal;
//         TotalAddCurrAmount: Decimal;
//         TotalAmount: Decimal;
//         UnrealizedRemainingAmountCust: Decimal;
//         UnrealizedRemainingAmountVend: Decimal;
//         AmountRoundingPrecision: Decimal;
//         AddCurrGLEntryVATAmt: Decimal;
//         CurrencyFactor: Decimal;
//         FirstEntryNo: Integer;
//         NextEntryNo: Integer;
//         NextVATEntryNo: Integer;
//         FirstNewVATEntryNo: Integer;
//         FirstTransactionNo: Integer;
//         NextTransactionNo: Integer;
//         NextConnectionNo: Integer;
//         NextCheckEntryNo: Integer;
//         InsertedTempGLEntryVAT: Integer;
//         GLEntryNo: Integer;
//         UseCurrFactorOnly: Boolean;
//         ATMTrans: Record "ATM Transactions";
//         SMSMessages: Record "SMS Messages";
//         SMSMessage: Record "SMS Messages";
//         GenJournalLine: Record "Gen. Journal Line";
//         Cust1: Record "Members Register";
//         CurrentJnlBatchName: Code[10];
//         NonAddCurrCodeOccured: Boolean;
//         FADimAlreadyChecked: Boolean;
//         ResidualRoundingErr: label 'Residual caused by rounding of %1';
//         DimensionUsedErr: label 'A dimension used in %1 %2, %3, %4 has caused an error. %5.', Comment='Comment';
//         OverrideDimErr: Boolean;
//         JobLine: Boolean;
//         CheckUnrealizedCust: Boolean;
//         CheckUnrealizedVend: Boolean;
//         GLSetupRead: Boolean;
//         InvalidPostingDateErr: label '%1 is not within the range of posting dates for your company.', Comment='%1=The date passed in for the posting date.';
//         DescriptionMustNotBeBlankErr: label 'When %1 is selected for %2, %3 must have a value.', Comment='%1: Field Omit Default Descr. in Jnl., %2 G/L Account No, %3 Description';
//         NoDeferralScheduleErr: label 'You must create a deferral schedule if a deferral template is selected. Line: %1, Deferral Template: %2.', Comment='%1=The line number of the general ledger transaction, %2=The Deferral Template Code';
//         ZeroDeferralAmtErr: label 'Deferral amounts cannot be 0. Line: %1, Deferral Template: %2.', Comment='%1=The line number of the general ledger transaction, %2=The Deferral Template Code';
//         IsGLRegInserted: Boolean;
//         cust: Record "Members Register";
//         TransferCustomFields: Codeunit "Transfer Custom Fields";
//         UnrealizedRemainingAmountInvestor: Decimal;
//         CheckUnrealizedMemb: Boolean;
//         UnrealizedMembLedgEntry: Record "Member Ledger Entry";
//         UnrealizedRemainingAmountMemb: Decimal;
//         Found: Boolean;
//         LoanTypes: Record "Loan Products Setup";
//         LoanApp: Record "Loans Register";
//         PCharges: Record "Loan Product Charges";
//         GenJnlLine: Record "Gen. Journal Line";
//         ComputerName: Codeunit "SURESTEP Factory";


//         local procedure PostMemb(var GenJnlLine: Record "Gen. Journal Line";Balancing: Boolean)
//     var
//         LineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist.";
//         Memb: Record "Members Register";
//         MembPostingGr: Record "Customer Posting Group";
//         MembLedgEntry: Record "Member Ledger Entry";
//         CVLedgEntryBuf: Record "CV Ledger Entry Buffer";
//         TempDtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer" temporary;
//         DtldMembLedgEntry: Record "Detailed Cust. Ledg. Entry";
//         ReceivablesAccount: Code[20];
//         DtldLedgEntryInserted: Boolean;
//     begin
//         with GenJnlLine do begin
//          Memb.Get("Account No.");
//          Memb.CheckBlockedMembOnJnls(Memb,"Document Type",true);

//           if "Posting Group" = '' then begin
//            Memb.TestField("Customer Posting Group");
//             "Posting Group" :=Memb."Customer Posting Group";
//           end;
//          MembPostingGr.Get("Posting Group");


//          Found:=false;

//          if GenJnlLine."Transaction Type"=GenJnlLine."transaction type"::" " then begin
//           Message('A Transaction Line is missing Transaction Type Value');
//           Found:=true;
//           MembPostingGr.TestField("Receivables Account");
//           end;


//           if (GenJnlLine."Transaction Type"=GenJnlLine."transaction type"::"Registration Fee") then
//           begin
//           MembPostingGr.TestField(MembPostingGr."Registration Fees Account");
//           MembPostingGr."Receivables Account":=MembPostingGr."Registration Fees Account";
//           Found:=true;

//           end;

//           if (GenJnlLine."Transaction Type"=GenJnlLine."transaction type"::"Deposit Contribution") then
//           begin
//           MembPostingGr.TestField(MembPostingGr."Shares Deposits Account");
//           MembPostingGr."Receivables Account":=MembPostingGr."Shares Deposits Account";
//           Found:=true;

//           end;

//           if (GenJnlLine."Transaction Type"=GenJnlLine."transaction type"::"Share Capital") then
//           begin
//           MembPostingGr.TestField(MembPostingGr."Shares Capital Account");
//           MembPostingGr."Receivables Account":=MembPostingGr."Shares Capital Account";
//           Found:=true;

//           end;


//           if (GenJnlLine."Transaction Type"=GenJnlLine."transaction type"::Dividend) then
//           begin
//           MembPostingGr.TestField(MembPostingGr."Dividend Account");
//           MembPostingGr."Receivables Account":=MembPostingGr."Dividend Account";
//           Found:=true;
//           end;

//           if (GenJnlLine."Transaction Type"=GenJnlLine."transaction type"::"Recovery Account") then
//           begin
//           MembPostingGr.TestField(MembPostingGr."Recovery Account");
//           MembPostingGr."Receivables Account":=MembPostingGr."Recovery Account";
//           Found:=true;
//           end;

//           if (GenJnlLine."Transaction Type"=GenJnlLine."transaction type"::"FOSA Shares") then
//           begin
//           MembPostingGr.TestField(MembPostingGr."FOSA Shares");
//           MembPostingGr."Receivables Account":=MembPostingGr."FOSA Shares";
//           Found:=true;
//           end;

//           if (GenJnlLine."Transaction Type"=GenJnlLine."transaction type"::"Additional Shares") then
//           begin
//           MembPostingGr.TestField(MembPostingGr."Additional Shares");
//           MembPostingGr."Receivables Account":=MembPostingGr."Additional Shares";
//           Found:=true;
//           end;

//           if (GenJnlLine."Transaction Type"=GenJnlLine."transaction type"::"Unallocated Funds") then
//           begin
//           MembPostingGr.TestField(MembPostingGr."Un-allocated Funds Account");
//           MembPostingGr."Receivables Account":=MembPostingGr."Un-allocated Funds Account";
//           Found:=true;
//           end;

//           if (GenJnlLine."Transaction Type"=GenJnlLine."transaction type"::"Insurance Contribution") then
//           begin
//           MembPostingGr.TestField(MembPostingGr."Insurance Fund Account");
//           MembPostingGr."Receivables Account":=MembPostingGr."Insurance Fund Account";
//           Found:=true;
//           end;

//           if (GenJnlLine."Transaction Type"=GenJnlLine."transaction type"::"Benevolent Fund") then
//           begin
//           MembPostingGr.TestField(MembPostingGr."Benevolent Fund Account");
//           MembPostingGr."Receivables Account":=MembPostingGr."Benevolent Fund Account";
//           Found:=true;
//           end;

//           if (GenJnlLine."Transaction Type"=GenJnlLine."transaction type"::"Junior Savings") then
//           begin
//           MembPostingGr.TestField(MembPostingGr."Junior Savings Account");
//           MembPostingGr."Receivables Account":=MembPostingGr."Junior Savings Account";
//           Found:=true;
//           end;

//           if (GenJnlLine."Transaction Type"=GenJnlLine."transaction type"::"Safari Savings") then
//           begin
//           MembPostingGr.TestField(MembPostingGr."Safari Savings Account");
//           MembPostingGr."Receivables Account":=MembPostingGr."Safari Savings Account";
//           Found:=true;
//           end;

//           if (GenJnlLine."Transaction Type"=GenJnlLine."transaction type"::"Silver Savings") then
//           begin
//             MembPostingGr.TestField(MembPostingGr."Silver Savings Account");
//             MembPostingGr."Receivables Account":=MembPostingGr."Silver Savings Account";
//             Found:=true;
//           end;

//           if (GenJnlLine."Transaction Type"=GenJnlLine."transaction type"::"Loan Repayment") then
//           begin
//           if GenJnlLine."Loan No" = '' then
//           Error('Loan No must be specified for Loan, Repayment or Interest transactions');

//           LoanApp.Reset;
//           LoanApp.SetCurrentkey(LoanApp."Loan  No.");
//           LoanApp.SetRange(LoanApp."Loan  No.",GenJnlLine."Loan No");
//           if LoanApp.Find('-') then begin
//           if LoanTypes.Get(LoanApp."Loan Product Type") then begin
//           LoanTypes.TestField(LoanTypes."Loan Account");
//           MembPostingGr."Receivables Account":=LoanTypes."Loan Account";
//           Found:=true;
//           end;
//           end;
//           end;


//           if (GenJnlLine."Transaction Type"=GenJnlLine."transaction type"::"Interest Due") then
//           begin
//           if GenJnlLine."Loan No" = '' then
//           Error('Loan No must be specified for Loan, Repayment,Loan Insurance or Interest transactions :- %1',GenJnlLine."Account No.");

//           LoanApp.Reset;
//           LoanApp.SetCurrentkey(LoanApp."Loan  No.");
//           LoanApp.SetRange(LoanApp."Loan  No.",GenJnlLine."Loan No");
//           if LoanApp.Find('-') then begin
//           if LoanTypes.Get(LoanApp."Loan Product Type") then begin
//           LoanTypes.TestField(LoanTypes."Loan Interest Account");
//           MembPostingGr."Receivables Account":=LoanTypes."Receivable Interest Account";
//           Found:=true;
//           end;
//           end;
//           end;

//           if (GenJnlLine."Transaction Type"=GenJnlLine."transaction type"::"Interest Paid") then
//           begin
//           if GenJnlLine."Loan No" = '' then
//           Error('Loan No must be specified for Loan, Repayment or Interest transactions :- %1',GenJnlLine."Account No.");

//           LoanApp.Reset;
//           LoanApp.SetCurrentkey(LoanApp."Loan  No.");
//           LoanApp.SetRange(LoanApp."Loan  No.",GenJnlLine."Loan No");
//           if LoanApp.Find('-') then begin
//           if LoanTypes.Get(LoanApp."Loan Product Type") then begin
//           LoanTypes.TestField(LoanTypes."Receivable Interest Account");
//           MembPostingGr."Receivables Account":=LoanTypes."Loan Interest Account";
//           Found:=true;
//           end;
//           end;
//           end;

//           if (GenJnlLine."Transaction Type"=GenJnlLine."transaction type"::Loan) then
//           begin
//           if GenJnlLine."Loan No" = '' then
//           Error('Loan No must be specified for Loan, Repayment or Interest transactions :- %1',GenJnlLine."Account No.");

//           LoanApp.Reset;
//           LoanApp.SetCurrentkey(LoanApp."Loan  No.");
//           LoanApp.SetRange(LoanApp."Loan  No.",GenJnlLine."Loan No");
//           if LoanApp.Find('-') then begin
//           if LoanTypes.Get(LoanApp."Loan Product Type") then begin
//           LoanTypes.TestField(LoanTypes."Loan Account");
//           MembPostingGr."Receivables Account":=LoanTypes."Loan Account";
//           Found:=true;
//           end;
//           end;

//           end;

//           if (GenJnlLine."Transaction Type"=GenJnlLine."transaction type"::"Loan Insurance Charged") then
//           begin
//           if GenJnlLine."Loan No" = '' then
//           Error('Loan No must be specified for Loan, Repayment,Loan Insurance or Interest transactions :- %1',GenJnlLine."Account No.");

//           LoanApp.Reset;
//           LoanApp.SetCurrentkey(LoanApp."Loan  No.");
//           LoanApp.SetRange(LoanApp."Loan  No.",GenJnlLine."Loan No");
//           if LoanApp.Find('-') then begin
//           if LoanTypes.Get(LoanApp."Loan Product Type") then begin
//           LoanTypes.TestField(LoanTypes."Loan Insurance Accounts");
//           MembPostingGr."Receivables Account":=LoanTypes."Receivable Insurance Accounts";
//           Found:=true;
//           end;
//           end;

//           end;

//           if (GenJnlLine."Transaction Type"=GenJnlLine."transaction type"::"Loan Insurance Paid") then
//           begin
//           if GenJnlLine."Loan No" = '' then
//           Error('Loan No must be specified for Loan, Repayment,Loan Insurance or Interest transactions :- %1',GenJnlLine."Account No.");

//           LoanApp.Reset;
//           LoanApp.SetCurrentkey(LoanApp."Loan  No.");
//           LoanApp.SetRange(LoanApp."Loan  No.",GenJnlLine."Loan No");
//           if LoanApp.Find('-') then begin
//           if LoanTypes.Get(LoanApp."Loan Product Type") then begin
//           LoanTypes.TestField(LoanTypes."Loan Insurance Accounts");
//           MembPostingGr."Receivables Account":=LoanTypes."Receivable Insurance Accounts";
//           Found:=true;
//           end;
//           end;

//           end;



//         if (GenJnlLine."Transaction Type"=GenJnlLine."transaction type"::"Loan Penalty Charged") then
//           begin
//           if GenJnlLine."Loan No" = '' then
//           Error('Loan No must be specified for Loan, Repayment,Loan Insurance or Interest transactions :- %1',GenJnlLine."Account No.");

//           LoanApp.Reset;
//           LoanApp.SetCurrentkey(LoanApp."Loan  No.");
//           LoanApp.SetRange(LoanApp."Loan  No.",GenJnlLine."Loan No");
//           if LoanApp.Find('-') then begin
//           if LoanTypes.Get(LoanApp."Loan Product Type") then begin
//           LoanTypes.TestField(LoanTypes."Penalty Paid Account");
//           MembPostingGr."Receivables Account":=LoanTypes."Penalty Charged Account";
//           Found:=true;
//           end;
//           end;

//           end;

//           if (GenJnlLine."Transaction Type"=GenJnlLine."transaction type"::"Loan Penalty Paid") then
//           begin
//           if GenJnlLine."Loan No" = '' then
//           Error('Loan No must be specified for Loan, Repayment,Loan Insurance or Interest transactions :- %1',GenJnlLine."Account No.");

//           LoanApp.Reset;
//           LoanApp.SetCurrentkey(LoanApp."Loan  No.");
//           LoanApp.SetRange(LoanApp."Loan  No.",GenJnlLine."Loan No");
//           if LoanApp.Find('-') then begin
//           if LoanTypes.Get(LoanApp."Loan Product Type") then begin
//           LoanTypes.TestField(LoanTypes."Penalty Charged Account");
//           MembPostingGr."Receivables Account":=LoanTypes."Penalty Charged Account";
//           Found:=true;
//           end;
//           end;

//           end;


//           if Found=false then begin
//           if   GenJnlLine."Transaction Type"<>GenJnlLine."transaction type"::" " then
//           Error('Transaction Type blocked. %1',GenJnlLine."Account No.");
//           end;






//          // ReceivablesAccount :=MembPostingGr.GetReceivablesAccount;

//           //DtldMembLedgEntry.LOCKTABLE;
//          MembLedgEntry.LockTable;

//           InitMembLedgEntry(GenJnlLine,MembLedgEntry);
//           TransferCustomFields.GenJnlLineTOMembLedgEntry(GenJnlLine,MembLedgEntry);
//           /*
//           IF NOT Memb."Block Payment Tolerance" THEN
//             CalcPmtTolerancePossible(
//               GenJnlLine,MembLedgEntry."Pmt. Discount Date",MembLedgEntry."Pmt. Disc. Tolerance Date",
//               MembLedgEntry."Max. Payment Tolerance");
//         */
//           TempDtldCVLedgEntryBuf.DeleteAll;
//           TempDtldCVLedgEntryBuf.Init;
//           TempDtldCVLedgEntryBuf.CopyFromGenJnlLine(GenJnlLine);
//           TempDtldCVLedgEntryBuf."CV Ledger Entry No." := MembLedgEntry."Entry No.";
//           CVLedgEntryBuf.CopyFromMemberLedgEntry(MembLedgEntry);
//           TempDtldCVLedgEntryBuf.InsertDtldCVLedgEntry(TempDtldCVLedgEntryBuf,CVLedgEntryBuf,true);
//           CVLedgEntryBuf.Open := CVLedgEntryBuf."Remaining Amount" <> 0;
//           CVLedgEntryBuf.Positive := CVLedgEntryBuf."Remaining Amount" > 0;

//           CalcPmtDiscPossible(GenJnlLine,CVLedgEntryBuf);

//          if "Currency Code" <> '' then begin
//             TestField("Currency Factor");
//             CVLedgEntryBuf."Original Currency Factor" := "Currency Factor"
//           end else
//             CVLedgEntryBuf."Original Currency Factor" := 1;
//           CVLedgEntryBuf."Adjusted Currency Factor" := CVLedgEntryBuf."Original Currency Factor";

//           // Check the document no.
//           if "Recurring Method" = 0 then
//             if IsNotPayment("Document Type") then begin
//               GenJnlCheckLine.CheckSalesDocNoIsNotUsed("Document Type","Document No.");
//               CheckSalesExtDocNo(GenJnlLine);
//             end;

//           // Post application
//           ApplyMembLedgEntry(CVLedgEntryBuf,TempDtldCVLedgEntryBuf,GenJnlLine,Memb);

//           // Post Member entry
//           CVLedgEntryBuf.CopyFromMemberLedgEntry(MembLedgEntry);
//           MembLedgEntry."Amount to Apply" := 0;
//           MembLedgEntry."Applies-to Doc. No." := '';

//         //Daudi-Pass entries related to loan

//           MembLedgEntry."Transaction Type":="Transaction Type";
//           MembLedgEntry."Loan No":="Loan No";
//           MembLedgEntry."Prepayment Date":=GenJnlLine."Prepayment date";
//           MembLedgEntry."Recovery Transaction Type":=GenJnlLine."Recovery Transaction Type";
//           MembLedgEntry."Recoverd Loan":=GenJnlLine."Recoverd Loan";
//           MembLedgEntry."Group Code":="Group Code";
//           MembLedgEntry."Debit Amount":="Debit Amount";
//           MembLedgEntry."Credit Amount":="Credit Amount";
//           MembLedgEntry."Amount (LCY)":="Amount (LCY)";
//           MembLedgEntry.Amount:=Amount;
//           MembLedgEntry."Loan No":="Loan No";
//           MembLedgEntry."Group Account No":="Group Account No";
//           MembLedgEntry."Transaction Date":=WorkDate;//Addon insert Actual Transaction Date
//           MembLedgEntry."Created On":=CurrentDatetime;
//           MembLedgEntry."Application Source":="Application Source";
//           MembLedgEntry."Computer Name":=ComputerName.FnGetComputerName();
//           MembLedgEntry.UpdateDebitCredit(Correction);
//           MembLedgEntry.Insert(true);

//           CreateGLEntryBalAcc(
//             GenJnlLine,MembPostingGr."Receivables Account","Amount (LCY)","Source Currency Amount",
//             "Bal. Account Type","Bal. Account No.");

//           // Post detailed Membmer entries
//          //  DtldLedgEntryInserted:= PostDtldMembLedgEntries(GenJnlLine,TempDtldCVLedgEntryBuf,MembPostingGr,TRUE);

//           // Post Reminder Terms - Note About Line Fee on Report
//          // LineFeeNoteOnReportHist.SaveMemb(MembLedgEntry);
//          /*
//           IF DtldLedgEntryInserted THEN
//             IF IsTempGLEntryBufEmpty THEN
//               DtldMembLedgEntry.SetZeroTransNo(NextTransactionNo);

//           UpdateDOPaymentTransactEntry(GenJnlLine,MembLedgEntry."Entry No.");
//           DeferralPosting("Deferral Code","Source Code",ReceivablesAccount,GenJnlLine,Balancing);
//           OnMoveGenJournalLine(MembLedgEntry.RECORDID);
//           */
//         end;

//     end;

//     local procedure InitMembLedgEntry(GenJnlLine: Record "Gen. Journal Line";var MembLedgEntry: Record "Member Ledger Entry")
//     begin
//         MembLedgEntry.Init;
//         MembLedgEntry.CopyFromGenJnlLine(GenJnlLine);
//         MembLedgEntry."Entry No." := NextEntryNo;
//         MembLedgEntry."Transaction No." := NextTransactionNo;
//     end;

//     local procedure ApplyMembLedgEntry(var NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer";var DtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer";GenJnlLine: Record "Gen. Journal Line";Memb: Record "Members Register")
//     var
//         OldMembLedgEntry: Record "Member Ledger Entry";
//         OldCVLedgEntryBuf: Record "CV Ledger Entry Buffer";
//         NewMembLedgEntry: Record "Member Ledger Entry";
//         NewCVLedgEntryBuf2: Record "CV Ledger Entry Buffer";
//         TempOldMembLedgEntry: Record "Member Ledger Entry" temporary;
//         Completed: Boolean;
//         AppliedAmount: Decimal;
//         NewRemainingAmtBeforeAppln: Decimal;
//         ApplyingDate: Date;
//         PmtTolAmtToBeApplied: Decimal;
//         AllApplied: Boolean;
//         VATRealizedGainLossLCY: Decimal;
//     begin
//         if NewCVLedgEntryBuf."Amount to Apply" = 0 then
//           exit;

//         AllApplied := true;
//         if (GenJnlLine."Applies-to Doc. No." = '') and (GenJnlLine."Applies-to ID" = '') and
//            not
//            ((Memb."Application Method" = Memb."application method"::"Apply to Oldest") and
//             GenJnlLine."Allow Application")
//         then
//           exit;

//         PmtTolAmtToBeApplied := 0;
//         NewRemainingAmtBeforeAppln := NewCVLedgEntryBuf."Remaining Amount";
//         NewCVLedgEntryBuf2 := NewCVLedgEntryBuf;

//         ApplyingDate := GenJnlLine."Posting Date";

//         if not PrepareTempMembLedgEntry(GenJnlLine,NewCVLedgEntryBuf,TempOldMembLedgEntry,Memb,ApplyingDate) then
//           exit;

//         GenJnlLine."Posting Date" := ApplyingDate;
//         // Apply the new entry (Payment) to the old entries (Invoices) one at a time
//         repeat
//           TempOldMembLedgEntry.CalcFields(
//             Amount,"Amount (LCY)","Remaining Amount","Remaining Amt. (LCY)",
//             "Original Amount","Original Amt. (LCY)");
//           TempOldMembLedgEntry.Copyfilter(Positive,OldCVLedgEntryBuf.Positive);
//           OldCVLedgEntryBuf.CopyFromMemberLedgEntry(TempOldMembLedgEntry);

//           PostApply(
//             GenJnlLine,DtldCVLedgEntryBuf,OldCVLedgEntryBuf,NewCVLedgEntryBuf,NewCVLedgEntryBuf2,
//             Memb."Block Payment Tolerance",AllApplied,AppliedAmount,PmtTolAmtToBeApplied,VATRealizedGainLossLCY);

//           if not OldCVLedgEntryBuf.Open then begin
//             UpdateCalcInterest(OldCVLedgEntryBuf);
//             UpdateCalcInterest2(OldCVLedgEntryBuf,NewCVLedgEntryBuf);
//           end;

//           OldCVLedgEntryBuf.CopyFromMemberLedgEntry(TempOldMembLedgEntry);
//           OldMembLedgEntry := TempOldMembLedgEntry;
//           OldMembLedgEntry."Applies-to ID" := '';
//           OldMembLedgEntry."Amount to Apply" := 0;
//           OldMembLedgEntry.Modify;

//           if GLSetup."Unrealized VAT" or
//              (GLSetup."Prepayment Unrealized VAT" and TempOldMembLedgEntry.Prepayment)
//           then
//             if IsNotPayment(TempOldMembLedgEntry."Document Type") then begin
//               TempOldMembLedgEntry.RecalculateAmounts(
//                 NewCVLedgEntryBuf."Currency Code",TempOldMembLedgEntry."Currency Code",NewCVLedgEntryBuf."Posting Date");
//               MembUnrealizedVAT(
//                 GenJnlLine,
//                 TempOldMembLedgEntry,
//                 CurrExchRate.ExchangeAmount(
//                   AppliedAmount,NewCVLedgEntryBuf."Currency Code",
//                   TempOldMembLedgEntry."Currency Code",NewCVLedgEntryBuf."Posting Date"),
//                 VATRealizedGainLossLCY,NewCVLedgEntryBuf."Adjusted Currency Factor",NewCVLedgEntryBuf."Posting Date");
//             end;

//           TempOldMembLedgEntry.Delete;

//           // Find the next old entry for application of the new entry
//           if GenJnlLine."Applies-to Doc. No." <> '' then
//             Completed := true
//           else
//             if TempOldMembLedgEntry.GetFilter(Positive) <> '' then
//               if TempOldMembLedgEntry.Next = 1 then
//                 Completed := false
//               else begin
//                 TempOldMembLedgEntry.SetRange(Positive);
//                 TempOldMembLedgEntry.Find('-');
//                 TempOldMembLedgEntry.CalcFields("Remaining Amount");
//                 Completed := TempOldMembLedgEntry."Remaining Amount" * NewCVLedgEntryBuf."Remaining Amount" >= 0;
//               end
//             else
//               if NewCVLedgEntryBuf.Open then
//                 Completed := TempOldMembLedgEntry.Next = 0
//               else
//                 Completed := true;
//         until Completed;

//         DtldCVLedgEntryBuf.SetCurrentkey("CV Ledger Entry No.","Entry Type");
//         DtldCVLedgEntryBuf.SetRange("CV Ledger Entry No.",NewCVLedgEntryBuf."Entry No.");
//         DtldCVLedgEntryBuf.SetRange(
//           "Entry Type",
//           DtldCVLedgEntryBuf."entry type"::Application);
//         DtldCVLedgEntryBuf.CalcSums("Amount (LCY)",Amount);

//         CalcCurrencyUnrealizedGainLoss(
//           NewCVLedgEntryBuf,DtldCVLedgEntryBuf,GenJnlLine,DtldCVLedgEntryBuf.Amount,NewRemainingAmtBeforeAppln);

//         CalcAmtLCYAdjustment(NewCVLedgEntryBuf,DtldCVLedgEntryBuf,GenJnlLine);

//         NewCVLedgEntryBuf."Applies-to ID" := '';
//         NewCVLedgEntryBuf."Amount to Apply" := 0;

//         if not NewCVLedgEntryBuf.Open then
//           UpdateCalcInterest(NewCVLedgEntryBuf);

//         if GLSetup."Unrealized VAT" or
//            (GLSetup."Prepayment Unrealized VAT" and NewCVLedgEntryBuf.Prepayment)
//         then
//           if IsNotPayment(NewCVLedgEntryBuf."Document Type") and
//              (NewRemainingAmtBeforeAppln - NewCVLedgEntryBuf."Remaining Amount" <> 0)
//           then begin
//             NewCVLedgEntryBuf.CopyFromMemberLedgEntry(NewMembLedgEntry);
//             CheckUnrealizedMemb:= true;
//             UnrealizedMembLedgEntry := NewMembLedgEntry;
//             UnrealizedMembLedgEntry.CalcFields("Amount (LCY)","Original Amt. (LCY)");
//             UnrealizedRemainingAmountMemb := NewMembLedgEntry."Remaining Amount" - NewRemainingAmtBeforeAppln;
//           end;
//     end;

//     local procedure PostDtldMembLedgEntries(GenJnlLine: Record "Gen. Journal Line";var DtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer";MembPostingGr: Record "Customer Posting Group";LedgEntryInserted: Boolean) DtldLedgEntryInserted: Boolean
//     var
//         TempInvPostBuf: Record "Invoice Post. Buffer" temporary;
//         DtldMembLedgEntry: Record "Detailed Cust. Ledg. Entry";
//         DimMgt: Codeunit DimensionManagement;
//         AdjAmount: array [4] of Decimal;
//         DtldMembLedgEntryNoOffset: Integer;
//         SaveEntryNo: Integer;
//     begin
//         if GenJnlLine."Account Type" <> GenJnlLine."account type"::Customer then
//           exit;

//         if DtldMembLedgEntry.FindLast then
//           DtldMembLedgEntryNoOffset := DtldMembLedgEntry."Entry No."
//         else
//           DtldMembLedgEntryNoOffset := 0;

//         DtldCVLedgEntryBuf.Reset;
//         if DtldCVLedgEntryBuf.FindSet then begin
//           if LedgEntryInserted then begin
//             SaveEntryNo := NextEntryNo;
//             NextEntryNo := NextEntryNo + 1;
//           end;
//           repeat
//             InsertDtldMembLedgEntry(GenJnlLine,DtldCVLedgEntryBuf,DtldMembLedgEntry,DtldMembLedgEntryNoOffset);

//             DimMgt.UpdateGenJnlLineDimFromMembLedgEntry(GenJnlLine,DtldMembLedgEntry);
//             UpdateTotalAmounts(
//               TempInvPostBuf,GenJnlLine."Dimension Set ID",
//               DtldCVLedgEntryBuf."Amount (LCY)",DtldCVLedgEntryBuf."Additional-Currency Amount");

//             // Post automatic entries.
//             if ((DtldCVLedgEntryBuf."Amount (LCY)" <> 0) or
//                 (DtldCVLedgEntryBuf."VAT Amount (LCY)" <> 0)) or
//                ((AddCurrencyCode <> '') and (DtldCVLedgEntryBuf."Additional-Currency Amount" <> 0))
//             then
//               PostDtldMembLedgEntry(GenJnlLine,DtldCVLedgEntryBuf,MembPostingGr,AdjAmount);
//           until DtldCVLedgEntryBuf.Next = 0;
//         end;

//         CreateGLEntriesForTotalAmounts(
//           GenJnlLine,TempInvPostBuf,AdjAmount,SaveEntryNo,MembPostingGr.GetReceivablesAccount,LedgEntryInserted);

//         DtldLedgEntryInserted := not DtldCVLedgEntryBuf.IsEmpty;
//         DtldCVLedgEntryBuf.DeleteAll;
//     end;

//     local procedure PostDtldMembLedgEntry(GenJnlLine: Record "Gen. Journal Line";DtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer";MembPostingGr: Record "Customer Posting Group";var AdjAmount: array [4] of Decimal)
//     var
//         AccNo: Code[20];
//     begin
//         AccNo := GetDtldMembLedgEntryAccNo(GenJnlLine,DtldCVLedgEntryBuf,MembPostingGr,0,false);
//         PostDtldCVLedgEntry(GenJnlLine,DtldCVLedgEntryBuf,AccNo,AdjAmount,false);
//     end;

//     local procedure PrepareTempMembLedgEntry(GenJnlLine: Record "Gen. Journal Line";var NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer";var TempOldMembLedgEntry: Record "Member Ledger Entry" temporary;Memb: Record "Members Register";var ApplyingDate: Date): Boolean
//     var
//         OldMembLedgEntry: Record "Member Ledger Entry";
//         SalesSetup: Record "Sales & Receivables Setup";
//         GenJnlApply: Codeunit "Gen. Jnl.-Apply";
//         RemainingAmount: Decimal;
//     begin
//         if GenJnlLine."Applies-to Doc. No." <> '' then begin
//           // Find the entry to be applied to
//           OldMembLedgEntry.Reset;
//           OldMembLedgEntry.SetCurrentkey("Document No.");
//           OldMembLedgEntry.SetRange("Document No.",GenJnlLine."Applies-to Doc. No.");
//           OldMembLedgEntry.SetRange("Document Type",GenJnlLine."Applies-to Doc. Type");
//           OldMembLedgEntry.SetRange("Customer No.",NewCVLedgEntryBuf."CV No.");
//           OldMembLedgEntry.SetRange(Open,true);

//           OldMembLedgEntry.FindFirst;
//           OldMembLedgEntry.TestField(Positive,not NewCVLedgEntryBuf.Positive);
//           if OldMembLedgEntry."Posting Date" > ApplyingDate then
//             ApplyingDate := OldMembLedgEntry."Posting Date";
//           GenJnlApply.CheckAgainstApplnCurrency(
//             NewCVLedgEntryBuf."Currency Code",OldMembLedgEntry."Currency Code",GenJnlLine."account type"::Customer,true);
//           TempOldMembLedgEntry := OldMembLedgEntry;
//           TempOldMembLedgEntry.Insert;
//         end else begin
//           // Find the first old entry (Invoice) which the new entry (Payment) should apply to
//           OldMembLedgEntry.Reset;
//           OldMembLedgEntry.SetCurrentkey("Customer No.","Applies-to ID",Open,Positive,"Due Date");
//           TempOldMembLedgEntry.SetCurrentkey("Customer No.","Applies-to ID",Open,Positive,"Due Date");
//           OldMembLedgEntry.SetRange("Customer No.",NewCVLedgEntryBuf."CV No.");
//           OldMembLedgEntry.SetRange("Applies-to ID",GenJnlLine."Applies-to ID");
//           OldMembLedgEntry.SetRange(Open,true);
//           OldMembLedgEntry.SetFilter("Entry No.",'<>%1',NewCVLedgEntryBuf."Entry No.");
//           if not (Memb."Application Method" = Memb."application method"::"Apply to Oldest") then
//             OldMembLedgEntry.SetFilter("Amount to Apply",'<>%1',0);

//           if Memb."Application Method" = Memb."application method"::"Apply to Oldest" then
//             OldMembLedgEntry.SetFilter("Posting Date",'..%1',GenJnlLine."Posting Date");

//           // Check Cust Ledger Entry and add to Temp.
//           SalesSetup.Get;
//           if SalesSetup."Appln. between Currencies" = SalesSetup."appln. between currencies"::None then
//             OldMembLedgEntry.SetRange("Currency Code",NewCVLedgEntryBuf."Currency Code");
//           if OldMembLedgEntry.FindSet(false,false) then
//             repeat
//               if GenJnlApply.CheckAgainstApplnCurrency(
//                    NewCVLedgEntryBuf."Currency Code",OldMembLedgEntry."Currency Code",GenJnlLine."account type"::Customer,false)
//               then begin
//                 if (OldMembLedgEntry."Posting Date" > ApplyingDate) and (OldMembLedgEntry."Applies-to ID" <> '') then
//                   ApplyingDate := OldMembLedgEntry."Posting Date";
//                 TempOldMembLedgEntry := OldMembLedgEntry;
//                 TempOldMembLedgEntry.Insert;
//               end;
//             until OldMembLedgEntry.Next = 0;

//           TempOldMembLedgEntry.SetRange(Positive,NewCVLedgEntryBuf."Remaining Amount" > 0);

//           if TempOldMembLedgEntry.Find('-') then begin
//             RemainingAmount := NewCVLedgEntryBuf."Remaining Amount";
//             TempOldMembLedgEntry.SetRange(Positive);
//             TempOldMembLedgEntry.Find('-');
//             repeat
//               TempOldMembLedgEntry.CalcFields("Remaining Amount");
//               TempOldMembLedgEntry.RecalculateAmounts(
//                 TempOldMembLedgEntry."Currency Code",NewCVLedgEntryBuf."Currency Code",NewCVLedgEntryBuf."Posting Date");
//               if PaymentToleranceMgt.CheckCalcPmtDiscCVMemb(NewCVLedgEntryBuf,TempOldMembLedgEntry,0,false,false) then
//                 TempOldMembLedgEntry."Remaining Amount" -= TempOldMembLedgEntry."Remaining Pmt. Disc. Possible";
//               RemainingAmount += TempOldMembLedgEntry."Remaining Amount";
//             until TempOldMembLedgEntry.Next = 0;
//             TempOldMembLedgEntry.SetRange(Positive,RemainingAmount < 0);
//           end else
//             TempOldMembLedgEntry.SetRange(Positive);

//           exit(TempOldMembLedgEntry.Find('-'));
//         end;
//         exit(true);
//     end;

//     local procedure MembUnrealizedVAT(GenJnlLine: Record "Gen. Journal Line";var MembLedgEntry2: Record "Member Ledger Entry";SettledAmount: Decimal;GainLossLCY: Decimal;CurrencyFactor: Decimal;PostingDate: Date)
//     var
//         VATEntry2: Record "VAT Entry";
//         TaxJurisdiction: Record "Tax Jurisdiction";
//         VATPostingSetup: Record "VAT Posting Setup";
//         GLEntry: Record "G/L Entry";
//         VATPart: Decimal;
//         VATAmount: Decimal;
//         VATBase: Decimal;
//         VATAmountAddCurr: Decimal;
//         VATBaseAddCurr: Decimal;
//         PaidAmount: Decimal;
//         TotalUnrealVATAmountLast: Decimal;
//         TotalUnrealVATAmountFirst: Decimal;
//         SalesVATAccount: Code[20];
//         SalesVATUnrealAccount: Code[20];
//         LastConnectionNo: Integer;
//         RealizedPart: Decimal;
//         RealizedVATAmount: Decimal;
//         RealizedVATBase: Decimal;
//         RealizedVATAmountAddCurr: Decimal;
//         RealizedVATBaseAddCurr: Decimal;
//         Currency: Record Currency;
//         VATBaseFCY: Decimal;
//         VATAmountFCY: Decimal;
//         VATAmountCash: Decimal;
//         VATBaseCash: Decimal;
//     begin
//         MembLedgEntry2.CalcFields("Amount (LCY)","Original Amt. (LCY)");
//         PaidAmount := MembLedgEntry2."Amount (LCY)" - MembLedgEntry2."Remaining Amt. (LCY)";
//         VATEntry2.Reset;
//         VATEntry2.SetCurrentkey("Transaction No.");
//         VATEntry2.SetRange("Transaction No.",MembLedgEntry2."Transaction No.");
//         if VATEntry2.FindSet then
//           repeat
//             VATPostingSetup.Get(VATEntry2."VAT Bus. Posting Group",VATEntry2."VAT Prod. Posting Group");
//             if VATEntry2."VAT Calculation Type" = VATEntry2."vat calculation type" :: "Sales Tax" then begin
//               TaxJurisdiction.Get(VATEntry2."Tax Jurisdiction Code");
//               CalculateFirstLastAmount(TaxJurisdiction."Unrealized VAT Type", VATEntry2."Remaining Unrealized Amount",TotalUnrealVATAmountLast,TotalUnrealVATAmountFirst);
//             end else
//               CalculateFirstLastAmount(VATPostingSetup."Unrealized VAT Type", VATEntry2."Remaining Unrealized Amount",TotalUnrealVATAmountLast,TotalUnrealVATAmountFirst);
//           until VATEntry2.Next = 0;
//         if VATEntry2.FindSet then begin
//           LastConnectionNo := 0;
//           repeat
//             VATPostingSetup.Get(VATEntry2."VAT Bus. Posting Group",VATEntry2."VAT Prod. Posting Group");
//             if LastConnectionNo <> VATEntry2."Sales Tax Connection No." then begin
//               InsertSummarizedVAT(GenJnlLine);
//               LastConnectionNo := VATEntry2."Sales Tax Connection No.";
//             end;

//             /*VATPart :=
//               VATEntry2."GetUnrealizedVATPart."(
//                 ROUND(SettledAmount / MembLedgEntry2.GetOriginalCurrencyFactor),
//                 PaidAmount,
//                 MembLedgEntry2."Original Amt. (LCY)",
//                 TotalUnrealVATAmountFirst,
//                 TotalUnrealVATAmountLast,
//                 MembLedgEntry2."Original Amt. (LCY)");*/
//                 //MembLedgEntry2."Original Currency Factor");

//             if VATPart > 0 then begin
//               case VATEntry2."VAT Calculation Type" of
//                 VATEntry2."vat calculation type"::"Normal VAT",
//                 VATEntry2."vat calculation type"::"Reverse Charge VAT",
//                 VATEntry2."vat calculation type"::"Full VAT":
//                   begin
//                     SalesVATAccount := VATPostingSetup.GetSalesAccount(false);
//                     SalesVATUnrealAccount := VATPostingSetup.GetSalesAccount(true);
//                   end;
//                 VATEntry2."vat calculation type"::"Sales Tax":
//                   begin
//                     TaxJurisdiction.Get(VATEntry2."Tax Jurisdiction Code");
//                     SalesVATAccount := TaxJurisdiction.GetSalesAccount(false);
//                     SalesVATUnrealAccount := TaxJurisdiction.GetSalesAccount(true);
//                   end;
//               end;

//               if VATPart = 1 then begin
//                 VATAmount := VATEntry2."Remaining Unrealized Amount";
//                 VATBase := VATEntry2."Remaining Unrealized Base";
//                 VATAmountAddCurr := VATEntry2."Add.-Curr. Rem. Unreal. Amount";
//                 VATBaseAddCurr := VATEntry2."Add.-Curr. Rem. Unreal. Base";
//               end else begin
//                 if (VATPostingSetup."Unrealized VAT Type" <> VATPostingSetup."unrealized vat type"::"6") then begin
//                   VATAmount := ROUND(VATEntry2."Remaining Unrealized Amount" * VATPart,GLSetup."Amount Rounding Precision");
//                   VATBase := ROUND(VATEntry2."Remaining Unrealized Base" * VATPart,GLSetup."Amount Rounding Precision");
//                   VATAmountAddCurr :=
//                     ROUND(
//                       VATEntry2."Add.-Curr. Rem. Unreal. Amount" * VATPart,
//                       AddCurrency."Amount Rounding Precision");
//                   VATBaseAddCurr :=
//                     ROUND(
//                       VATEntry2."Add.-Curr. Rem. Unreal. Base" * VATPart,
//                       AddCurrency."Amount Rounding Precision");
//                 end else begin
//                   VATAmount := ROUND(VATEntry2."Unrealized Amount" * VATPart,GLSetup."Amount Rounding Precision");
//                   VATBase := ROUND(VATEntry2."Unrealized Base" * VATPart,GLSetup."Amount Rounding Precision");
//                   VATAmountAddCurr :=
//                     ROUND(
//                       VATEntry2."Add.-Currency Unrealized Amt." * VATPart,
//                       AddCurrency."Amount Rounding Precision");
//                   VATBaseAddCurr :=
//                     ROUND(
//                       VATEntry2."Add.-Currency Unrealized Base" * VATPart,
//                       AddCurrency."Amount Rounding Precision");
//                 end;
//               end;

//               // what is LCY value of VAT and VAT Base at posting date (cash basis)
//               if (VATPostingSetup."Unrealized VAT Type" = VATPostingSetup."unrealized vat type"::"6") and
//                  (GainLossLCY <> 0)
//               then begin
//                 if CurrencyFactor = 1 then // LCY to FCY application
//                   CurrencyFactor := CurrExchRate.ExchangeRate(PostingDate,MembLedgEntry2."Currency Code");
//                 VATBaseFCY := ROUND(
//                     CurrExchRate.ExchangeAmtLCYToFCY(
//                       PostingDate,MembLedgEntry2."Currency Code",VATBase,MembLedgEntry2."Original Currency Factor"));
//                 VATBaseCash :=
//                   ROUND(
//                     CurrExchRate.ExchangeAmtFCYToLCY(
//                       PostingDate,MembLedgEntry2."Currency Code",VATBaseFCY,CurrencyFactor));
//                 VATAmountFCY := ROUND(
//                     CurrExchRate.ExchangeAmtLCYToFCY(
//                       PostingDate,MembLedgEntry2."Currency Code",VATAmount,MembLedgEntry2."Original Currency Factor"));
//                 VATAmountCash :=
//                   ROUND(
//                     CurrExchRate.ExchangeAmtFCYToLCY(
//                       PostingDate,MembLedgEntry2."Currency Code",VATAmountFCY,CurrencyFactor));
//               end else
//                 RealizedPart := 1;
//               RealizedVATAmount := 0;
//               RealizedVATBase := 0;
//               RealizedVATAmountAddCurr := 0;
//               RealizedVATBaseAddCurr := 0;
//               if (GainLossLCY <> 0) and (MembLedgEntry2."Currency Code" <> '') and
//                  (VATPostingSetup."Unrealized VAT Type" = VATPostingSetup."unrealized vat type"::"6")
//               then begin
//                 RealizedVATAmount := -(VATAmount - VATAmountCash);
//                 RealizedVATBase := -(VATBase - VATBaseCash);
//               end;

//               InitGLEntryVAT(
//                 GenJnlLine,SalesVATUnrealAccount,SalesVATAccount,-VATAmount,-VATAmountAddCurr,false);
//               InitGLEntryVATCopy(
//                 GenJnlLine,SalesVATAccount,SalesVATUnrealAccount,VATAmount + RealizedVATAmount,VATAmountAddCurr + RealizedVATAmountAddCurr,VATEntry2);

//               if (GainLossLCY <> 0) and (MembLedgEntry2."Currency Code" <> '') and
//                  (VATPostingSetup."Unrealized VAT Type" = VATPostingSetup."unrealized vat type"::"6")
//               then begin
//                 Currency.Get(MembLedgEntry2."Currency Code");
//                 case MembLedgEntry2."Document Type" of
//                   MembLedgEntry2."document type"::"Credit Memo":
//                     begin
//                       if GainLossLCY > 0 then begin
//                         Currency.TestField("Realized Losses Acc.");
//                         InitGLEntry(GenJnlLine,GLEntry,
//                           Currency."Realized Losses Acc.",-RealizedVATAmount,0,false,true);
//                         GLEntry."Additional-Currency Amount" := -RealizedVATAmountAddCurr;
//                       end else begin
//                         Currency.TestField("Realized Gains Acc.");
//                         InitGLEntry(GenJnlLine,GLEntry,
//                           Currency."Realized Gains Acc.",-RealizedVATAmount,0,false,true);
//                         GLEntry."Additional-Currency Amount" := -RealizedVATAmountAddCurr;
//                       end;
//                     end;
//                   else
//                     if GainLossLCY < 0 then begin
//                       Currency.TestField("Realized Losses Acc.");
//                       InitGLEntry(GenJnlLine,GLEntry,
//                         Currency."Realized Losses Acc.",-RealizedVATAmount,0,false,true);
//                       GLEntry."Additional-Currency Amount" := -RealizedVATAmountAddCurr;
//                     end else begin
//                       Currency.TestField("Realized Gains Acc.");
//                       InitGLEntry(GenJnlLine,GLEntry,
//                         Currency."Realized Gains Acc.",-RealizedVATAmount,0,false,true);
//                       GLEntry."Additional-Currency Amount" := -RealizedVATAmountAddCurr;
//                     end;
//                 end;
//                 GLEntry.CopyPostingGroupsFromVATEntry(VATEntry2);
//                 SummarizeVAT(GLSetup."Summarize G/L Entries",GLEntry);
//               end;

//               PostUnrealVATEntry(GenJnlLine,VATEntry2,VATAmount,VATBase,VATAmountAddCurr,VATBaseAddCurr,GLEntryNo);
//             end;
//           until VATEntry2.Next = 0;

//           InsertSummarizedVAT(GenJnlLine);
//         end;

//     end;

//     local procedure InsertDtldMembLedgEntry(GenJnlLine: Record "Gen. Journal Line";DtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer";var DtldMembLedgEntry: Record "Detailed Cust. Ledg. Entry";Offset: Integer)
//     begin
//         with DtldMembLedgEntry do begin
//           Init;
//           TransferFields(DtldCVLedgEntryBuf);
//           "Entry No." := Offset + DtldCVLedgEntryBuf."Entry No.";
//           "Journal Batch Name" := GenJnlLine."Journal Batch Name";
//           "Reason Code" := GenJnlLine."Reason Code";
//           "Source Code" := GenJnlLine."Source Code";
//           "Transaction No." := NextTransactionNo;
//           UpdateDebitCredit(GenJnlLine.Correction);
//           Insert(true);
//         end;
//     end;

//     local procedure GetDtldMembLedgEntryAccNo(GenJnlLine: Record "Gen. Journal Line";DtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer";MembPostingGr: Record "Customer Posting Group";OriginalTransactionNo: Integer;Unapply: Boolean): Code[20]
//     var
//         GenPostingSetup: Record "General Posting Setup";
//         Currency: Record Currency;
//         AmountCondition: Boolean;
//         VATAmountCondition: Boolean;
//     begin
//         with DtldCVLedgEntryBuf do begin
//           if Unapply then begin
//             AmountCondition := "Amount (LCY)" > 0;
//             VATAmountCondition := "VAT Amount (LCY)" > 0;
//           end else begin
//             AmountCondition := "Amount (LCY)" <= 0;
//             VATAmountCondition := "VAT Amount (LCY)" <= 0;
//           end;
//           case "Entry Type" of
//             "entry type"::"Initial Entry":
//               ;
//             "entry type"::Application:
//               ;
//             "entry type"::"Unrealized Loss",
//             "entry type"::"Unrealized Gain",
//             "entry type"::"Realized Loss",
//             "entry type"::"Realized Gain":
//               begin
//                 GetCurrency(Currency,"Currency Code");
//                 CheckNonAddCurrCodeOccurred(Currency.Code);
//                 exit(Currency.GetGainLossAccount(DtldCVLedgEntryBuf));
//               end;
//             "entry type"::"Payment Discount":
//               exit(MembPostingGr.GetPmtDiscountAccount(AmountCondition));
//             "entry type"::"Payment Discount (VAT Excl.)":
//               begin
//                 TestField("Gen. Prod. Posting Group");
//                 GenPostingSetup.Get("Gen. Bus. Posting Group","Gen. Prod. Posting Group");
//                 exit(GenPostingSetup.GetSalesPmtDiscountAccount(AmountCondition and VATAmountCondition));
//               end;
//             "entry type"::"Appln. Rounding":
//               exit(MembPostingGr.GetApplRoundingAccount(AmountCondition));
//             "entry type"::"Correction of Remaining Amount":
//               exit(MembPostingGr.GetRoundingAccount(AmountCondition));
//             "entry type"::"Payment Discount Tolerance":
//               case GLSetup."Pmt. Disc. Tolerance Posting" of
//                 GLSetup."pmt. disc. tolerance posting"::"Payment Tolerance Accounts":
//                   exit(MembPostingGr.GetPmtToleranceAccount(AmountCondition));
//                 GLSetup."pmt. disc. tolerance posting"::"Payment Discount Accounts":
//                   exit(MembPostingGr.GetPmtDiscountAccount(AmountCondition));
//               end;
//             "entry type"::"Payment Tolerance":
//               case GLSetup."Payment Tolerance Posting" of
//                 GLSetup."payment tolerance posting"::"Payment Tolerance Accounts":
//                   exit(MembPostingGr.GetPmtToleranceAccount(AmountCondition));
//                 GLSetup."payment tolerance posting"::"Payment Discount Accounts":
//                   exit(MembPostingGr.GetPmtDiscountAccount(AmountCondition));
//               end;
//             "entry type"::"Payment Tolerance (VAT Excl.)":
//               begin
//                 TestField("Gen. Prod. Posting Group");
//                 GenPostingSetup.Get("Gen. Bus. Posting Group","Gen. Prod. Posting Group");
//                 case GLSetup."Payment Tolerance Posting" of
//                   GLSetup."payment tolerance posting"::"Payment Tolerance Accounts":
//                     exit(GenPostingSetup.GetSalesPmtToleranceAccount(AmountCondition and VATAmountCondition));
//                   GLSetup."payment tolerance posting"::"Payment Discount Accounts":
//                     exit(GenPostingSetup.GetSalesPmtDiscountAccount(AmountCondition and VATAmountCondition));
//                 end;
//               end;
//             "entry type"::"Payment Discount Tolerance (VAT Excl.)":
//               begin
//                 GenPostingSetup.Get("Gen. Bus. Posting Group","Gen. Prod. Posting Group");
//                 case GLSetup."Pmt. Disc. Tolerance Posting" of
//                   GLSetup."pmt. disc. tolerance posting"::"Payment Tolerance Accounts":
//                     exit(GenPostingSetup.GetSalesPmtToleranceAccount(AmountCondition and VATAmountCondition));
//                   GLSetup."pmt. disc. tolerance posting"::"Payment Discount Accounts":
//                     exit(GenPostingSetup.GetSalesPmtDiscountAccount(AmountCondition and VATAmountCondition));
//                 end;
//               end;
//             "entry type"::"Payment Discount (VAT Adjustment)",
//             "entry type"::"Payment Tolerance (VAT Adjustment)",
//             "entry type"::"Payment Discount Tolerance (VAT Adjustment)":
//               if Unapply then
//                 PostDtldMembVATAdjustment(GenJnlLine,DtldCVLedgEntryBuf,OriginalTransactionNo);
//             else
//               FieldError("Entry Type");
//           end;
//         end;
//     end;


//     procedure MembPostApplyMembLedgEntry(var GenJnlLinePostApply: Record "Gen. Journal Line";var MembLedgEntryPostApply: Record "Member Ledger Entry")
//     var
//         Memb: Record "Members Register";
//         MembPostingGr: Record "Customer Posting Group";
//         MembLedgEntry: Record "Member Ledger Entry";
//         DtldMembLedgEntry: Record "Detailed Cust. Ledg. Entry";
//         TempDtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer" temporary;
//         CVLedgEntryBuf: Record "CV Ledger Entry Buffer";
//         GenJnlLine: Record "Gen. Journal Line";
//         DtldLedgEntryInserted: Boolean;
//     begin
//         GenJnlLine := GenJnlLinePostApply;
//         MembLedgEntry.TransferFields(MembLedgEntryPostApply);
//         with GenJnlLine do begin
//           "Source Currency Code" := MembLedgEntryPostApply."Currency Code";
//           "Applies-to ID" := MembLedgEntryPostApply."Applies-to ID";

//           GenJnlCheckLine.RunCheck(GenJnlLine);

//           if NextEntryNo = 0 then
//             StartPosting(GenJnlLine)
//           else
//             ContinuePosting(GenJnlLine);

//           Memb.Get(MembLedgEntry."Customer No.");
//           Memb.CheckBlockedMembOnJnls(Memb,"Document Type",true);

//           if "Posting Group" = '' then begin
//             Memb.TestField("Customer Posting Group");
//             "Posting Group" := Memb."Customer Posting Group";
//           end;
//           MembPostingGr.Get("Posting Group");
//           MembPostingGr.GetReceivablesAccount;

//           DtldMembLedgEntry.LockTable;
//           MembLedgEntry.LockTable;

//           // Post the application
//           MembLedgEntry.CalcFields(
//             Amount,"Amount (LCY)","Remaining Amount","Remaining Amt. (LCY)",
//             "Original Amount","Original Amt. (LCY)");
//           CVLedgEntryBuf.CopyFromMemberLedgEntry(MembLedgEntry);
//           ApplyMembLedgEntry(CVLedgEntryBuf,TempDtldCVLedgEntryBuf,GenJnlLine,Memb);
//           CVLedgEntryBuf.CopyFromMemberLedgEntry(MembLedgEntry);
//           MembLedgEntry.Modify;

//           // Post the Dtld customer entry
//           DtldLedgEntryInserted := PostDtldMembLedgEntries(GenJnlLine,TempDtldCVLedgEntryBuf,MembPostingGr,false);

//           CheckPostUnrealizedVAT(GenJnlLine,true);

//           if DtldLedgEntryInserted then
//             if IsTempGLEntryBufEmpty then
//               DtldMembLedgEntry.SetZeroTransNo(NextTransactionNo);
//           FinishPosting;
//         end;
//     end;

//     local procedure PostDtldMembLedgEntryUnapply(GenJnlLine: Record "Gen. Journal Line";DtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer";MembPostingGr: Record "Customer Posting Group";OriginalTransactionNo: Integer)
//     var
//         AdjAmount: array [4] of Decimal;
//         AccNo: Code[20];
//     begin
//         if (DtldCVLedgEntryBuf."Amount (LCY)" = 0) and
//            ((AddCurrencyCode = '') or (DtldCVLedgEntryBuf."Additional-Currency Amount" = 0))
//         then
//           exit;

//         AccNo := GetDtldMembLedgEntryAccNo(GenJnlLine,DtldCVLedgEntryBuf,MembPostingGr,OriginalTransactionNo,true);
//         PostDtldCVLedgEntry(GenJnlLine,DtldCVLedgEntryBuf,AccNo,AdjAmount,true);
//     end;

//     local procedure PostDtldMembVATAdjustment(GenJnlLine: Record "Gen. Journal Line";DtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer";OriginalTransactionNo: Integer)
//     var
//         VATPostingSetup: Record "VAT Posting Setup";
//         TaxJurisdiction: Record "Tax Jurisdiction";
//     begin
//         with DtldCVLedgEntryBuf do begin
//           VATEntry.Reset;
//           VATEntry.SetCurrentkey("Transaction No.");
//           VATEntry.SetRange("Transaction No.",OriginalTransactionNo);
//           VATEntry.SetRange("VAT Bus. Posting Group","VAT Bus. Posting Group");
//           VATEntry.SetRange("VAT Prod. Posting Group","VAT Prod. Posting Group");
//           VATEntry.FindFirst;

//           case VATPostingSetup."VAT Calculation Type" of
//             VATPostingSetup."vat calculation type"::"Normal VAT",
//             VATPostingSetup."vat calculation type"::"Full VAT":
//               begin
//                 VATPostingSetup.Get("VAT Bus. Posting Group","VAT Prod. Posting Group");
//                 VATPostingSetup.TestField("VAT Calculation Type",VATEntry."VAT Calculation Type");
//                 CreateGLEntry(
//                   GenJnlLine,VATPostingSetup.GetSalesAccount(false),-"Amount (LCY)",-"Additional-Currency Amount",false);
//               end;
//             VATPostingSetup."vat calculation type"::"Reverse Charge VAT":
//               ;
//             VATPostingSetup."vat calculation type"::"Sales Tax":
//               begin
//                 TestField("Tax Jurisdiction Code");
//                 TaxJurisdiction.Get("Tax Jurisdiction Code");
//                 CreateGLEntry(
//                   GenJnlLine,TaxJurisdiction.GetPurchAccount(false),-"Amount (LCY)",-"Additional-Currency Amount",false);
//               end;
//           end;
//         end;
//     end;


//     procedure UnapplyMembLedgEntry(GenJnlLine2: Record "Gen. Journal Line";DtldMembLedgEntry: Record "Detailed Cust. Ledg. Entry")
//     var
//         Memb: Record "Members Register";
//         MembPostingGr: Record "Customer Posting Group";
//         GenJnlLine: Record "Gen. Journal Line";
//         DtldMembLedgEntry2: Record "Detailed Cust. Ledg. Entry";
//         NewDtldMembLedgEntry: Record "Detailed Cust. Ledg. Entry";
//         MembLedgEntry: Record "Member Ledger Entry";
//         DtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer";
//         VATEntry: Record "VAT Entry";
//         TempVATEntry2: Record "VAT Entry" temporary;
//         CurrencyLCY: Record Currency;
//         TempInvPostBuf: Record "Invoice Post. Buffer" temporary;
//         DimMgt: Codeunit DimensionManagement;
//         AdjAmount: array [4] of Decimal;
//         NextDtldLedgEntryNo: Integer;
//         UnapplyVATEntries: Boolean;
//     begin
//         GenJnlLine.TransferFields(GenJnlLine2);
//         if GenJnlLine."Document Date" = 0D then
//           GenJnlLine."Document Date" := GenJnlLine."Posting Date";

//         if NextEntryNo = 0 then
//           StartPosting(GenJnlLine)
//         else
//           ContinuePosting(GenJnlLine);

//         ReadGLSetup(GLSetup);

//         Memb.Get(DtldMembLedgEntry."Customer No.");
//         Memb.CheckBlockedMembOnJnls(Memb,GenJnlLine2."document type"::Payment,true);
//         MembPostingGr.Get(GenJnlLine."Posting Group");
//         MembPostingGr.GetReceivablesAccount;

//         VATEntry.LockTable;
//         DtldMembLedgEntry.LockTable;
//         MembLedgEntry.LockTable;

//         DtldMembLedgEntry.TestField("Entry Type",DtldMembLedgEntry."entry type"::Application);

//         DtldMembLedgEntry2.Reset;
//         DtldMembLedgEntry2.FindLast;
//         NextDtldLedgEntryNo := DtldMembLedgEntry2."Entry No." + 1;
//         if DtldMembLedgEntry."Transaction No." = 0 then begin
//           DtldMembLedgEntry2.SetCurrentkey("Application No.","Customer No.","Entry Type");
//           DtldMembLedgEntry2.SetRange("Application No.",DtldMembLedgEntry."Application No.");
//         end else begin
//           DtldMembLedgEntry2.SetCurrentkey("Transaction No.","Customer No.","Entry Type");
//           DtldMembLedgEntry2.SetRange("Transaction No.",DtldMembLedgEntry."Transaction No.");
//         end;
//         DtldMembLedgEntry2.SetRange("Customer No.",DtldMembLedgEntry."Customer No.");
//         DtldMembLedgEntry2.SetFilter("Entry Type",'>%1',DtldMembLedgEntry."entry type"::"Initial Entry");
//         if DtldMembLedgEntry."Transaction No." <> 0 then begin
//           UnapplyVATEntries := false;
//           DtldMembLedgEntry2.FindSet;
//           repeat
//             DtldMembLedgEntry2.TestField(Unapplied,false);
//             if IsVATAdjustment(DtldMembLedgEntry2."Entry Type") then
//               UnapplyVATEntries := true
//           until DtldMembLedgEntry2.Next = 0;

//           PostUnapply(
//             GenJnlLine,VATEntry,VATEntry.Type::Sale,
//             DtldMembLedgEntry."Customer No.",DtldMembLedgEntry."Transaction No.",UnapplyVATEntries,TempVATEntry);

//           DtldMembLedgEntry2.FindSet;
//           repeat
//             DtldCVLedgEntryBuf.Init;
//             DtldCVLedgEntryBuf.TransferFields(DtldMembLedgEntry2);
//             ProcessTempVATEntry(DtldCVLedgEntryBuf,TempVATEntry);
//             DtldCVLedgEntryBuf.CopyPostingGroupsFromVATEntry(TempVATEntry);
//           until DtldMembLedgEntry2.Next = 0;
//         end;

//         // Look one more time
//         DtldMembLedgEntry2.FindSet;
//         TempInvPostBuf.DeleteAll;
//         repeat
//           DtldMembLedgEntry2.TestField(Unapplied,false);
//           DimMgt.UpdateGenJnlLineDimFromMembLedgEntry(GenJnlLine,DtldMembLedgEntry2);
//           InsertDtldMembLedgEntryUnapply(GenJnlLine,NewDtldMembLedgEntry,DtldMembLedgEntry2,NextDtldLedgEntryNo);

//           DtldCVLedgEntryBuf.TransferFields(NewDtldMembLedgEntry);
//           SetAddCurrForUnapplication(DtldCVLedgEntryBuf);
//           CurrencyLCY.InitRoundingPrecision;

//           if (DtldMembLedgEntry2."Transaction No." <> 0) and IsVATExcluded(DtldMembLedgEntry2."Entry Type") then begin
//             TempVATEntry2.SetRange("VAT Bus. Posting Group",DtldMembLedgEntry2."VAT Bus. Posting Group");
//             TempVATEntry2.SetRange("VAT Prod. Posting Group",DtldMembLedgEntry2."VAT Prod. Posting Group");
//             TempVATEntry2.SetRange("Gen. Prod. Posting Group",DtldMembLedgEntry2."Gen. Prod. Posting Group");
//             if not TempVATEntry2.FindFirst then begin
//               TempVATEntry2.Reset;
//               if TempVATEntry2.FindLast then
//                 TempVATEntry2."Entry No." := TempVATEntry2."Entry No." + 1
//               else
//                 TempVATEntry2."Entry No." := 1;
//               TempVATEntry2.Init;
//               TempVATEntry2."VAT Bus. Posting Group" := DtldMembLedgEntry2."VAT Bus. Posting Group";
//               TempVATEntry2."VAT Prod. Posting Group" := DtldMembLedgEntry2."VAT Prod. Posting Group";
//               TempVATEntry2."Gen. Prod. Posting Group" := DtldMembLedgEntry2."Gen. Prod. Posting Group";
//               VATEntry.SetCurrentkey("Transaction No.");
//               VATEntry.SetRange("Transaction No.",DtldMembLedgEntry2."Transaction No.");
//               VATEntry.SetRange("VAT Bus. Posting Group",DtldMembLedgEntry2."VAT Bus. Posting Group");
//               VATEntry.SetRange("VAT Prod. Posting Group",DtldMembLedgEntry2."VAT Prod. Posting Group");
//               VATEntry.SetRange("Gen. Prod. Posting Group",DtldMembLedgEntry2."Gen. Prod. Posting Group");
//               if VATEntry.FindSet then
//                 repeat
//                   if VATEntry."Unrealized VAT Entry No." = 0 then begin
//                     TempVATEntry2.Base := TempVATEntry2.Base + VATEntry.Base;
//                     TempVATEntry2.Amount := TempVATEntry2.Amount + VATEntry.Amount;
//                   end;
//                 until VATEntry.Next = 0;
//               Clear(VATEntry);
//               TempVATEntry2.Insert;
//             end;
//             DtldCVLedgEntryBuf."VAT Amount (LCY)" :=
//               CalcVATAmountFromVATEntry(DtldCVLedgEntryBuf."Amount (LCY)",TempVATEntry2,CurrencyLCY);
//           end;
//           UpdateTotalAmounts(
//             TempInvPostBuf,GenJnlLine."Dimension Set ID",DtldCVLedgEntryBuf."Amount (LCY)",
//             DtldCVLedgEntryBuf."Additional-Currency Amount");

//           if not (DtldCVLedgEntryBuf."Entry Type" in [
//                                                       DtldCVLedgEntryBuf."entry type"::"Initial Entry",
//                                                       DtldCVLedgEntryBuf."entry type"::Application])
//           then
//             CollectAdjustment(AdjAmount,
//               -DtldCVLedgEntryBuf."Amount (LCY)",-DtldCVLedgEntryBuf."Additional-Currency Amount");

//           PostDtldMembLedgEntryUnapply(
//             GenJnlLine,DtldCVLedgEntryBuf,MembPostingGr,DtldMembLedgEntry2."Transaction No.");

//           DtldMembLedgEntry2.Unapplied := true;
//           DtldMembLedgEntry2."Unapplied by Entry No." := NewDtldMembLedgEntry."Entry No.";
//           DtldMembLedgEntry2.Modify;

//           UpdateMembLedgEntry(DtldMembLedgEntry2);
//         until DtldMembLedgEntry2.Next = 0;

//         CreateGLEntriesForTotalAmountsUnapply(GenJnlLine,TempInvPostBuf,MembPostingGr.GetReceivablesAccount);

//         if IsTempGLEntryBufEmpty then
//           DtldMembLedgEntry.SetZeroTransNo(NextTransactionNo);
//         CheckPostUnrealizedVAT(GenJnlLine,true);
//         FinishPosting;
//     end;

//     local procedure InsertDtldMembLedgEntryUnapply(GenJnlLine: Record "Gen. Journal Line";var NewDtldMembLedgEntry: Record "Detailed Cust. Ledg. Entry";OldDtldMembLedgEntry: Record "Detailed Cust. Ledg. Entry";var NextDtldLedgEntryNo: Integer)
//     begin
//         NewDtldMembLedgEntry := OldDtldMembLedgEntry;
//         with NewDtldMembLedgEntry do begin
//           "Entry No." := NextDtldLedgEntryNo;
//           "Posting Date" := GenJnlLine."Posting Date";
//           "Transaction No." := NextTransactionNo;
//           "Application No." := 0;
//           Amount := -OldDtldMembLedgEntry.Amount;
//           "Amount (LCY)" := -OldDtldMembLedgEntry."Amount (LCY)";
//           "Debit Amount" := -OldDtldMembLedgEntry."Debit Amount";
//           "Credit Amount" := -OldDtldMembLedgEntry."Credit Amount";
//           "Debit Amount (LCY)" := -OldDtldMembLedgEntry."Debit Amount (LCY)";
//           "Credit Amount (LCY)" := -OldDtldMembLedgEntry."Credit Amount (LCY)";
//           Unapplied := true;
//           "Unapplied by Entry No." := OldDtldMembLedgEntry."Entry No.";
//           "Document No." := GenJnlLine."Document No.";
//           "Source Code" := GenJnlLine."Source Code";
//           "User ID" := UserId;
//           Insert(true);
//         end;
//         NextDtldLedgEntryNo := NextDtldLedgEntryNo + 1;
//     end;

//     local procedure UpdateMembLedgEntry(DtldMembLedgEntry: Record "Detailed Cust. Ledg. Entry")
//     var
//         MembLedgEntry: Record "Member Ledger Entry";
//     begin
//         if DtldMembLedgEntry."Entry Type" <> DtldMembLedgEntry."entry type"::Application then
//           exit;

//         MembLedgEntry.Get(DtldMembLedgEntry."Cust. Ledger Entry No.");
//         MembLedgEntry."Remaining Pmt. Disc. Possible" := DtldMembLedgEntry."Remaining Pmt. Disc. Possible";
//         MembLedgEntry."Max. Payment Tolerance" := DtldMembLedgEntry."Max. Payment Tolerance";
//         MembLedgEntry."Accepted Payment Tolerance" := 0;
//         if not MembLedgEntry.Open then begin
//           MembLedgEntry.Open := true;
//           MembLedgEntry."Closed by Entry No." := 0;
//           MembLedgEntry."Closed at Date" := 0D;
//           MembLedgEntry."Closed by Amount" := 0;
//           MembLedgEntry."Closed by Amount (LCY)" := 0;
//           MembLedgEntry."Closed by Currency Code" := '';
//           MembLedgEntry."Closed by Currency Amount" := 0;
//           MembLedgEntry."Pmt. Disc. Given (LCY)" := 0;
//           MembLedgEntry."Pmt. Tolerance (LCY)" := 0;
//           MembLedgEntry."Calculate Interest" := false;
//         end;
//         MembLedgEntry.Modify;
//     end;


//     procedure MemberPostApplyCustLedgEntry(var GenJnlLinePostApply: Record "Gen. Journal Line";var CustLedgEntryPostApply: Record "Member Ledger Entry")
//     var
//         CustLedgEntry: Record "Member Ledger Entry";
//         DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
//         DtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer" temporary;
//         CVLedgEntryBuf: Record "CV Ledger Entry Buffer";
//     begin
//         /*GenJnlLine := GenJnlLinePostApply;
//         GenJnlLine."Source Currency Code" := CustLedgEntryPostApply."Currency Code";
//         GenJnlLine."Applies-to ID" := CustLedgEntryPostApply."Applies-to ID";
//         CustLedgEntry.TRANSFERFIELDS(CustLedgEntryPostApply);
//         WITH GenJnlLine DO BEGIN
//           LedgEntryDim.SETRANGE("Table ID",DATABASE::"Cust. Ledger Entry");
//           LedgEntryDim.SETRANGE("Entry No.",CustLedgEntry."Entry No.");
//           TempJnlLineDim.RESET;
//           TempJnlLineDim.DELETEALL;
//           DimMgt.CopyLedgEntryDimToJnlLineDim(LedgEntryDim,TempJnlLineDim);

//           GenJnlCheckLine.RunCheck(GenJnlLine);

//           InitCodeUnit;

//           IF Cust."No." <> CustLedgEntry."Customer No." THEN
//             Cust.GET(CustLedgEntry."Customer No.");
//           Cust.CheckBlockedCustOnJnls(Cust,"Document Type",TRUE);

//           IF "Posting Group" = '' THEN BEGIN
//             Cust.TESTFIELD("Customer Posting Group");
//             "Posting Group" := Cust."Customer Posting Group";
//           END;
//           CustPostingGr.GET("Posting Group");
//           CustPostingGr.TESTFIELD("Receivables Account");

//           DtldCustLedgEntry.LOCKTABLE;
//           CustLedgEntry.LOCKTABLE;

//           // Post the application
//           CustLedgEntry.CALCFIELDS(
//             Amount,"Amount (LCY)","Remaining Amount","Remaining Amt. (LCY)",
//             "Original Amount","Original Amt. (LCY)");
//           "TransferCustLedgEntry-Church"(CVLedgEntryBuf,CustLedgEntry,TRUE);
//           ApplyCustLedgEntry(
//             CVLedgEntryBuf,DtldCVLedgEntryBuf,GenJnlLine,GLSetup."Appln. Rounding Precision");
//           "TransferCustLedgEntry-Church"(CVLedgEntryBuf,CustLedgEntry,FALSE);
//           CustLedgEntry.MODIFY;

//           // Post the Dtld customer entry
//           PostDtldCustLedgEntries(
//             GenJnlLine,DtldCVLedgEntryBuf,CustPostingGr,GLSetup,NextTransactionNo,FALSE);
//           FinishCodeunit;
//         END;
//         */

//     end;


//     procedure CalculateFirstLastAmount(UnRealizedVatType: Option " ",Percentage,First,Last,"First (Fully Paid)","Last (Fully Paid)","Cash Basis";RemainingUnrealizedAmount: Decimal;var TotalUnrealVATAmountLast: Decimal;var TotalUnrealVATAmountFirst: Decimal)
//     begin
//         if UnRealizedVatType in
//            [Unrealizedvattype::Last,Unrealizedvattype::"Last (Fully Paid)"]
//         then
//           TotalUnrealVATAmountLast := TotalUnrealVATAmountLast - RemainingUnrealizedAmount;
//         if UnRealizedVatType in
//           [Unrealizedvattype::First,Unrealizedvattype::"First (Fully Paid)"]
//         then
//           TotalUnrealVATAmountFirst := TotalUnrealVATAmountFirst - RemainingUnrealizedAmount;
//     end;
// }