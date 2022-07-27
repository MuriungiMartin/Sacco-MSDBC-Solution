tableextension 50007 "customertableEXT" extends Customer
{
    fields
    {
        // Add changes to table fields here
        field(53900; "Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Travel Advance,Staff Advance,Implementing Partner,Others,Donor,Member,CPD Provider,Institution';
            OptionMembers = " ","Travel Advance","Staff Advance","Implementing Partner",Others,Donor,Member,"CPD Provider",Institution;

            trigger OnValidate()
            begin
                //Prevent Changing once entries exist
                //TestNoEntriesExist(FIELDCAPTION("Account Type"));
            end;
        }
        field(53901; "Employee Job Group"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salary Processing Header".No;
        }
        field(53902; "Donor Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Intramural,Extramural';
            OptionMembers = " ",Intramural,Extramural;
        }
        field(53903; "Allow Indirect Cost"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53904; "CPD Provider Reg Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53905; "Member Category Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53906; "No. SeriesCPD"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53907; "No. SeriesMember"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53908; "Customer Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Member,CPD Provider,Institutions,Normal';
            OptionMembers = ,Member,"CPD Provider",Institutions,Normal,Gym,Spa;
        }
        field(53909; "ID Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53910; "Member Category Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(53911; "Graduation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(53912; "Member No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53913; Gender; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Male,Female;
        }
        field(53914; "Date Of Birth"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Age:=HRDates.DetermineAge("Date Of Birth",TODAY);
            end;
        }
        field(53915; Religion; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(53916; Citizenship; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(53917; "Passport No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(53918; Age; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(53919; "Spa Membership Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Full,Partial;
        }
        field(53926; "Code"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53927; CodeII; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53928; "Vs No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53929; Debtors; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry".Amount where("Posting Date" = field("Date Filter"),
                                                                 "Customer No." = field("No.")));
            FieldClass = FlowField;
        }
        field(68000; testing; Decimal)
        {
            DataClassification = ToBeClassified;
        }

    }

    var
        myInt: Integer;
}