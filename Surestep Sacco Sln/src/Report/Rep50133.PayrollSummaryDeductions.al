#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516133_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50133 "Payroll Summary Deductions"
{
    RDLCLayout = './Layouts/PayrollSummaryDeductions.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("HR Employees"; "HR Employees")
        {
            column(ReportForNavId_1; 1) { } // Autogenerated by ForNav - Do not delete
            column(PrintBy; 'PRINTED BY NAME:........................................................................................ SIGNATURE:................................... DESIGNATION:...................................... DATE:.......................................')
            {
            }
            column(CheckedBy; 'CHECKED BY NAME:........................................................................................ SIGNATURE:................................... DESIGNATION:...................................... DATE:.......................................')
            {
            }
            column(VerifiedBy; 'VERIFIED BY NAME:........................................................................................ SIGNATURE:................................... DESIGNATION:...................................... DATE:.......................................')
            {
            }
            column(ApprovedBy; 'APPROVED BY NAME:........................................................................................ SIGNATURE:................................... DESIGNATION:...................................... DATE:.......................................')
            {
            }
            column(BasicPayLbl; 'BASIC PAY')
            {
            }
            column(payelbl; 'PAYE.')
            {
            }
            column(nssflbl; 'NSSF')
            {
            }
            column(nhiflbl; 'NHIF')
            {
            }
            column(Netpaylbl; 'Net Pay')
            {
            }
            column(payeamount; payeamount)
            {
            }
            column(nssfam; nssfam)
            {
            }
            column(nhifamt; nhifamt)
            {
            }
            column(NetPay; NetPay)
            {
            }
            column(BasicPay; BasicPay)
            {
            }
            column(CompName; CompName)
            {
            }
            column(pic; info.Picture)
            {
            }
            column(Addr1; Addr1)
            {
            }
            column(Addr2; Addr2)
            {
            }
            column(Email; Email)
            {
            }
            column(periods; 'Payroll Summary for ' + Format(periods, 0, 4))
            {
            }
            column(empName; "No." + ': ' + "First Name" + ' ' + "Middle Name" + ' ' + "Last Name")
            {
            }
            column(TransName_1_1; TransName[1, 1])
            {
            }
            column(TransName_1_2; TransName[1, 2])
            {
            }
            column(TransName_1_3; TransName[1, 3])
            {
            }
            column(TransName_1_4; TransName[1, 4])
            {
            }
            column(TransName_1_5; TransName[1, 5])
            {
            }
            column(TransName_1_6; TransName[1, 6])
            {
            }
            column(TransName_1_7; TransName[1, 7])
            {
            }
            column(TransName_1_8; TransName[1, 8])
            {
            }
            column(TransName_1_9; TransName[1, 9])
            {
            }
            column(TransName_1_10; TransName[1, 10])
            {
            }
            column(TransName_1_11; TransName[1, 11])
            {
            }
            column(TransName_1_12; TransName[1, 12])
            {
            }
            column(TransName_1_13; TransName[1, 13])
            {
            }
            column(TransName_1_14; TransName[1, 14])
            {
            }
            column(TransName_1_15; TransName[1, 15])
            {
            }
            column(TransName_1_16; TransName[1, 16])
            {
            }
            column(TransName_1_17; TransName[1, 17])
            {
            }
            column(TransName_1_18; TransName[1, 18])
            {
            }
            column(TransName_1_19; TransName[1, 19])
            {
            }
            column(TransName_1_20; TransName[1, 20])
            {
            }
            column(TransName_1_21; TransName[1, 21])
            {
            }
            column(TransName_1_22; TransName[1, 22])
            {
            }
            column(TransName_1_23; TransName[1, 23])
            {
            }
            column(TransName_1_24; TransName[1, 24])
            {
            }
            column(TransName_1_25; TransName[1, 25])
            {
            }
            column(TransName_1_26; TransName[1, 26])
            {
            }
            column(TransName_1_27; TransName[1, 27])
            {
            }
            column(TransName_1_28; TransName[1, 28])
            {
            }
            column(TranscAmount_1_1; TranscAmount[1, 1])
            {
            }
            column(TranscAmount_1_2; TranscAmount[1, 2])
            {
            }
            column(TranscAmount_1_3; TranscAmount[1, 3])
            {
            }
            column(TranscAmount_1_4; TranscAmount[1, 4])
            {
            }
            column(TranscAmount_1_5; TranscAmount[1, 5])
            {
            }
            column(TranscAmount_1_6; TranscAmount[1, 6])
            {
            }
            column(TranscAmount_1_7; TranscAmount[1, 7])
            {
            }
            column(TranscAmount_1_8; TranscAmount[1, 8])
            {
            }
            column(TranscAmount_1_9; TranscAmount[1, 9])
            {
            }
            column(TranscAmount_1_10; TranscAmount[1, 10])
            {
            }
            column(TranscAmount_1_11; TranscAmount[1, 11])
            {
            }
            column(TranscAmount_1_12; TranscAmount[1, 12])
            {
            }
            column(TranscAmount_1_13; TranscAmount[1, 13])
            {
            }
            column(TranscAmount_1_14; TranscAmount[1, 14])
            {
            }
            column(TranscAmount_1_15; TranscAmount[1, 15])
            {
            }
            column(TranscAmount_1_16; TranscAmount[1, 16])
            {
            }
            column(TranscAmount_1_17; TranscAmount[1, 17])
            {
            }
            column(TranscAmount_1_18; TranscAmount[1, 18])
            {
            }
            column(TranscAmount_1_19; TranscAmount[1, 19])
            {
            }
            column(TranscAmount_1_20; TranscAmount[1, 20])
            {
            }
            column(TranscAmount_1_21; TranscAmount[1, 21])
            {
            }
            column(TranscAmount_1_22; TranscAmount[1, 22])
            {
            }
            column(TranscAmount_1_23; TranscAmount[1, 23])
            {
            }
            column(TranscAmount_1_24; TranscAmount[1, 24])
            {
            }
            column(TranscAmount_1_25; TranscAmount[1, 25])
            {
            }
            column(TranscAmount_1_26; TranscAmount[1, 26])
            {
            }
            column(TranscAmount_1_27; TranscAmount[1, 27])
            {
            }
            column(TranscAmount_1_28; TranscAmount[1, 28])
            {
            }
            trigger OnPreDataItem();
            begin
                if periods = 0D then Error('Please Specify the Period first.');
                counts := 0;
                NetPayTotal := 0;
                BasicPayTotal := 0;
                payeamountTotal := 0;
                nssfamTotal := 0;
                nhifamtTotal := 0;
                Clear(TranscAmountTotal);
                // Make Headers
                // Pick The Earnings First
                prtransCodes.Reset;
                prtransCodes.SetFilter(prtransCodes."Transaction Type", '=%1', prtransCodes."transaction type"::Income);
                if prtransCodes.Find('-') then begin
                    repeat
                    begin
                        prPeriodTransactions.Reset;
                        prPeriodTransactions.SetRange(prPeriodTransactions."Transaction Code", prtransCodes."Transaction Code");
                        prPeriodTransactions.SetRange(prPeriodTransactions."Payroll Period", periods);
                        if prPeriodTransactions.Find('-') then begin
                            counts := counts + 1;
                            TransName[1, counts] := prtransCodes."Transaction Name";
                            Transcode[1, counts] := prtransCodes."Transaction Code";
                        end;
                    end;
                    until prtransCodes.Next = 0;
                end;
                // pick the deductions Here
                prtransCodes.Reset;
                prtransCodes.SetFilter(prtransCodes."Transaction Type", '=%1', prtransCodes."transaction type"::Deduction);
                if prtransCodes.Find('-') then begin
                    repeat
                    begin
                        prPeriodTransactions.Reset;
                        prPeriodTransactions.SetRange(prPeriodTransactions."Transaction Code", prtransCodes."Transaction Code");
                        prPeriodTransactions.SetRange(prPeriodTransactions."Payroll Period", periods);
                        if prPeriodTransactions.Find('-') then begin
                            counts := counts + 1;
                            TransName[1, counts] := prtransCodes."Transaction Name";
                            Transcode[1, counts] := prtransCodes."Transaction Code";
                        end;
                    end;
                    until prtransCodes.Next = 0;
                end;
                info.Reset;
                if info.Get then info.CalcFields(info.Picture);
                //Pict:=info.Picture;
                CompName := info.Name;
                Addr1 := info.Address;
                Addr2 := info.City;
                Email := info."E-Mail";
            end;

            trigger OnAfterGetRecord();
            begin
                TransCount := 0;
                showdet := true;
                NetPay := 0;
                BasicPay := 0;
                Clear(TranscAmount);
                payeamount := 0;
                nssfam := 0;
                nhifamt := 0;
                repeat
                begin
                    TransCount := TransCount + 1;
                    prPeriodTransactions.Reset;
                    prPeriodTransactions.SetRange(prPeriodTransactions."Payroll Period", periods);
                    prPeriodTransactions.SetRange(prPeriodTransactions."Employee Code", "HR Employees"."No.");
                    prPeriodTransactions.SetRange(prPeriodTransactions."Transaction Code", Transcode[1, TransCount]);
                    if prPeriodTransactions.Find('-') then begin
                        TranscAmount[1, TransCount] := prPeriodTransactions.Amount;
                    end;
                    repeat
                    begin
                        TranscAmountTotal[1, TransCount] := ((TranscAmountTotal[1, TransCount]) + TranscAmount[1, TransCount]);
                    end;
                    until prPeriodTransactions.Next = 0;
                end;
                until TransCount = 70;//COMPRESSARRAY(TransName);
                prPeriodTransactions.Reset;
                prPeriodTransactions.SetRange(prPeriodTransactions."Payroll Period", periods);
                prPeriodTransactions.SetRange(prPeriodTransactions."Employee Code", "HR Employees"."No.");
                prPeriodTransactions.SetRange(prPeriodTransactions."Transaction Name", 'Net Pay');
                if prPeriodTransactions.Find('-') then begin
                    NetPay := prPeriodTransactions.Amount;
                    //NetPayTotal:=(NetPayTotal+(prPeriodTransactions.Amount));
                end;
                prPeriodTransactions.Reset;
                prPeriodTransactions.SetRange(prPeriodTransactions."Payroll Period", periods);
                prPeriodTransactions.SetRange(prPeriodTransactions."Employee Code", "HR Employees"."No.");
                //prPeriodTransactions.SETRANGE(prPeriodTransactions."Transaction Name",'Net Pay');
                if prPeriodTransactions.Find('-') then begin
                    repeat
                    begin
                        if prPeriodTransactions."Transaction Code" = 'NPAY' then begin
                            NetPay := prPeriodTransactions.Amount;
                            NetPayTotal := (NetPayTotal + (prPeriodTransactions.Amount));
                        end else
                            if prPeriodTransactions."Transaction Code" = 'PAYE' then begin
                                payeamount := prPeriodTransactions.Amount;
                                ;
                                payeamountTotal := (payeamountTotal + (prPeriodTransactions.Amount));
                            end else
                                if prPeriodTransactions."Transaction Code" = 'NSSF' then begin
                                    nssfam := prPeriodTransactions.Amount;
                                    ;
                                    nssfamTotal := (nssfamTotal + (prPeriodTransactions.Amount));
                                end else
                                    if prPeriodTransactions."Transaction Code" = 'NHIF' then begin
                                        nhifamt := prPeriodTransactions.Amount;
                                        ;
                                        nhifamtTotal := (nhifamtTotal + (prPeriodTransactions.Amount));
                                    end else
                                        if prPeriodTransactions."Transaction Code" = 'BPAY' then begin
                                            BasicPay := prPeriodTransactions.Amount;
                                            ;
                                            BasicPayTotal := (BasicPayTotal + (prPeriodTransactions.Amount));
                                            ;
                                        end;
                    end;
                    until prPeriodTransactions.Next = 0;
                end;
                if "HR Employees"."No." = '' then showdet := false;
                if ((BasicPay = 0) or ("HR Employees"."No." = '')) then //showdet:=FALSE;
                    CurrReport.Skip;
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
                field(Period; periods)
                {
                    ApplicationArea = Basic;
                    Caption = 'Period:';
                    TableRelation = "Payroll Calender.";
                }
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
        if UserSetup.Get(UserId) then begin
            if UserSetup."View Payroll" = false then Error('You dont have permissions for payroll, Contact your system administrator! ')
        end;
        ;
        ReportsForNavPre;
    end;

    var
        UserSetup: Record "User Setup";
        prPayrollPeriods: Record "Payroll Calender.";
        periods: Date;
        counts: Integer;
        prPeriodTransactions: Record "prPeriod Transactions.";
        TransName: array[1, 200] of Text[200];
        Transcode: array[1, 200] of Code[100];
        TransCount: Integer;
        TranscAmount: array[1, 200] of Decimal;
        TranscAmountTotal: array[1, 200] of Decimal;
        NetPay: Decimal;
        NetPayTotal: Decimal;
        showdet: Boolean;
        payeamount: Decimal;
        payeamountTotal: Decimal;
        nssfam: Decimal;
        nssfamTotal: Decimal;
        nhifamt: Decimal;
        nhifamtTotal: Decimal;
        BasicPay: Decimal;
        BasicPayTotal: Decimal;
        GrossPay: Decimal;
        GrosspayTotal: Decimal;
        prtransCodes: Record "Payroll Transaction Code.";
        info: Record "Company Information";
        CompName: Text[50];
        Addr1: Text[50];
        Addr2: Text[50];
        Email: Text[50];

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516133_v6_3_0_2259;
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
