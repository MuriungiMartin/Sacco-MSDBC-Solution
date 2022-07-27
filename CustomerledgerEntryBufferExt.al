tableextension 50154 MyExtension extends "CV Ledger Entry Buffer"
{
    fields
    {
        // Add changes to table fields here
    }

    procedure CopyFromMemberLedgEntry(MemberLedgEntry: Record "Member Ledger Entry");
    begin
        TRANSFERFIELDS(MemberLedgEntry);
        Amount := MemberLedgEntry.Amount;
        "Amount (LCY)" := MemberLedgEntry."Amount (LCY)";
        "Remaining Amount" := MemberLedgEntry."Remaining Amount";
        "Remaining Amt. (LCY)" := MemberLedgEntry."Remaining Amt. (LCY)";
        "Original Amount" := MemberLedgEntry."Original Amount";
        "Original Amt. (LCY)" := MemberLedgEntry."Original Amt. (LCY)";
    end;


}