#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516392_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50392 "Loan Defaulter 2st Notice"
{
    RDLCLayout = './Layouts/LoanDefaulter2stNotice.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(LoansREC; "Loans Register")
        {
            RequestFilterFields = "Loan  No.", "Last Pay Date", "Client Code";
            column(ReportForNavId_1102755000; 1102755000) { } // Autogenerated by ForNav - Do not delete
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(CompanyName; CompanyInformation.Name)
            {
            }
            column(CompanyAddress; CompanyInformation.Address)
            {
            }
            column(Address2; CompanyInformation."Address 2")
            {
            }
            column(PostCode; CompanyInformation."Post Code")
            {
            }
            column(City; CompanyInformation.City)
            {
            }
            column(Country; CompanyInformation."Country/Region Code")
            {
            }
            column(CompanyPhoneNo; CompanyInformation."Phone No.")
            {
            }
            column(CompanyFaxNo; CompanyInformation."Fax No.")
            {
            }
            column(E_mail; CompanyInformation."E-Mail")
            {
            }
            column(CPic; CompanyInformation.Picture)
            {
            }
            column(Staff_No; Customer."Payroll No")
            {
            }
            column(MNo; Customer."No.")
            {
            }
            column(Name; Customer.Name)
            {
            }
            column(Address; Customer.Address)
            {
            }
            column(CustCity; Customer.City)
            {
            }
            column(DearM; DearM)
            {
            }
            column(Loan_Type; LoansR."Loan Product Type")
            {
            }
            column(LBalance1; LBalance1)
            {
            }
            column(Loan_No; LoansREC."Loan  No.")
            {
            }
            column(Loan_Product_type; LoansREC."Loan Product Type")
            {
            }
            column(Outstanding_Bal; Lbal)
            {
            }
            column(Interest_Due; INTBAL)
            {
            }
            column(Penalty; COMM)
            {
            }
            column(LastPDate; LastPDate)
            {
            }
            column(Total_Amount; Lbal + INTBAL + COMM)
            {
            }
            dataitem(Customer; "Members Register")
            {
                DataItemLink = "No." = field("Client Code");
                RequestFilterFields = "No.";
                column(ReportForNavId_1102755005; 1102755005) { } // Autogenerated by ForNav - Do not delete
                trigger OnAfterGetRecord();
                begin
                    if Customer.Gender = Customer.Gender::Male then
                        DearM := 'Dear Madam'
                    else
                        DearM := 'Dear Sir';
                    LastPDate := 0D;
                    Balance := 0;
                    SharesB := 0;
                    if SendSMS = true then begin
                        //SMS MESSAGE
                        SMSMessage.Reset;
                        if SMSMessage.Find('+') then begin
                            iEntryNo := SMSMessage."Entry No";
                            iEntryNo := iEntryNo + 1;
                        end
                        else begin
                            iEntryNo := 1;
                        end;
                        SMSMessage.Reset;
                        SMSMessage.Init;
                        SMSMessage."Entry No" := iEntryNo;
                        SMSMessage."Account No" := Loans."Client Code";
                        SMSMessage."Date Entered" := Today;
                        SMSMessage."Time Entered" := Time;
                        SMSMessage.Source := 'LOAN DEF1';
                        SMSMessage."Entered By" := UserId;
                        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                        SMSMessage."SMS Message" := 'Defaulter First Notice: You have defaulted Loan No. '
                        + Loans."Loan  No." + ' of KSHs.' + Format(Loans."Approved Amount") +
                                                  ' at HAZINA SACCO LTD. ';
                        Cust.Reset;
                        if Cust.Get(Loans."Client Code") then
                            SMSMessage."Telephone No" := Cust."Phone No.";
                        SMSMessage.Insert;
                    end;
                    /*
					SharesAlllocated:=(LBalance/(Customer."Oustanding Balance"+Customer."Reason for Withdrawal"))*("Current Shares"*-1);
					ABFAllocated:=(LBalance/(Customer."Oustanding Balance"+Customer."Reason for Withdrawal"))*(Customer."Insurance Fund"*-0.5);
					SharesB:=SharesAlllocated+ABFAllocated;
					TotalRec:=ROUND(LBalance-SharesB,1,'>');
					IF TotalRec < 0 THEN
					TotalRec:=0;
					AmountT:=ROUND((TotalRec/NoGuarantors),0.05,'>');
					LoansR.RESET;
					LoansR.SETRANGE(LoansR."Client Code",Customer."No.");
					LoansR.SETRANGE(LoansR.Posted,TRUE);
					IF LoansR.FIND('-') THEN BEGIN
					REPEAT
					IF LoansR."Last Pay Date" = 0D THEN BEGIN
					IF LastPDate < LoansR."Issued Date" THEN
					LastPDate:=LoansR."Issued Date"
					END ELSE BEGIN
					IF LastPDate < LoansR."Last Pay Date" THEN
					LastPDate:=LoansR."Last Pay Date";
					END;
					UNTIL LoansR.NEXT = 0;
					END;
					*/

                end;

            }
            dataitem(Loans; "Loans Register")
            {
                DataItemLink = "Loan  No." = field("Loan  No.");
                DataItemTableView = where("Outstanding Balance" = filter(> 0));
                column(ReportForNavId_1000000008; 1000000008) { } // Autogenerated by ForNav - Do not delete
                dataitem("Loan Guarantors"; "Loans Guarantee Details")
                {
                    DataItemLink = "Loan No" = field("Loan  No.");
                    column(ReportForNavId_1000000003; 1000000003) { } // Autogenerated by ForNav - Do not delete
                    column(Member_No; LoanGuar."Member No")
                    {
                    }
                    column(NameG; LoanGuar.Name)
                    {
                    }
                    column(Personal_No; LoanGuar."Staff/Payroll No.")
                    {
                    }
                    column(intcount; intcount)
                    {
                    }
                    column(Outstanding_Bal2; Lbal)
                    {
                    }
                    column(Interest_Due2; INTBAL)
                    {
                    }
                    column(Penalty2; COMM)
                    {
                    }
                    column(Total_Amount2; Lbal + INTBAL + COMM)
                    {
                    }
                    trigger OnPreDataItem();
                    begin
                        intcount := intcount + 1;
                        TGrAmount := 0;
                        GrAmount := 0;
                        FGrAmount := 0;
                        Amount2 := 0;
                    end;

                    trigger OnAfterGetRecord();
                    begin
                        PersonalNo := '';
                        GAddress := '';
                        if Cust.Get("Loan Guarantors"."Member No") then begin
                            PersonalNo := Cust."Payroll No";
                            GAddress := Cust.Address + ' ' + Cust."Address 2" + ' ' + Cust.City;
                            if SendSMS = true then begin
                                //SMS MESSAGE
                                SMSMessage.Reset;
                                if SMSMessage.Find('+') then begin
                                    iEntryNo := SMSMessage."Entry No";
                                    iEntryNo := iEntryNo + 1;
                                end
                                else begin
                                    iEntryNo := 1;
                                end;
                                SMSMessage.Reset;
                                SMSMessage.Init;
                                SMSMessage."Entry No" := iEntryNo;
                                SMSMessage."Account No" := "Loan Guarantors"."Member No";
                                SMSMessage."Date Entered" := Today;
                                SMSMessage."Time Entered" := Time;
                                SMSMessage.Source := 'LOAN DEF1';
                                SMSMessage."Entered By" := UserId;
                                SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                                SMSMessage."SMS Message" := 'Defaulter First Notice: This is to notify you that '
                                + LoansREC."Client Name" + ' has defaulted a loan you had guaranteed of KSHs.' + Format(Loans."Approved Amount") +
                                                          ' at HAZINA SACCO LTD. ';
                                Cust1.Reset;
                                if Cust1.Get("Loan Guarantors"."Member No") then
                                    SMSMessage."Telephone No" := Cust1."Phone No.";
                                SMSMessage.Insert;
                            end;
                        end;
                        LoanGuar.Reset;
                        LoanGuar.SetRange(LoanGuar."Loan No", Loans."Loan  No.");
                        if LoanGuar.Find('-') then begin
                            LoanGuar.Reset;
                            LoanGuar.SetRange(LoanGuar."Loan No", Loans."Loan  No.");
                            repeat
                                TGrAmount := TGrAmount + GrAmount;
                                GrAmount := LoanGuar."Amont Guaranteed";
                                //LoanGuar."Amount Guarnted";
                                FGrAmount := TGrAmount + LoanGuar."Amont Guaranteed";
                            //Amount2:=(GrAmount/FGrAmount)*(Lbal+INTBAL+COMM);
                            until LoanGuar.Next = 0;
                        end;
                        //Defaulter loan clear
                        Loans.CalcFields(Loans."Outstanding Balance", Loans."Interest Due");
                        Lbal := ROUND(Loans."Outstanding Balance", 0.5, '=');
                        INTBAL := Loans."Interest Due";
                        COMM := Loans."Interest Due" * 0.5;
                        //MESSAGE('BALANCE %1',Lbal);
                        //commisision
                        LoanGuar.Reset;
                        LoanGuar.SetRange(LoanGuar."Loan No", Loans."Loan  No.");
                        if LoanGuar.Find('-') then begin
                            LoanGuar.Reset;
                            LoanGuar.SetRange(LoanGuar."Loan No", Loans."Loan  No.");
                            //DLN:='DLN';
                            repeat
                                GenSetUp.Get();
                                GenSetUp."Defaulter LN" := GenSetUp."Defaulter LN" + 10;
                                GenSetUp.Modify;
                                //DLN:='DLN'+FORMAT(GenSetUp."Defaulter LN");
                                //GrAmount:=LoanGuar."Amount Guarnted";
                                //FGrAmount:=FGrAmount+LoanGuar."Amount Guarnted";
                                //LoanGuar."Amount Guarnted";
                                //TGrAmount:=TGrAmount+GrAmount;
                                //Amount2:=(GrAmount/FGrAmount)*(Lbal+INTBAL+COMM);
                                //MESSAGE('guarnteed Amount %1',FGrAmount);
                                //REPEAT
                                ////Insert jnl lines
                                Cust.Reset;
                                Cust.SetRange(Cust."No.", LoanGuar."Member No");
                                if Cust.Find('-') then begin
                                    Loans."Client Name" := Cust.Name;
                                end;
                            until LoanGuar.Next = 0;
                        end;
                    end;

                }
            }
            trigger OnPreDataItem();
            begin
                SenderName := 'Mrs E. MIUNDO';
                CompanyInformation.Get();
                CompanyInformation.CalcFields(CompanyInformation.Picture);
            end;

            trigger OnAfterGetRecord();
            begin
                LoansREC.CalcFields(LoansREC."Outstanding Balance", LoansREC."Outstanding Interest", LoansREC."No. Of Guarantors");
                NoGuarantors := LoansREC."No. Of Guarantors";
                if NoGuarantors = 0 then
                    NoGuarantors := 1;
                LBalance := LoansREC."Outstanding Balance" + LoansREC."Outstanding Interest";
                LBalance1 := LoansREC."Outstanding Balance";
                Notified := true;
                //LoansREC."Notified date":=TODAY;
                Modify;
                Balance := Balance - (LoansREC."Outstanding Balance" + LoansREC."Outstanding Interest");
                SharesB := SharesB - (LoansREC."Outstanding Balance" + LoansREC."Outstanding Interest");
                if SharesB < 0 then
                    BalanceType := 'Debit Balance'
                else
                    BalanceType := 'Credit Balance';
                LoanGuar.Reset;
                LoanGuar.SetRange(LoanGuar."Loan No", LoansREC."Loan  No.");
                if LoanGuar.Find('-') then begin
                    LoanGuar.Reset;
                    LoanGuar.SetRange(LoanGuar."Loan No", LoansREC."Loan  No.");
                    repeat
                        TGrAmount := TGrAmount + GrAmount;
                        GrAmount := LoanGuar."Amont Guaranteed";
                        //LoanGuar."Amount Guarnted";
                        FGrAmount := TGrAmount + LoanGuar."Amont Guaranteed";
                    until LoanGuar.Next = 0;
                end;
                //Defaulter loan clear
                LoansREC.CalcFields(LoansREC."Outstanding Balance", LoansREC."Interest Due", LoansREC."Outstanding Interest");
                Lbal := ROUND(LoansREC."Outstanding Balance", 0.5, '=');
                INTBAL := LoansREC."Outstanding Interest";
                COMM := LoansREC."Outstanding Interest" * 0.5;
                Message('BALANCE %1', Lbal);
                //commisision
                /*
				LoanGuar.RESET;
				LoanGuar.SETRANGE(LoanGuar."Loan No",Loans."Loan  No.");
				IF LoanGuar.FIND('-') THEN BEGIN
				LoanGuar.RESET;
				LoanGuar.SETRANGE(LoanGuar."Loan No",Loans."Loan  No.");
				//DLN:='DLN';
				REPEAT
				GenSetUp.GET();
				GenSetUp."Defaulter LN":=GenSetUp."Defaulter LN"+10;
				GenSetUp.MODIFY;
				//DLN:='DLN'+FORMAT(GenSetUp."Defaulter LN");
				GrAmount:=LoanGuar."Amount Guarnted";
				//LoanGuar."Amount Guarnted";
				TGrAmount:=TGrAmount+GrAmount;
				//Amount2:=(GrAmount/TGrAmount)*(Lbal+INTBAL+COMM);
				MESSAGE('guarnteed Amount %1',FGrAmount);
				//REPEAT
				////Insert jnl lines
				Cust.RESET;
				Cust.SETRANGE(Cust."No.",LoanGuar."Member No");
				IF Cust.FIND('-') THEN BEGIN
				Loans."Client Name":=Cust.Name;
				END;
				UNTIL LoanGuar.NEXT=0;
				END;*/

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
        intcount: Integer;
        Balance: Decimal;
        SenderName: Text[150];
        DearM: Text[60];
        BalanceType: Text[100];
        SharesB: Decimal;
        LastPDate: Date;
        Notified: Boolean;
        LoansR: Record "Loans Register";
        SharesAlllocated: Decimal;
        ABFAllocated: Decimal;
        LBalance: Decimal;
        PersonalNo: Code[50];
        GAddress: Text[250];
        Cust: Record "Members Register";
        TotalRec: Decimal;
        NoGuarantors: Integer;
        AmountT: Decimal;
        LoanGuar: Record "Loans Guarantee Details";
        TGrAmount: Decimal;
        GrAmount: Decimal;
        FGrAmount: Decimal;
        Lbal: Decimal;
        INTBAL: Decimal;
        COMM: Decimal;
        GenSetUp: Record "Sacco General Set-Up";
        Amount2: Decimal;
        LBalance1: Decimal;
        SendSMS: Boolean;
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        Cust1: Record "Members Register";
        CompanyInformation: Record "Company Information";

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516392_v6_3_0_2259;
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
