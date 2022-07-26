// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
// dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
// {	
// 	assembly("ForNav.Reports.6.3.0.2259")
// 	{
// 		type(ForNav.Report_6_3_0_2259; ForNavReport51516375_v6_3_0_2259){}   
// 	}
// } // Reports ForNAV Autogenerated code - do not delete or modify -->

// Report 50375 "Generate Loans DefaulterAging1"
// {
// 	RDLCLayout = './Layouts/GenerateLoansDefaulterAging1.rdlc'; DefaultLayout = RDLC;

// 	dataset
// 	{
// 		dataitem("HR Transport Requisition Pass";"HR Transport Requisition Pass")
// 		{
// 			DataItemTableView = sorting("Req No") where(test=const(0),Field53102=filter(>0));
// 			RequestFilterFields = "Passenger/s Full Name/s",Field53102,Field53182;
// 			column(ReportForNavId_4645; 4645) {} // Autogenerated by ForNav - Do not delete
// 			column(FORMAT_TODAY_0_4_; Format(Today,0,4))
// 			{
// 			}
// 			column(CurrReport_PAGENO; Format(ReportForNav.PageNo))
// 			{
// 			}
// 			column(UserId; UserId)
// 			{
// 			}
// 			column(COMPANYNAME; COMPANYNAME)
// 			{
// 			}
// 			column(Loans_Loans__Outstanding_Balance_; "HR Transport Requisition Pass"."Outstanding Balance")
// 			{
// 			}
// 			column(Over3Month; Over3Month)
// 			{
// 			}
// 			column(V3Month_; "3Month")
// 			{
// 			}
// 			column(V2Month_; "2Month")
// 			{
// 			}
// 			column(currentShares; currentShares)
// 			{
// 			}
// 			column(Loans__Approved_Amount_; "Approved Amount")
// 			{
// 			}
// 			column(Loans_Loans__Interest_Due_; "HR Transport Requisition Pass"."Interest Due")
// 			{
// 			}
// 			column(Loans__Client_Name_; "Client Name")
// 			{
// 			}
// 			column(Loans__Client_Code_; "HR Transport Requisition Pass".Dept)
// 			{
// 			}
// 			column(Loans__Loan_Product_Type_; "HR Transport Requisition Pass"."Passenger/s Full Name/s")
// 			{
// 			}
// 			column(Loans__Loan__No__; "HR Transport Requisition Pass"."Req No")
// 			{
// 			}
// 			column(Loans__Loan__No___Control1102760030; "HR Transport Requisition Pass"."Req No")
// 			{
// 			}
// 			column(Loans__Loan_Product_Type__Control1102760031; "HR Transport Requisition Pass"."Passenger/s Full Name/s")
// 			{
// 			}
// 			column(Loans__Client_Code__Control1102760032; "HR Transport Requisition Pass".Dept)
// 			{
// 			}
// 			column(Loans__Client_Name__Control1102760033; "Client Name")
// 			{
// 			}
// 			column(currentShares_Control1102760034; currentShares)
// 			{
// 			}
// 			column(V2Month__Control1102760035; "2Month")
// 			{
// 			}
// 			column(V3Month__Control1102760036; "3Month")
// 			{
// 			}
// 			column(Over3Month_Control1102760037; Over3Month)
// 			{
// 			}
// 			column(Loans__Approved_Amount__Control1102760038; "Approved Amount")
// 			{
// 			}
// 			column(Loans_Loans__Interest_Due__Control1102760039; "HR Transport Requisition Pass"."Interest Due")
// 			{
// 			}
// 			column(Loans_Loans__Outstanding_Balance__Control1102760040; "HR Transport Requisition Pass"."Outstanding Balance")
// 			{
// 			}
// 			column(Loans__Loan__No___Control1102760019; "HR Transport Requisition Pass"."Req No")
// 			{
// 			}
// 			column(Loans__Loan_Product_Type__Control1102760020; "HR Transport Requisition Pass"."Passenger/s Full Name/s")
// 			{
// 			}
// 			column(Loans__Client_Code__Control1102760021; "HR Transport Requisition Pass".Dept)
// 			{
// 			}
// 			column(Company_Address; Company.Address)
// 			{
// 			}
// 			column(Company_Address2; Company."Address 2")
// 			{
// 			}
// 			column(Company_PhoneNo; Company."Phone No.")
// 			{
// 			}
// 			column(Company_Email; Company."E-Mail")
// 			{
// 			}
// 			column(Company_Picture; Company.Picture)
// 			{
// 			}
// 			column(Loans__Client_Name__Control1102760022; "Client Name")
// 			{
// 			}
// 			column(currentShares_Control1102760023; currentShares)
// 			{
// 			}
// 			column(V2Month__Control1102760024; "2Month")
// 			{
// 			}
// 			column(V3Month__Control1102760025; "3Month")
// 			{
// 			}
// 			column(Over3Month_Control1102760026; Over3Month)
// 			{
// 			}
// 			column(Loans__Approved_Amount__Control1102760027; "Approved Amount")
// 			{
// 			}
// 			column(Loans_Loans__Interest_Due__Control1102760028; "HR Transport Requisition Pass"."Interest Due")
// 			{
// 			}
// 			column(Loans_Loans__Outstanding_Balance__Control1102760029; "HR Transport Requisition Pass"."Outstanding Balance")
// 			{
// 			}
// 			column(Loans__Loan__No___Control1102760008; "HR Transport Requisition Pass"."Req No")
// 			{
// 			}
// 			column(Loans__Loan_Product_Type__Control1102760009; "HR Transport Requisition Pass"."Passenger/s Full Name/s")
// 			{
// 			}
// 			column(Loans__Client_Code__Control1102760010; "HR Transport Requisition Pass".Dept)
// 			{
// 			}
// 			column(Loans__Client_Name__Control1102760011; "Client Name")
// 			{
// 			}
// 			column(currentShares_Control1102760012; currentShares)
// 			{
// 			}
// 			column(V2Month__Control1102760013; "2Month")
// 			{
// 			}
// 			column(V3Month__Control1102760014; "3Month")
// 			{
// 			}
// 			column(Over3Month_Control1102760015; Over3Month)
// 			{
// 			}
// 			column(Loans__Approved_Amount__Control1102760016; "Approved Amount")
// 			{
// 			}
// 			column(Loans_Loans__Interest_Due__Control1102760017; "HR Transport Requisition Pass"."Interest Due")
// 			{
// 			}
// 			column(Loans_Loans__Outstanding_Balance__Control1102760018; "HR Transport Requisition Pass"."Outstanding Balance")
// 			{
// 			}
// 			column(Loans__Loan__No___Control1000000008; "HR Transport Requisition Pass"."Req No")
// 			{
// 			}
// 			column(Loans__Loan_Product_Type__Control1000000014; "HR Transport Requisition Pass"."Passenger/s Full Name/s")
// 			{
// 			}
// 			column(Loans__Client_Code__Control1000000017; "HR Transport Requisition Pass".Dept)
// 			{
// 			}
// 			column(Loans__Client_Name__Control1000000020; "Client Name")
// 			{
// 			}
// 			column(Loans_Loans__Outstanding_Balance__Control1000000000; "HR Transport Requisition Pass"."Outstanding Balance")
// 			{
// 			}
// 			column(currentShares_Control1000000010; currentShares)
// 			{
// 			}
// 			column(V2Month__Control1000000011; "2Month")
// 			{
// 			}
// 			column(V3Month__Control1000000012; "3Month")
// 			{
// 			}
// 			column(Over3Month_Control1000000013; Over3Month)
// 			{
// 			}
// 			column(Loans__Approved_Amount__Control1000000027; "Approved Amount")
// 			{
// 			}
// 			column(Loans_Loans__Interest_Due__Control1000000031; "HR Transport Requisition Pass"."Interest Due")
// 			{
// 			}
// 			column(LoanT; LoanT)
// 			{
// 			}
// 			column(Loans_Aging_AnalysisCaption; Loans_Aging_AnalysisCaptionLbl)
// 			{
// 			}
// 			column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
// 			{
// 			}
// 			column(Loans__Loan__No___Control1000000008Caption; FieldCaption("Req No"))
// 			{
// 			}
// 			column(Loan_TypeCaption; Loan_TypeCaptionLbl)
// 			{
// 			}
// 			column(Loans__Client_Code__Control1000000017Caption; FieldCaption(Dept))
// 			{
// 			}
// 			column(Loans__Client_Name__Control1000000020Caption; FieldCaption("Client Name"))
// 			{
// 			}
// 			column(Current_SharesCaption; Current_SharesCaptionLbl)
// 			{
// 			}
// 			column(Oustanding_BalanceCaption; Oustanding_BalanceCaptionLbl)
// 			{
// 			}
// 			column(V2___3_MonthsCaption; V2___3_MonthsCaptionLbl)
// 			{
// 			}
// 			column(V1___2_MonthsCaption; V1___2_MonthsCaptionLbl)
// 			{
// 			}
// 			column(Over_3_MonthsCaption; Over_3_MonthsCaptionLbl)
// 			{
// 			}
// 			column(Loans__Approved_Amount__Control1000000027Caption; FieldCaption("Approved Amount"))
// 			{
// 			}
// 			column(Interest_DueCaption; Interest_DueCaptionLbl)
// 			{
// 			}
// 			trigger OnPreDataItem();
// 			begin
// 				GenSetUp.Get(0);
// 				LoanT:=0
// 			end;

// 			trigger OnAfterGetRecord();
// 			begin
// 				//LoanT:=LoanT+Loans."Outstanding Balance";
// 				LoanT:="HR Transport Requisition Pass"."Outstanding Balance";
// 				//LoanEndDate:="Loan Disbursement Date"+Loans.Installments;
// 				if AsAt = 0D then
// 				AsAt:=Today;
// 				Evaluate(DFormula,'1Q');
// 				"1Month":=0;
// 				"2Month":=0;
// 				"3Month":=0;
// 				Over3Month:=0;
// 				perfoming:=0;
// 				"HR Transport Requisition Pass".CalcFields("HR Transport Requisition Pass"."Last Pay Date","HR Transport Requisition Pass"."Outstanding Balance");
// 				if "HR Transport Requisition Pass"."Instalment Period" = DFormula then
// 				LastDueDate:=CalcDate('1Q',"HR Transport Requisition Pass"."Last Pay Date")
// 				else
// 				ADDEDDATE:=35;
// 				LastDueDate:="HR Transport Requisition Pass"."Last Pay Date";
// 				/*IF LastDueDate<>0D THEN BEGIN
// 				IF Loans."Issued Date"<>0D THEN BEGIN
// 				LastDueDate:=CALCDATE('1M',Loans."Issued Date");*/
// 				// JONAH- LOANS CATEGORY AS PER SACCO POLICY
// 				if (LastDueDate <= CalcDate('-30D',Today)) then
// 				perfoming:="HR Transport Requisition Pass"."Outstanding Balance";
// 				"HR Transport Requisition Pass"."Loans Category":="HR Transport Requisition Pass"."loans category"::"0";
// 				"HR Transport Requisition Pass".Modify;
// 				 if (LastDueDate <= CalcDate('-30D',Today)) and  (LastDueDate > CalcDate('-60D',Today)) then  begin
// 				"1Month":="HR Transport Requisition Pass"."Outstanding Balance";
// 				 "HR Transport Requisition Pass"."Loans Category":="HR Transport Requisition Pass"."loans category"::"1";
// 				 "HR Transport Requisition Pass".Modify;
// 				end else if (LastDueDate <= CalcDate('-61D',Today)) and  (LastDueDate > CalcDate('-90D',Today)) then begin
// 				"2Month":="HR Transport Requisition Pass"."Outstanding Balance" ;
// 				"HR Transport Requisition Pass"."Loans Category":="HR Transport Requisition Pass"."loans category"::"2";
// 				"HR Transport Requisition Pass".Modify;
// 				 end else if (LastDueDate <= CalcDate('-91D',Today)) and  (LastDueDate > CalcDate('-180D',Today)) then begin
// 				"3Month":="HR Transport Requisition Pass"."Outstanding Balance";
// 				  "HR Transport Requisition Pass"."Loans Category":="HR Transport Requisition Pass"."loans category"::"3";
// 				  "HR Transport Requisition Pass".Modify;
// 				end else if (LastDueDate <= CalcDate('-181D',AsAt))  then begin
// 				Over3Month:="HR Transport Requisition Pass"."Outstanding Balance";
// 				 "HR Transport Requisition Pass"."Loans Category":="HR Transport Requisition Pass"."loans category"::"4";
// 				   "HR Transport Requisition Pass".Modify;
// 				end;
// 				 // JONAH- LOANS CATEGORY AS PER SASRA POLICY
// 				if (LastDueDate <= CalcDate('-60D',Today)) then
// 				perfoming:="HR Transport Requisition Pass"."Outstanding Balance";
// 				"HR Transport Requisition Pass"."Loans Category-SASRA":="HR Transport Requisition Pass"."loans category-sasra"::"0";
// 				"HR Transport Requisition Pass".Modify;
// 				 if (LastDueDate <= CalcDate('-61D',Today)) and  (LastDueDate > CalcDate('-120D',Today)) then  begin
// 				"1Month":="HR Transport Requisition Pass"."Outstanding Balance";
// 				 "HR Transport Requisition Pass"."Loans Category-SASRA":="HR Transport Requisition Pass"."loans category-sasra"::"1";
// 				 "HR Transport Requisition Pass".Modify;
// 				end else if (LastDueDate <= CalcDate('-121D',Today)) and  (LastDueDate > CalcDate('-240D',Today)) then begin
// 				"2Month":="HR Transport Requisition Pass"."Outstanding Balance" ;
// 				"HR Transport Requisition Pass"."Loans Category-SASRA":="HR Transport Requisition Pass"."loans category-sasra"::"2";
// 				"HR Transport Requisition Pass".Modify;
// 				 end else if (LastDueDate <= CalcDate('-241D',Today)) and  (LastDueDate > CalcDate('-420D',Today)) then begin
// 				"3Month":="HR Transport Requisition Pass"."Outstanding Balance";
// 				  "HR Transport Requisition Pass"."Loans Category-SASRA":="HR Transport Requisition Pass"."loans category-sasra"::"3";
// 				  "HR Transport Requisition Pass".Modify;
// 				end else if (LastDueDate <= CalcDate('-421D',AsAt))  then begin
// 				Over3Month:="HR Transport Requisition Pass"."Outstanding Balance";
// 				 "HR Transport Requisition Pass"."Loans Category-SASRA":="HR Transport Requisition Pass"."loans category-sasra"::"4";
// 				   "HR Transport Requisition Pass".Modify;
// 				end;
// 				/*ELSE
// 				Over3Month:=Loans."Outstanding Balance";*/
// 				currentShares:=0;
// 				Cust2.Init;
// 				Cust2.Reset;
// 				Cust2.SetRange(Cust2.Date,"HR Transport Requisition Pass".Dept);
// 				Cust2.SetRange(Cust2."Transaction Type",Cust2."transaction type"::"14");
// 				if(Cust2.Find('-')) then repeat
// 				 currentShares:=currentShares+Cust2.Amount;
// 				 until Cust2.Next=0;

// 			end;

// 		}
// 	}

// 	requestpage
// 	{


// 		SaveValues = false;	  layout
// 		{
// 			area(content)
// 			{
// 				group(Options)
// 				{
// 					Caption = 'Options';
// 					field(ForNavOpenDesigner;ReportForNavOpenDesigner)
// 					{
// 						ApplicationArea = Basic;
// 						Caption = 'Design';
// 						Visible = ReportForNavAllowDesign;
// 						trigger OnValidate()
// 						begin
// 							ReportForNav.LaunchDesigner(ReportForNavOpenDesigner);
// 							CurrReport.RequestOptionsPage.Close();
// 						end;

// 					}
// 				}
// 			}
// 		}

// 		actions
// 		{
// 		}
// 		trigger OnOpenPage()
// 		begin
// 			ReportForNavOpenDesigner := false;
// 		end;
// 	}

// 	trigger OnInitReport()
// 	begin
// 		Company.Get();
// 		Company.CalcFields(Company.Picture);
// 		;ReportsForNavInit;

// 	end;

// 	trigger OnPostReport()
// 	begin
// 		;ReportForNav.Post;
// 	end;

// 	trigger OnPreReport()
// 	begin
// 		/*IF "COMPY INFOR".GET THEN
// 				BEGIN
// 		"COMPY INFOR".CALCFIELDS("COMPY INFOR".Picture);
// 				NAME:="COMPY INFOR".Name;
// 				END;*/
// 		if Company.Get then begin
// 		Company.CalcFields(Company.Picture);
// 		end;
// 		;ReportsForNavPre;

// 	end;
// 	var
// 		"1Month": Decimal;
// 		"2Month": Decimal;
// 		"3Month": Decimal;
// 		Over3Month: Decimal;
// 		ShowLoan: Boolean;
// 		AsAt: Date;
// 		LastDueDate: Date;
// 		DFormula: DateFormula;
// 		SendDEMail: Boolean;
// 		Cust: Record UnknownRecord51516223;
// 		GenSetUp: Record "HR Leave Planner Lines";
// 		LoanT: Decimal;
// 		LoanEndDate: Date;
// 		ADDEDDATE: Integer;
// 		Cust2: Record "HR Calendar List";
// 		currentShares: Decimal;
// 		text1: label 'We note with concern that your loan has fallen into arrears due to monthly repayments not having been remitted to your account. The total outstanding loan together with accrued interest to date amount to ';
// 		text2: label 'Consequently, we do hereby request you to pay your defaulted loan balance in full within 14 days from the date of this letter failure to which we shall proceed to recover the same from your shares being held by us to off set the outstanding loans.Your cooperation and immediate response will be appreciated.Yours faithfully. UNSACCO';
// 		perfoming: Decimal;
// 		Loans_Aging_AnalysisCaptionLbl: label 'Loans Aging Analysis';
// 		CurrReport_PAGENOCaptionLbl: label 'Page';
// 		Loan_TypeCaptionLbl: label 'Loan Type';
// 		Current_SharesCaptionLbl: label 'Current Shares';
// 		Oustanding_BalanceCaptionLbl: label 'Oustanding Balance';
// 		V2___3_MonthsCaptionLbl: label '2 - 3 Months';
// 		V1___2_MonthsCaptionLbl: label '1 - 2 Months';
// 		Over_3_MonthsCaptionLbl: label 'Over 3 Months';
// 		Interest_DueCaptionLbl: label 'Interest Due';
// 		Company: Record "Company Information";

// 	// --> Reports ForNAV Autogenerated code - do not delete or modify
// 	var 
// 		[WithEvents]
// 		ReportForNav : DotNet ForNavReport51516375_v6_3_0_2259;
// 		ReportForNavOpenDesigner : Boolean;
// 		[InDataSet]
// 		ReportForNavAllowDesign : Boolean;

// 	local procedure ReportsForNavInit();
// 	var
// 		ApplicationSystemConstants: Codeunit "Application System Constants";
// 		addInFileName : Text;
// 		tempAddInFileName : Text;
// 		path: DotNet Path;
// 		ReportForNavObject: Variant;
// 	begin
// 		addInFileName := ApplicationPath() + 'Add-ins\ReportsForNAV_6_3_0_2259\ForNav.Reports.6.3.0.2259.dll';
// 		if not File.Exists(addInFileName) then begin
// 			tempAddInFileName := path.GetTempPath() + '\Microsoft Dynamics NAV\Add-Ins\' + ApplicationSystemConstants.PlatformFileVersion() + '\ForNav.Reports.6.3.0.2259.dll';
// 			if not File.Exists(tempAddInFileName) then
// 				Error('Please install the ForNAV DLL version 6.3.0.2259 in your service tier Add-ins folder under the file name "%1"\\If you already have the ForNAV DLL on the server, you should move it to this folder and rename it to match this file name.', addInFileName);
// 		end;
// 		ReportForNavObject := ReportForNav.GetLatest(CurrReport.OBJECTID, CurrReport.Language, SerialNumber, UserId, CompanyName);
// 		ReportForNav := ReportForNavObject;
// 		ReportForNav.Init();
// 	end;

// 	local procedure ReportsForNavPre();
// 	begin
// 		ReportForNav.OpenDesigner:=ReportForNavOpenDesigner;
// 		if not ReportForNav.Pre() then CurrReport.Quit();
// 	end;

// 	// Reports ForNAV Autogenerated code - do not delete or modify -->
// }
