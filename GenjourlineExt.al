pageextension 50144 MyExtension extends "General Journal"
{
    layout
    {
        addlast(Control1)
        {
            field("Transaction Type"; "Transaction Type")
            {

            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}