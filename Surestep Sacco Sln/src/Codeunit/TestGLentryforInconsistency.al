codeunit 50300 CheckGLEntries
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Gen. Jnl.-Post Line", 'OnAfterFinishPosting', '', false, false)]
    procedure CheckGlAmounts(var GlobalGLEntry: Record "G/L Entry")
    begin

        with GlobalGLEntry do begin
            repeat
                Message('amount is %1', GlobalGLEntry.Amount);
                Message('credit amount is %1', GlobalGLEntry."Credit Amount");
                Message('Debit amount is %1', GlobalGLEntry."Debit Amount");
                Message('vat amount is %1', GlobalGLEntry."VAT Amount");
                Message(' "Additional-Currency Amount" is %1', GlobalGLEntry."Additional-Currency Amount");
                Message(' Add.-Currency Debit Amount is %1', GlobalGLEntry."Add.-Currency Debit Amount");
                Message(' Add.-Currency credit Amount is %1', GlobalGLEntry."Add.-Currency Credit Amount");
            until GlobalGLEntry.Next() = 0;
        end;

    end;

    var
        myInt: Integer;
}