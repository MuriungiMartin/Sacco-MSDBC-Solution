codeunit 53000 SingleInstanceCu
{
    trigger OnRun()
    begin

    end;



    [EventSubscriber(ObjectType::Codeunit, codeunit::"Gen. Jnl.-Post Line", 'OnAfterGLFinishPosting', '', false, false)]

    // procedure FinishThegoddamnCodeunit(var GenJnlLine: Record "Gen. Journal Line"; GLEntry: Record "G/L Entry"; IsTransactionConsistent: Boolean)
    // var
    //     // GenJnlLine: Record "Gen. Journal Line";
    //     GlentryTmp: Record "G/L Entry";
    //     //    GLEntry: Record "G/L Entry";
    //     GLSetup: Record "General Ledger Setup";
    // // SingleCU: Codeunit 
    // begin
    //     WITH GenJnlLine DO BEGIN
    //         Message('malisa yeye');
    //         IF GLEntryTmp.FIND('-') THEN BEGIN
    //             REPEAT
    //                 message('Kisima cha Giningi');
    //                 // entr
    //                 //   GLEntry := GLEntryTmp;
    //                 IF GLSetup."Additional Reporting Currency" = '' THEN BEGIN
    //                     Message('Mwisho wa Kosa');
    //                     GLEntry."Additional-Currency Amount" := 0;
    //                     GLEntry."Add.-Currency Debit Amount" := 0;
    //                     GLEntry."Add.-Currency Credit Amount" := 0;
    //                 END;
    //                 GLEntry.INSERT;
    //                 Message('Consistency true? %1', IsTransactionConsistent);
    //                 //MOD01 Start
    //                 if IsTransactionConsistent then
    //                     InsertGL(GLEntry);
    //             until GlentryTmp.Next() = 0;
    //         end;
    //     end;
    //     //MOD01 End
    //     // IF NOT InsertFAAllocDim(GLEntry."Entry No.") THEN
    // end;

    PROCEDURE InsertGL(GLEntry: Record 17)
    var
        Entryno: Integer;
    BEGIN
        Message('tuko hapa tunafanya maneno');
        IF StoreToTemp THEN BEGIN
            Message('Kosa la Bwana Msa');
            TempGLEntry := GLEntry;
            IF NOT TempGLEntry.INSERT THEN BEGIN
                Message('Mwana wa yungi hulewa seuze wa mlimwengu');
                TempGLEntry.DELETEALL;
                TempGLEntry.INSERT;
            END;
        END;
    END;


    var

    VAR
        TempGLEntry: Record "G/L Entry";
        StoreToTemp: Boolean;
}