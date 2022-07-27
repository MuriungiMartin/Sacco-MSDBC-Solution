codeunit 50500 CustomPostingCodeunit
{
    trigger OnRun()
    begin

    end;



    var
        myInt: Integer;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnMoveGenJournalLine', '', false, false)]

    procedure SeeMovement(var GenJournalLine: Record "Gen. Journal Line"; ToRecordID: RecordId)
    begin
        Message(Format(ToRecordID));

    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforeInitGLEntry', '', false, false)]

    procedure SeeGLinit(var GLAccNo: Code[20]; Amount: Decimal)
    begin
        Message('gl acc %1 %2', GLAccNo, Amount);

    end;
}