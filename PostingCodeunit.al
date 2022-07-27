codeunit 50130 PostingCodeunit
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforePostGenJnlLine', '', false, false)]
    procedure PostGenJournalLine(var GenJournalLine: Record "Gen. Journal Line"; Balancing: Boolean)
    begin
        case GenJournalLine."Account Type" of
            GenJournalLine."Account Type"::Member:
                begin
                    //Message('arrive2 %1', "Account Type");

                    PostMemb(GenJournalLine, Balancing);
                end;

        end;

    end;

    procedure PostMemb(var GenJournalLine: Record "Gen. Journal Line"; Balancing: Boolean)
    var
        LineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist.";
        Memb: Record "Members Register";
        MembPostingGr: Record "Customer Posting Group";
        MembLedgEntry: Record "Member Ledger Entry";
        CVLedgEntryBuf: Record "CV Ledger Entry Buffer";
        TempDtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer" temporary;
        DtldMembLedgEntry: Record "Detailed Cust. Ledg. Entry";
        ReceivablesAccount: Code[20];
        DtldLedgEntryInserted: Boolean;
        Cu12: Codeunit "Gen. Jnl.-Post Line";
        Found: Boolean;
    begin

        if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Registration Fee") then begin
            MembPostingGr.TestField(MembPostingGr."Registration Fees Account");
            MembPostingGr."Receivables Account" := MembPostingGr."Registration Fees Account";
            Found := true;
            InitMembLedgEntry(GenJournalLine, MembLedgEntry);

            if MembPostingGr."Receivables Account" = '' then
                Error('Member posting group must have value');
            PostlineCU.CreateGLEntryBalAcc(
                      GenJournalLine, MembPostingGr."Receivables Account", GenJournalLine."Amount (LCY)", GenJournalLine."Source Currency Amount",
                      GenJournalLine."Bal. Account Type", GenJournalLine."Bal. Account No.");
        end;

    end;

    procedure InitMembLedgEntry(GenJournalLine: Record "Gen. Journal Line"; var MembLedgEntry: Record "Member Ledger Entry")
    begin
        MembLedgEntry.Reset();
        if MembLedgEntry.Find('+') then begin
            NextEntryNo := MembLedgEntry."Entry No." + 1;

        end else
            NextEntryNo := 1;
        MembLedgEntry.Init;
        MembLedgEntry.CopyFromGenJnlLine(GenJournalLine);
        if MembLedgEntry."Credit Amount" <> 0 then
            MembLedgEntry.Amount := MembLedgEntry."Credit Amount" else
            MembLedgEntry.Amount := MembLedgEntry."Debit Amount";
        MembLedgEntry."Entry No." := NextEntryNo;
        MembLedgEntry."Transaction No." := NextTransactionNo;
        MembLedgEntry.Insert(true);




        //Message('here %1-  d amount %2  credit - %3 - docuent no %4', MembLedgEntry."Customer No.", MembLedgEntry."Debit Amount", MembLedgEntry."Credit Amount", MembLedgEntry."Document No.");
    end;


    var
        PostlineCU: Codeunit "Gen. Jnl.-Post Line";
        cust: Record "Members Register";
        TransferCustomFields: Codeunit "Transfer Custom Fields";
        UnrealizedRemainingAmountInvestor: Decimal;
        CheckUnrealizedMemb: Boolean;
        UnrealizedMembLedgEntry: Record "Member Ledger Entry";
        UnrealizedRemainingAmountMemb: Decimal;
        Found: Boolean;
        TempGLEntryBuf: Record "G/L Entry" temporary;
        DtldLedgEntryInserted: Boolean;
        LoanTypes: Record "Loan Products Setup";
        LoanApp: Record "Loans Register";
        PCharges: Record "Loan Product Charges";
        GenJournalLine: Record "Gen. Journal Line";
        ComputerName: Codeunit "SURESTEP Factory";
        NextEntryNo: Integer;
        NextVATEntryNo: Integer;
        FirstNewVATEntryNo: Integer;
        GLEnty: Record "G/L Entry";
        FirstTransactionNo: Integer;
        NextTransactionNo: Integer;
        NextConnectionNo: Integer;
        NextCheckEntryNo: Integer;
        InsertedTempGLEntryVAT: Integer;
        GLEntryNo: Integer;
}

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforePostGenJnlLine', '', false, false)]
//     procedure PostGenJournalLine(var GenJournalLine: Record "Gen. Journal Line"; Balancing: Boolean)
//     begin

//         // Message('arrive %1', GenJournalLine);
//         with GenJournalLine do

//             case "Account Type" of
//                 "Account Type"::Member:
//                     begin
//                         //Message('arrive2 %1', "Account Type");
//                         OnBeforePostingCommit5(GenJournalLine);
//                         PostMemb(GenJournalLine, Balancing);
//                     end;

//             end;
//     end;



//     procedure PostMemb(var GenJournalLine: Record "Gen. Journal Line"; Balancing: Boolean)
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
//         Cu12: Codeunit "Gen. Jnl.-Post Line";
//     begin
//         // Message('arrive');
//         OnBeforePostingCommit5(GenJournalLine);
//         with GenJournalLine do begin
//             Memb.Get("Account No.");
//             Memb.CheckBlockedMembOnJnls(Memb, "Document Type", true);

//             if "Posting Group" = '' then begin
//                 Memb.TestField("Customer Posting Group");
//                 "Posting Group" := Memb."Customer Posting Group";
//             end;
//             MembPostingGr.Get("Posting Group");


//             Found := false;

//             if GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::" " then begin
//                 Message('A Transaction Line is missing Transaction Type Value');
//                 Found := true;
//                 MembPostingGr.TestField("Receivables Account");
//             end;


//             if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Registration Fee") then begin
//                 MembPostingGr.TestField(MembPostingGr."Registration Fees Account");
//                 MembPostingGr."Receivables Account" := MembPostingGr."Registration Fees Account";
//                 Found := true;

//             end;

//             if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Deposit Contribution") then begin
//                 MembPostingGr.TestField(MembPostingGr."Shares Deposits Account");
//                 MembPostingGr."Receivables Account" := MembPostingGr."Shares Deposits Account";
//                 Found := true;

//             end;

//             if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Share Capital") then begin
//                 MembPostingGr.TestField(MembPostingGr."Shares Capital Account");
//                 MembPostingGr."Receivables Account" := MembPostingGr."Shares Capital Account";
//                 Found := true;
//                 //Message('arrive account type %1-%2', MembPostingGr."Shares Capital Account", GenJournalLine."Transaction Type");
//             end;


//             if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::Dividend) then begin
//                 MembPostingGr.TestField(MembPostingGr."Dividend Account");
//                 MembPostingGr."Receivables Account" := MembPostingGr."Dividend Account";
//                 Found := true;
//             end;

//             if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Recovery Account") then begin
//                 MembPostingGr.TestField(MembPostingGr."Recovery Account");
//                 MembPostingGr."Receivables Account" := MembPostingGr."Recovery Account";
//                 Found := true;
//             end;

//             if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"FOSA Shares") then begin
//                 MembPostingGr.TestField(MembPostingGr."FOSA Shares");
//                 MembPostingGr."Receivables Account" := MembPostingGr."FOSA Shares";
//                 Found := true;
//             end;

//             if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Additional Shares") then begin
//                 MembPostingGr.TestField(MembPostingGr."Additional Shares");
//                 MembPostingGr."Receivables Account" := MembPostingGr."Additional Shares";
//                 Found := true;
//             end;

//             if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Unallocated Funds") then begin
//                 MembPostingGr.TestField(MembPostingGr."Un-allocated Funds Account");
//                 MembPostingGr."Receivables Account" := MembPostingGr."Un-allocated Funds Account";
//                 Found := true;
//             end;

//             if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Insurance Contribution") then begin
//                 MembPostingGr.TestField(MembPostingGr."Insurance Fund Account");
//                 MembPostingGr."Receivables Account" := MembPostingGr."Insurance Fund Account";
//                 Found := true;
//             end;

//             if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Benevolent Fund") then begin
//                 MembPostingGr.TestField(MembPostingGr."Benevolent Fund Account");
//                 MembPostingGr."Receivables Account" := MembPostingGr."Benevolent Fund Account";
//                 Found := true;
//             end;

//             if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Junior Savings") then begin
//                 MembPostingGr.TestField(MembPostingGr."Junior Savings Account");
//                 MembPostingGr."Receivables Account" := MembPostingGr."Junior Savings Account";
//                 Found := true;
//             end;

//             if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Safari Savings") then begin
//                 MembPostingGr.TestField(MembPostingGr."Safari Savings Account");
//                 MembPostingGr."Receivables Account" := MembPostingGr."Safari Savings Account";
//                 Found := true;
//             end;

//             if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Silver Savings") then begin
//                 MembPostingGr.TestField(MembPostingGr."Silver Savings Account");
//                 MembPostingGr."Receivables Account" := MembPostingGr."Silver Savings Account";
//                 Found := true;
//             end;

//             if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Loan Repayment") then begin
//                 if GenJournalLine."Loan No" = '' then
//                     Error('Loan No must be specified for Loan, Repayment or Interest transactions');

//                 LoanApp.Reset;
//                 LoanApp.SetCurrentkey(LoanApp."Loan  No.");
//                 LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
//                 if LoanApp.Find('-') then begin
//                     if LoanTypes.Get(LoanApp."Loan Product Type") then begin
//                         LoanTypes.TestField(LoanTypes."Loan Account");
//                         MembPostingGr."Receivables Account" := LoanTypes."Loan Account";
//                         Found := true;
//                     end;
//                 end;
//             end;


//             if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Interest Due") then begin
//                 if GenJournalLine."Loan No" = '' then
//                     Error('Loan No must be specified for Loan, Repayment,Loan Insurance or Interest transactions :- %1', GenJournalLine."Account No.");

//                 LoanApp.Reset;
//                 LoanApp.SetCurrentkey(LoanApp."Loan  No.");
//                 LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
//                 if LoanApp.Find('-') then begin
//                     if LoanTypes.Get(LoanApp."Loan Product Type") then begin
//                         LoanTypes.TestField(LoanTypes."Loan Interest Account");
//                         MembPostingGr."Receivables Account" := LoanTypes."Receivable Interest Account";
//                         Found := true;
//                     end;
//                 end;
//             end;

//             if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Interest Paid") then begin
//                 if GenJournalLine."Loan No" = '' then
//                     Error('Loan No must be specified for Loan, Repayment or Interest transactions :- %1', GenJournalLine."Account No.");

//                 LoanApp.Reset;
//                 LoanApp.SetCurrentkey(LoanApp."Loan  No.");
//                 LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
//                 if LoanApp.Find('-') then begin
//                     if LoanTypes.Get(LoanApp."Loan Product Type") then begin
//                         LoanTypes.TestField(LoanTypes."Receivable Interest Account");
//                         MembPostingGr."Receivables Account" := LoanTypes."Loan Interest Account";
//                         Found := true;
//                     end;
//                 end;
//             end;

//             if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::Loan) then begin
//                 if GenJournalLine."Loan No" = '' then
//                     Error('Loan No must be specified for Loan, Repayment or Interest transactions :- %1', GenJournalLine."Account No.");

//                 LoanApp.Reset;
//                 LoanApp.SetCurrentkey(LoanApp."Loan  No.");
//                 LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
//                 if LoanApp.Find('-') then begin
//                     if LoanTypes.Get(LoanApp."Loan Product Type") then begin
//                         LoanTypes.TestField(LoanTypes."Loan Account");
//                         MembPostingGr."Receivables Account" := LoanTypes."Loan Account";
//                         Found := true;
//                     end;
//                 end;

//             end;

//             if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Loan Insurance Charged") then begin
//                 if GenJournalLine."Loan No" = '' then
//                     Error('Loan No must be specified for Loan, Repayment,Loan Insurance or Interest transactions :- %1', GenJournalLine."Account No.");

//                 LoanApp.Reset;
//                 LoanApp.SetCurrentkey(LoanApp."Loan  No.");
//                 LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
//                 if LoanApp.Find('-') then begin
//                     if LoanTypes.Get(LoanApp."Loan Product Type") then begin
//                         LoanTypes.TestField(LoanTypes."Loan Insurance Accounts");
//                         MembPostingGr."Receivables Account" := LoanTypes."Receivable Insurance Accounts";
//                         Found := true;
//                     end;
//                 end;

//             end;

//             if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Loan Insurance Paid") then begin
//                 if GenJournalLine."Loan No" = '' then
//                     Error('Loan No must be specified for Loan, Repayment,Loan Insurance or Interest transactions :- %1', GenJournalLine."Account No.");

//                 LoanApp.Reset;
//                 LoanApp.SetCurrentkey(LoanApp."Loan  No.");
//                 LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
//                 if LoanApp.Find('-') then begin
//                     if LoanTypes.Get(LoanApp."Loan Product Type") then begin
//                         LoanTypes.TestField(LoanTypes."Loan Insurance Accounts");
//                         MembPostingGr."Receivables Account" := LoanTypes."Receivable Insurance Accounts";
//                         Found := true;
//                     end;
//                 end;

//             end;



//             if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Loan Penalty Charged") then begin
//                 if GenJournalLine."Loan No" = '' then
//                     Error('Loan No must be specified for Loan, Repayment,Loan Insurance or Interest transactions :- %1', GenJournalLine."Account No.");

//                 LoanApp.Reset;
//                 LoanApp.SetCurrentkey(LoanApp."Loan  No.");
//                 LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
//                 if LoanApp.Find('-') then begin
//                     if LoanTypes.Get(LoanApp."Loan Product Type") then begin
//                         LoanTypes.TestField(LoanTypes."Penalty Paid Account");
//                         MembPostingGr."Receivables Account" := LoanTypes."Penalty Charged Account";
//                         Found := true;
//                     end;
//                 end;

//             end;

//             if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Loan Penalty Paid") then begin
//                 if GenJournalLine."Loan No" = '' then
//                     Error('Loan No must be specified for Loan, Repayment,Loan Insurance or Interest transactions :- %1', GenJournalLine."Account No.");

//                 LoanApp.Reset;
//                 LoanApp.SetCurrentkey(LoanApp."Loan  No.");
//                 LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
//                 if LoanApp.Find('-') then begin
//                     if LoanTypes.Get(LoanApp."Loan Product Type") then begin
//                         LoanTypes.TestField(LoanTypes."Penalty Charged Account");
//                         MembPostingGr."Receivables Account" := LoanTypes."Penalty Charged Account";
//                         Found := true;
//                     end;
//                 end;

//             end;


//             if Found = false then begin
//                 if GenJournalLine."Transaction Type" <> GenJournalLine."transaction type"::" " then
//                     Error('Transaction Type blocked. %1', GenJournalLine."Account No.");
//             end;






//             // ReceivablesAccount :=MembPostingGr.GetReceivablesAccount;

//             //DtldMembLedgEntry.LOCKTABLE;
//             MembLedgEntry.LockTable;

//             InitMembLedgEntry(GenJournalLine, MembLedgEntry);
//             TransferCustomFields.GenJnlLineTOMembLedgEntry(GenJournalLine, MembLedgEntry);

//             /*
//             IF NOT Memb."Block Payment Tolerance" THEN
//               CalcPmtTolerancePossible(
//                 GenJournalLine,MembLedgEntry."Pmt. Discount Date",MembLedgEntry."Pmt. Disc. Tolerance Date",
//                 MembLedgEntry."Max. Payment Tolerance");
//           */
//             TempDtldCVLedgEntryBuf.DeleteAll;
//             TempDtldCVLedgEntryBuf.Init;
//             TempDtldCVLedgEntryBuf.CopyFromGenJnlLine(GenJournalLine);
//             TempDtldCVLedgEntryBuf."CV Ledger Entry No." := MembLedgEntry."Entry No.";
//             CVLedgEntryBuf.CopyFromMemberLedgEntry(MembLedgEntry);
//             TempDtldCVLedgEntryBuf.InsertDtldCVLedgEntry(TempDtldCVLedgEntryBuf, CVLedgEntryBuf, true);
//             CVLedgEntryBuf.Open := CVLedgEntryBuf."Remaining Amount" <> 0;
//             CVLedgEntryBuf.Positive := CVLedgEntryBuf."Remaining Amount" > 0;

//             // CalcPmtDiscPossible(GenJournalLine,CVLedgEntryBuf);

//             if "Currency Code" <> '' then begin
//                 TestField("Currency Factor");
//                 CVLedgEntryBuf."Original Currency Factor" := "Currency Factor"
//             end else
//                 CVLedgEntryBuf."Original Currency Factor" := 1;
//             CVLedgEntryBuf."Adjusted Currency Factor" := CVLedgEntryBuf."Original Currency Factor";

//             // Check the document no.
//             // if "Recurring Method" = 0 then
//             //     if IsNotPayment("Document Type") then begin
//             //         GenJnlCheckLine.CheckSalesDocNoIsNotUsed("Document Type", "Document No.");
//             //         CheckSalesExtDocNo(GenJournalLine);
//             //     end;

//             // Post application
//             //ApplyMembLedgEntry(CVLedgEntryBuf, TempDtldCVLedgEntryBuf, GenJournalLine, Memb);

//             // Post Member entry
//             CVLedgEntryBuf.CopyFromMemberLedgEntry(MembLedgEntry);
//             MembLedgEntry."Amount to Apply" := 0;
//             MembLedgEntry."Applies-to Doc. No." := '';

//             //Daudi-Pass entries related to loan

//             /*MembLedgEntry."Transaction Type" := "Transaction Type";
//             MembLedgEntry."Loan No" := "Loan No";
//             MembLedgEntry."Prepayment Date" := GenJournalLine."Prepayment date";
//             MembLedgEntry."Recovery Transaction Type" := GenJournalLine."Recovery Transaction Type";
//             MembLedgEntry."Recoverd Loan" := GenJournalLine."Recoverd Loan";
//             MembLedgEntry."Group Code" := "Group Code";
//             MembLedgEntry."Debit Amount" := "Debit Amount";
//             MembLedgEntry."Credit Amount" := "Credit Amount";
//             MembLedgEntry."Amount (LCY)" := "Amount (LCY)";
//             MembLedgEntry.Amount := Amount;
//             MembLedgEntry."Loan No" := "Loan No";
//             MembLedgEntry."Group Account No" := "Group Account No";
//             MembLedgEntry."Transaction Date" := WorkDate;//Addon insert Actual Transaction Date
//             MembLedgEntry."Created On" := CurrentDatetime;
//             MembLedgEntry."Application Source" := "Application Source";
//             MembLedgEntry."Computer Name" := ComputerName.FnGetComputerName();
//             MembLedgEntry.UpdateDebitCredit(Correction);
//             MembLedgEntry.Insert(true);*/
//             //OnAfterInsertMemberLedgerEntries(MembLedgEntry, MembPostingGr."Receivables Account", Amount);

//             // Message('receivable %1- amountlcy %2 - balancing accout type %3 - balancing acount no %4', MembPostingGr."Receivables Account", "Amount (LCY)", "Bal. Account Type", "Bal. Account No.");
//             Cu12.CreateGLEntryBalAcc(GenJournalLine, MembPostingGr."Receivables Account", "Amount (LCY)", "Source Currency Amount",
//              "Bal. Account Type", "Bal. Account No.");
//             //Cu12.InsertGLEntry(GenJournalLine, GLEnty, true);
//             // if MembPostingGr.Get("Account No.") = true then begin
//             // GLEnty.Init();
//             // GLEnty."Posting Date" := GenJournalLine."Posting Date";
//             // GLEnty."Document Date" := GenJournalLine."Document Date";
//             // GLEnty."Document Type" := GenJournalLine."Document Type";
//             // GLEnty."Document No." := GenJournalLine."Document No.";
//             // GLEnty."External Document No." := GenJournalLine."External Document No.";
//             // GLEnty.Description := GenJournalLine.Description;
//             // GLEnty.Comment := GenJournalLine.Comment;
//             // GLEnty."Business Unit Code" := GenJournalLine."Business Unit Code";
//             // GLEnty."Global Dimension 1 Code" := GenJournalLine."Shortcut Dimension 1 Code";
//             // GLEnty."Global Dimension 2 Code" := GenJournalLine."Shortcut Dimension 2 Code";
//             // GLEnty."Dimension Set ID" := GenJournalLine."Dimension Set ID";
//             // GLEnty."Source Code" := GenJournalLine."Source Code";
//             // if GenJournalLine."Account Type" = GenJournalLine."Account Type"::"G/L Account" then begin
//             //     if GenJournalLine."Source Type" = GenJournalLine."Source Type"::Employee then
//             //         GLEnty."Source Type" := "Source Type"::Employee
//             //     else
//             //         GLEnty."Source Type" := GenJournalLine."Source Type";
//             //     GLEnty."Source No." := GenJournalLine."Source No.";
//             // end else begin
//             //     if GenJournalLine."Account Type" = GenJournalLine."Account Type"::Employee then
//             //         GLEnty."Source Type" := "Source Type"::Employee
//             //     else
//             //         GLEnty."Source Type" := GenJournalLine."Account Type";
//             //     GLEnty."Source No." := GenJournalLine."Account No.";
//             // end;
//             // if (GenJournalLine."Account Type" = GenJournalLine."Account Type"::"IC Partner") or
//             //    (GenJournalLine."Bal. Account Type" = GenJournalLine."Bal. Account Type"::"IC Partner")
//             // then
//             //     GLEnty."Source Type" := "Source Type"::" ";
//             // GLEnty."Job No." := GenJournalLine."Job No.";
//             // GLEnty.Quantity := GenJournalLine.Quantity;
//             // GLEnty."Journal Batch Name" := GenJournalLine."Journal Batch Name";
//             // GLEnty."Reason Code" := GenJournalLine."Reason Code";
//             // GLEnty."User ID" := UserId;
//             // GLEnty."No. Series" := GenJournalLine."Posting No. Series";
//             // GLEnty."IC Partner Code" := GenJournalLine."IC Partner Code";
//             // GLEnty."Prod. Order No." := GenJournalLine."Prod. Order No.";

//             // // OnAfterCopyGLEntryFromGenJnlLine(Rec, GenJnlLine);


//             // // GLEnty.CopyFromGenJnlLine(GenJournalLine);
//             // GLEnty."Entry No." := NextEntryNo;
//             // GLEnty."Transaction No." := NextTransactionNo;
//             // GLEnty."G/L Account No." := MembPostingGr."Receivables Account";
//             // GLEnty."System-Created Entry" := true;
//             // GLEnty.Amount := "Amount (LCY)";
//             // GLEnty."Bal. Account Type" := "Bal. Account Type";
//             // GLEnty."Bal. Account No." := "Bal. Account No.";
//             // if GLEnty.Amount <> 0 then begin
//             //     GLEnty.Insert(true);
//             //     Commit();
//             // end;
//             // Message('%1 - %2', GLEnty."G/L Account No.", GLEnty.Amount);



//             //createcustomGlEnty(GenJournalLine, MembPostingGr."Receivables Account", "Amount (LCY)", "Source Currency Amount", true);

//             //Cu12.RunWithCheck(GenJournalLine);
//             // CreateGLEntryBalAcc(
//             //   GenJournalLine, MembPostingGr."Receivables Account", "Amount (LCY)", "Source Currency Amount",
//             //   "Bal. Account Type", "Bal. Account No.");

//             // Post detailed Membmer entries
//             //DtldLedgEntryInserted := PostDtldMembLedgEntries(GenJournalLine, TempDtldCVLedgEntryBuf, MembPostingGr, TRUE);

//             // Post Reminder Terms - Note About Line Fee on Report
//             // LineFeeNoteOnReportHist.SaveMemb(MembLedgEntry);

//             /* IF DtldLedgEntryInserted THEN
//                  IF IsTempGLEntryBufEmpty THEN
//                      DtldMembLedgEntry.SetZeroTransNo(NextTransactionNo);

//                           UpdateDOPaymentTransactEntry(GenJournalLine,MembLedgEntry."Entry No.");
//                           DeferralPosting("Deferral Code","Source Code",ReceivablesAccount,GenJournalLine,Balancing);
//                           OnMoveGenJournalLine(MembLedgEntry.RECORDID);

//          end;*/

//         end;
//     end;

//     procedure IsTempGLEntryBufEmpty(): Boolean
//     begin
//         exit(TempGLEntryBuf.IsEmpty);
//     end;

//     procedure InitMembLedgEntry(GenJournalLine: Record "Gen. Journal Line"; var MembLedgEntry: Record "Member Ledger Entry")
//     begin
//         MembLedgEntry.Reset();
//         if MembLedgEntry.Find('+') then begin
//             NextEntryNo := MembLedgEntry."Entry No." + 1;

//         end else
//             NextEntryNo := 1;
//         MembLedgEntry.Init;
//         MembLedgEntry.CopyFromGenJnlLine(GenJournalLine);
//         if MembLedgEntry."Credit Amount" <> 0 then
//             MembLedgEntry.Amount := MembLedgEntry."Credit Amount" else
//             MembLedgEntry.Amount := MembLedgEntry."Debit Amount";
//         MembLedgEntry."Entry No." := NextEntryNo;
//         MembLedgEntry."Transaction No." := NextTransactionNo;
//         MembLedgEntry.Insert(true);

//         //Message('here %1-  d amount %2  credit - %3 - docuent no %4', MembLedgEntry."Customer No.", MembLedgEntry."Debit Amount", MembLedgEntry."Credit Amount", MembLedgEntry."Document No.");
//     end;

//     /* local procedure ApplyMembLedgEntry(var NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer"; var DtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer"; GenJournalLine: Record "Gen. Journal Line"; Memb: Record "Members Register")
//      var
//          OldMembLedgEntry: Record "Member Ledger Entry";
//          OldCVLedgEntryBuf: Record "CV Ledger Entry Buffer";
//          NewMembLedgEntry: Record "Member Ledger Entry";
//          NewCVLedgEntryBuf2: Record "CV Ledger Entry Buffer";
//          TempOldMembLedgEntry: Record "Member Ledger Entry" temporary;
//          Completed: Boolean;
//          AppliedAmount: Decimal;
//          NewRemainingAmtBeforeAppln: Decimal;
//          ApplyingDate: Date;
//          PmtTolAmtToBeApplied: Decimal;
//          AllApplied: Boolean;
//          VATRealizedGainLossLCY: Decimal;
//      begin
//          if NewCVLedgEntryBuf."Amount to Apply" = 0 then
//              exit;

//          AllApplied := true;
//          if (GenJournalLine."Applies-to Doc. No." = '') and (GenJournalLine."Applies-to ID" = '') and
//             not
//             ((Memb."Application Method" = Memb."application method"::"Apply to Oldest") and
//              GenJournalLine."Allow Application")
//          then
//              exit;

//          PmtTolAmtToBeApplied := 0;
//          NewRemainingAmtBeforeAppln := NewCVLedgEntryBuf."Remaining Amount";
//          NewCVLedgEntryBuf2 := NewCVLedgEntryBuf;

//          ApplyingDate := GenJournalLine."Posting Date";

//          //if not PrepareTempMembLedgEntry(GenJournalLine, NewCVLedgEntryBuf, TempOldMembLedgEntry, Memb, ApplyingDate) then
//             // exit;

//          GenJournalLine."Posting Date" := ApplyingDate;
//          // Apply the new entry (Payment) to the old entries (Invoices) one at a time
//          repeat
//              TempOldMembLedgEntry.CalcFields(
//                Amount, "Amount (LCY)", "Remaining Amount", "Remaining Amt. (LCY)",
//                "Original Amount", "Original Amt. (LCY)");
//              TempOldMembLedgEntry.Copyfilter(Positive, OldCVLedgEntryBuf.Positive);
//              //OldCVLedgEntryBuf.CopyFromMemberLedgEntry(TempOldMembLedgEntry);

//              // PostApply(
//              //   GenJournalLine, DtldCVLedgEntryBuf, OldCVLedgEntryBuf, NewCVLedgEntryBuf, NewCVLedgEntryBuf2,
//              //   Memb."Block Payment Tolerance", AllApplied, AppliedAmount, PmtTolAmtToBeApplied, VATRealizedGainLossLCY);

//              // if not OldCVLedgEntryBuf.Open then begin
//              //     UpdateCalcInterest(OldCVLedgEntryBuf);
//              //     UpdateCalcInterest2(OldCVLedgEntryBuf, NewCVLedgEntryBuf);
//              // end;

//              //  OldCVLedgEntryBuf.CopyFromMemberLedgEntry(TempOldMembLedgEntry);
//              OldMembLedgEntry := TempOldMembLedgEntry;
//              OldMembLedgEntry."Applies-to ID" := '';
//              OldMembLedgEntry."Amount to Apply" := 0;
//              OldMembLedgEntry.Modify;
//          until Completed;
//      END;*/
//     // if GLSetup."Unrealized VAT" or
//     //    (GLSetup."Prepayment Unrealized VAT" and TempOldMembLedgEntry.Prepayment)
//     // then
//     //     if IsNotPayment(TempOldMembLedgEntry."Document Type") then begin
//     /*       TempOldMembLedgEntry.RecalculateAmounts(
//              NewCVLedgEntryBuf."Currency Code", TempOldMembLedgEntry."Currency Code", NewCVLedgEntryBuf."Posting Date");
//            MembUnrealizedVAT(
//              GenJournalLine,
//              TempOldMembLedgEntry,
//              CurrExchRate.ExchangeAmount(
//                AppliedAmount, NewCVLedgEntryBuf."Currency Code",
//                TempOldMembLedgEntry."Currency Code", NewCVLedgEntryBuf."Posting Date"),
//              VATRealizedGainLossLCY, NewCVLedgEntryBuf."Adjusted Currency Factor", NewCVLedgEntryBuf."Posting Date");
//        end;

//    TempOldMembLedgEntry.Delete;

//    // Find the next old entry for application of the new entry
//    if GenJournalLine."Applies-to Doc. No." <> '' then
//        Completed := true
//    else
//        if TempOldMembLedgEntry.GetFilter(Positive) <> '' then
//            if TempOldMembLedgEntry.Next = 1 then
//                Completed := false
//            else begin
//                TempOldMembLedgEntry.SetRange(Positive);
//                TempOldMembLedgEntry.Find('-');
//                TempOldMembLedgEntry.CalcFields("Remaining Amount");
//                Completed := TempOldMembLedgEntry."Remaining Amount" * NewCVLedgEntryBuf."Remaining Amount" >= 0;
//            end
//        else
//            if NewCVLedgEntryBuf.Open then
//                Completed := TempOldMembLedgEntry.Next = 0
//            else
//                Completed := true;
// until Completed;

// DtldCVLedgEntryBuf.SetCurrentkey("CV Ledger Entry No.", "Entry Type");
// DtldCVLedgEntryBuf.SetRange("CV Ledger Entry No.", NewCVLedgEntryBuf."Entry No.");
// DtldCVLedgEntryBuf.SetRange(
//  "Entry Type",
//  DtldCVLedgEntryBuf."entry type"::Application);
// DtldCVLedgEntryBuf.CalcSums("Amount (LCY)", Amount);

// CalcCurrencyUnrealizedGainLoss(
//  NewCVLedgEntryBuf, DtldCVLedgEntryBuf, GenJournalLine, DtldCVLedgEntryBuf.Amount, NewRemainingAmtBeforeAppln);

// CalcAmtLCYAdjustment(NewCVLedgEntryBuf, DtldCVLedgEntryBuf, GenJournalLine);

// NewCVLedgEntryBuf."Applies-to ID" := '';
// NewCVLedgEntryBuf."Amount to Apply" := 0;

// if not NewCVLedgEntryBuf.Open then
//    UpdateCalcInterest(NewCVLedgEntryBuf);

// if GLSetup."Unrealized VAT" or
//   (GLSetup."Prepayment Unrealized VAT" and NewCVLedgEntryBuf.Prepayment)
// then
//    if IsNotPayment(NewCVLedgEntryBuf."Document Type") and
//       (NewRemainingAmtBeforeAppln - NewCVLedgEntryBuf."Remaining Amount" <> 0)
//    then begin
//        NewCVLedgEntryBuf.CopyFromMemberLedgEntry(NewMembLedgEntry);
//        CheckUnrealizedMemb := true;
//        UnrealizedMembLedgEntry := NewMembLedgEntry;
//        UnrealizedMembLedgEntry.CalcFields("Amount (LCY)", "Original Amt. (LCY)");
//        UnrealizedRemainingAmountMemb := NewMembLedgEntry."Remaining Amount" - NewRemainingAmtBeforeAppln;
//    end;
// end;

// local procedure PostDtldMembLedgEntries(GenJournalLine: Record "Gen. Journal Line"; var DtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer"; MembPostingGr: Record "Customer Posting Group"; LedgEntryInserted: Boolean) DtldLedgEntryInserted: Boolean
// var
// TempInvPostBuf: Record "Invoice Post. Buffer" temporary;
// DtldMembLedgEntry: Record "Detailed Cust. Ledg. Entry";
// DimMgt: Codeunit DimensionManagement;
// AdjAmount: array[4] of Decimal;
// DtldMembLedgEntryNoOffset: Integer;
// SaveEntryNo: Integer;
// begin
// if GenJournalLine."Account Type" <> GenJournalLine."account type"::Customer then
//    exit;

// if DtldMembLedgEntry.FindLast then
//    DtldMembLedgEntryNoOffset := DtldMembLedgEntry."Entry No."
// else
//    DtldMembLedgEntryNoOffset := 0;

// DtldCVLedgEntryBuf.Reset;
// if DtldCVLedgEntryBuf.FindSet then begin
//    if LedgEntryInserted then begin
//        SaveEntryNo := NextEntryNo;
//        NextEntryNo := NextEntryNo + 1;
//    end;
//    repeat
//        InsertDtldMembLedgEntry(GenJournalLine, DtldCVLedgEntryBuf, DtldMembLedgEntry, DtldMembLedgEntryNoOffset);

//        DimMgt.UpdateGenJournalLineDimFromMembLedgEntry(GenJournalLine, DtldMembLedgEntry);
//        UpdateTotalAmounts(
//          TempInvPostBuf, GenJournalLine."Dimension Set ID",
//          DtldCVLedgEntryBuf."Amount (LCY)", DtldCVLedgEntryBuf."Additional-Currency Amount");

//        // Post automatic entries.
//        if ((DtldCVLedgEntryBuf."Amount (LCY)" <> 0) or
//            (DtldCVLedgEntryBuf."VAT Amount (LCY)" <> 0)) or
//           ((AddCurrencyCode <> '') and (DtldCVLedgEntryBuf."Additional-Currency Amount" <> 0))
//        then
//            PostDtldMembLedgEntry(GenJournalLine, DtldCVLedgEntryBuf, MembPostingGr, AdjAmount);
//    until DtldCVLedgEntryBuf.Next = 0;
// end;

// // CreateGLEntriesForTotalAmounts(
// //   GenJournalLine, TempInvPostBuf, AdjAmount, SaveEntryNo, MembPostingGr.GetReceivablesAccount, LedgEntryInserted);

// DtldLedgEntryInserted := not DtldCVLedgEntryBuf.IsEmpty;
// DtldCVLedgEntryBuf.DeleteAll;
// end;

// local procedure PostDtldMembLedgEntry(GenJournalLine: Record "Gen. Journal Line"; DtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer"; MembPostingGr: Record "Customer Posting Group"; var AdjAmount: array[4] of Decimal)
// var
// AccNo: Code[20];
// begin
// AccNo := GetDtldMembLedgEntryAccNo(GenJournalLine, DtldCVLedgEntryBuf, MembPostingGr, 0, false);
// PostDtldCVLedgEntry(GenJournalLine, DtldCVLedgEntryBuf, AccNo, AdjAmount, false);
// end;*/

//     /*local procedure PrepareTempMembLedgEntry(GenJournalLine: Record "Gen. Journal Line"; var NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer"; var TempOldMembLedgEntry: Record "Member Ledger Entry" temporary; Memb: Record "Members Register"; var ApplyingDate: Date): Boolean
//     var
//         OldMembLedgEntry: Record "Member Ledger Entry";
//         SalesSetup: Record "Sales & Receivables Setup";
//         GenJnlApply: Codeunit "Gen. Jnl.-Apply";
//         RemainingAmount: Decimal;
//     begin
//         if GenJournalLine."Applies-to Doc. No." <> '' then begin
//             // Find the entry to be applied to
//             OldMembLedgEntry.Reset;
//             OldMembLedgEntry.SetCurrentkey("Document No.");
//             OldMembLedgEntry.SetRange("Document No.", GenJournalLine."Applies-to Doc. No.");
//             OldMembLedgEntry.SetRange("Document Type", GenJournalLine."Applies-to Doc. Type");
//             OldMembLedgEntry.SetRange("Customer No.", NewCVLedgEntryBuf."CV No.");
//             OldMembLedgEntry.SetRange(Open, true);

//             OldMembLedgEntry.FindFirst;
//             OldMembLedgEntry.TestField(Positive, not NewCVLedgEntryBuf.Positive);
//             if OldMembLedgEntry."Posting Date" > ApplyingDate then
//                 ApplyingDate := OldMembLedgEntry."Posting Date";
//             GenJnlApply.CheckAgainstApplnCurrency(
//               NewCVLedgEntryBuf."Currency Code", OldMembLedgEntry."Currency Code", GenJournalLine."account type"::Customer, true);
//             TempOldMembLedgEntry := OldMembLedgEntry;
//             TempOldMembLedgEntry.Insert;
//         end else begin
//             // Find the first old entry (Invoice) which the new entry (Payment) should apply to
//             OldMembLedgEntry.Reset;
//             OldMembLedgEntry.SetCurrentkey("Customer No.", "Applies-to ID", Open, Positive, "Due Date");
//             TempOldMembLedgEntry.SetCurrentkey("Customer No.", "Applies-to ID", Open, Positive, "Due Date");
//             OldMembLedgEntry.SetRange("Customer No.", NewCVLedgEntryBuf."CV No.");
//             OldMembLedgEntry.SetRange("Applies-to ID", GenJournalLine."Applies-to ID");
//             OldMembLedgEntry.SetRange(Open, true);
//             OldMembLedgEntry.SetFilter("Entry No.", '<>%1', NewCVLedgEntryBuf."Entry No.");
//             //   if not (Memb."Application Method" = Memb."application method"::"Apply to Oldest") then
//             //     OldMembLedgEntry.SetFilter("Amount to Apply",'<>%1',0);

//             //   if Memb."Application Method" = Memb."application method"::"Apply to Oldest" then
//             //     OldMembLedgEntry.SetFilter("Posting Date",'..%1',GenJournalLine."Posting Date");

//             // Check Cust Ledger Entry and add to Temp.
//             SalesSetup.Get;
//             if SalesSetup."Appln. between Currencies" = SalesSetup."appln. between currencies"::None then
//                 OldMembLedgEntry.SetRange("Currency Code", NewCVLedgEntryBuf."Currency Code");
//             if OldMembLedgEntry.FindSet(false, false) then
//                 repeat
//                     if GenJnlApply.CheckAgainstApplnCurrency(
//                          NewCVLedgEntryBuf."Currency Code", OldMembLedgEntry."Currency Code", GenJournalLine."account type"::Customer, false)
//                     then begin
//                         if (OldMembLedgEntry."Posting Date" > ApplyingDate) and (OldMembLedgEntry."Applies-to ID" <> '') then
//                             ApplyingDate := OldMembLedgEntry."Posting Date";
//                         TempOldMembLedgEntry := OldMembLedgEntry;
//                         TempOldMembLedgEntry.Insert;
//                     end;
//                 until OldMembLedgEntry.Next = 0;

//             TempOldMembLedgEntry.SetRange(Positive, NewCVLedgEntryBuf."Remaining Amount" > 0);

//             if TempOldMembLedgEntry.Find('-') then begin
//                 RemainingAmount := NewCVLedgEntryBuf."Remaining Amount";
//                 TempOldMembLedgEntry.SetRange(Positive);
//                 TempOldMembLedgEntry.Find('-');
//                 repeat
//                     TempOldMembLedgEntry.CalcFields("Remaining Amount");
//                     TempOldMembLedgEntry.RecalculateAmounts(
//                       TempOldMembLedgEntry."Currency Code", NewCVLedgEntryBuf."Currency Code", NewCVLedgEntryBuf."Posting Date");
//                 // if PaymentToleranceMgt.CheckCalcPmtDiscCVMemb(NewCVLedgEntryBuf, TempOldMembLedgEntry, 0, false, false) then
//                 //     TempOldMembLedgEntry."Remaining Amount" -= TempOldMembLedgEntry."Remaining Pmt. Disc. Possible";
//                 // RemainingAmount += TempOldMembLedgEntry."Remaining Amount";
//                 until TempOldMembLedgEntry.Next = 0;
//                 TempOldMembLedgEntry.SetRange(Positive, RemainingAmount < 0);
//             end else
//                 TempOldMembLedgEntry.SetRange(Positive);

//             exit(TempOldMembLedgEntry.Find('-'));
//         end;
//         exit(true);
//     end;*/


//     var
//         cust: Record "Members Register";
//         TransferCustomFields: Codeunit "Transfer Custom Fields";
//         UnrealizedRemainingAmountInvestor: Decimal;
//         CheckUnrealizedMemb: Boolean;
//         UnrealizedMembLedgEntry: Record "Member Ledger Entry";
//         UnrealizedRemainingAmountMemb: Decimal;
//         Found: Boolean;
//         TempGLEntryBuf: Record "G/L Entry" temporary;
//         DtldLedgEntryInserted: Boolean;
//         LoanTypes: Record "Loan Products Setup";
//         LoanApp: Record "Loans Register";
//         PCharges: Record "Loan Product Charges";
//         GenJournalLine: Record "Gen. Journal Line";
//         ComputerName: Codeunit "SURESTEP Factory";
//         NextEntryNo: Integer;
//         NextVATEntryNo: Integer;
//         FirstNewVATEntryNo: Integer;
//         GLEnty: Record "G/L Entry";
//         FirstTransactionNo: Integer;
//         NextTransactionNo: Integer;
//         NextConnectionNo: Integer;
//         NextCheckEntryNo: Integer;
//         InsertedTempGLEntryVAT: Integer;
//         GLEntryNo: Integer;
//         myInt: Integer;

//     // [EventSubscriber(ObjectType::Codeunit, codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInitGLEntry', '', false, false)]

//     // procedure createcustomGlEnty(var GenJournalLine: Record "Gen. Journal Line"; var GLAccNo: Code[20]; Amount: Decimal; AmountAddCurr: Decimal; SystemCreatedEntry: Boolean)
//     // var
//     //     GLEntry: Record "G/L Entry";
//     // begin
//     //     GLEntry.Init();
//     //     GLEntry.CopyFromGenJnlLine(GenJournalLine);
//     //     GLEntry."Entry No." := NextEntryNo;
//     //     GLEntry."Transaction No." := NextTransactionNo;
//     //     GLEntry."G/L Account No." := GLAccNo;
//     //     GLEntry."System-Created Entry" := SystemCreatedEntry;
//     //     GLEntry.Amount := Amount;
//     //     Message('%1 - %2', GLEntry."G/L Account No.", GLEnty.Amount);
//     // end;
//     /*

//     [IntegrationEvent(true, false)]
//     procedure OnAfterInsertMemberLedgerEntries(var MembLedgerEntry: record "Member Ledger Entry"; var AccountNo: code[30]; var Amount: Decimal)
//     begin

//     end;

//     [EventSubscriber(ObjectType::Codeunit, 50130, 'OnAfterInsertMemberLedgerEntries', '', false, false)]

//     local procedure InsertGLAccounts(var MembLedgerEntry: record "Member Ledger Entry"; var AccountNo: Code[30]; var Amount: Decimal)
//     var
//         Glentry: Record "G/L Entry";
//         EntryNo: Integer;

//     begin

//         Glentry.Reset();
//         ;
//         if Glentry.FindLast() then
//             EntryNo := Glentry."Entry No." + 1
//         else
//             EntryNo := 1;

//         Glentry.Init();
//         ;
//         Glentry."Entry No." := EntryNo;
//         Glentry."G/L Account No." := AccountNo;
//         Glentry.Amount := Amount;
//         Glentry."Document No." := MembLedgerEntry."Document No.";
//         Glentry."Posting Date" := MembLedgerEntry."Posting Date";
//         Glentry."Bal. Account No." := MembLedgerEntry."Bal. Account No.";
//         Glentry."Bal. Account Type" := MembLedgerEntry."Bal. Account Type";
//         Glentry.Description := MembLedgerEntry.Description;
//         Glentry.Insert(true);
//         commit;

//     end;*/
// }