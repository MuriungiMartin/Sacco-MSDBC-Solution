// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
// dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
// {	
// 	assembly("ForNav.Reports.6.3.0.2259")
// 	{
// 		type(ForNav.Report_6_3_0_2259; ForNavReport51516480_v6_3_0_2259){}   
// 	}
// } // Reports ForNAV Autogenerated code - do not delete or modify -->

// Report 50480 "Validate Checkoff-Distributed"
// {
// 	RDLCLayout = './Layouts/ValidateCheckoff-Distributed.rdlc'; DefaultLayout = RDLC;

// 	dataset
// 	{
// 		dataitem("Checkoff Lines-Distributed";"Checkoff Lines-Distributed")
// 		{
// 			column(ReportForNavId_1000000000; 1000000000) {} // Autogenerated by ForNav - Do not delete
// 			trigger OnAfterGetRecord();
// 			begin
// 				/*RcptHeader.RESET;
// 				RcptHeader.SETRANGE(RcptHeader.No,"Receipt Header No");
// 				IF RcptHeader.FIND('-') THEN BEGIN
// 				 REPEAT*/
// 				  /*Employees.RESET;
// 				  Employees.SETRANGE(Employees.Userid1,USERID);
// 				  IF Employees.FIND('-') THEN BEGIN
// 					SETRANGE(Userid1,USERID);*/
// 					Cust.Reset;
// 					Cust.SetRange(Cust."Payroll No","Payroll No");
// 					//Cust.SETRANGE(Cust."Employer Code",DEPT);
// 					//Cust.SETRANGE(Cust."Date Filter",ASATDATE);
// 					if Cust.Find('-') then begin
// 					 repeat
// 					  Cust.CalcFields(Cust."Current Shares");
// 					  INSURANCE:=Cust."No.";
// 					  IL_P:=Cust.Name;
// 					  SFL_P:=Cust."Monthly Contribution";
// 					  SHARES:="Employee Name"+SFL_P;
// 					  SFL_I:=Cust."FOSA Account No.";
// 					  Modify;
// 					 until Cust.Next=0;
// 					end;
// 				if SPL_P ='SLOAN' then begin
// 					LoanType.Reset;
// 					LoanType.SetRange(LoanType."Special Code",SPL_I);
// 					  if LoanType.Find('-') then begin
// 						THIRDPARTY:=LoanType.Code;
// 						 Modify;
// 					  end;
// 				   end;
// 					BaldateTXT:='01/01/10..'+Format(ASATDATE);
// 					Loans.Reset;
// 					//Loans.SETRANGE(Loans."Staff No","Staff/Payroll No");
// 					Loans.SetRange(Loans."Client Name",IL_P);
// 					//Loans.SETRANGE(Loans."Account No","FOSA Account");
// 					//Loans.SETRANGE(Loans."Employer Code",DEPT);
// 					Loans.SetRange(Loans."Loan Product Type",THIRDPARTY);
// 					//loans.SETFILTER(loans."Date filter",BaldateTXT);
// 					  if Loans.Find('-') then begin
// 					  repeat
// 						Loans.CalcFields(Loans."Outstanding Balance");
// 						if Loans."Outstanding Balance">0 then begin
// 						  MSL_I:=Loans."Loan  No.";
// 						  if "Checkoff Lines-Distributed".SPL_P='REPAYMENT'then begin
// 							 if Loans."Adjted Repayment"<>0 then
// 							 SFL_P:=Loans."Adjted Repayment"
// 							 else
// 							SFL_P:=Loans."Loan Principle Repayment";
// 							SHARES:="Employee Name"-SFL_P;
// 							end;
// 							Modify;
// 						end;
// 					  until Loans.Next=0;
// 					  end;
// 					if "Checkoff Lines-Distributed".MSL_I='' then begin
// 					  "Checkoff Lines-Distributed".TL_I:=true;
// 					  Modify;
// 					  Loans.Reset;
// 					  Loans.SetRange(Loans."Staff No","Payroll No");
// 					  Loans.SetRange(Loans."Client Code",INSURANCE);
// 					  //loans.SETRANGE(loans."Company Code",DEPT);
// 					  Loans.SetRange(Loans."Loan Product Type",THIRDPARTY);
// 					  Loans.SetRange(Loans.Posted,true);
// 					  if Loans.Find('-') then begin
// 						repeat
// 						  Loans.CalcFields(Loans."Outstanding Balance");
// 						  if Loans."Outstanding Balance">0 then begin
// 						  MSL_I:=Loans."Loan  No.";
// 						  Modify;
// 						  end;
// 						until Loans.Next=0;
// 					  end;
// 					end;
// 				//Overpay the Last Loan the Member has taken
// 				  if "Checkoff Lines-Distributed".MSL_I='' then begin
// 					  "Checkoff Lines-Distributed".TL_I:=true;
// 					  Modify;
// 					  Loans.Reset;
// 					  Loans.SetRange(Loans."Staff No","Payroll No");
// 					  Loans.SetRange(Loans."Client Code",INSURANCE);
// 					  //loans.SETRANGE(loans."Company Code",DEPT);
// 					  Loans.SetRange(Loans."Loan Product Type",THIRDPARTY);
// 					  Loans.SetRange(Loans.Posted,true);
// 					  if Loans.FindLast then begin
// 						repeat
// 						  Loans.CalcFields(Loans."Outstanding Balance");
// 						  MSL_I:=Loans."Loan  No.";
// 						  Modify;
// 						until Loans.Next=0;
// 					  end;
// 					end;
// 					// interest underpayment
// 					Loans.Reset;
// 					Loans.SetRange(Loans."Client Code",INSURANCE);
// 					Loans.SetRange(Loans."Loan Product Type",THIRDPARTY);
// 					Loans.SetRange(Loans."Loan  No.",MSL_I);
// 					if Loans.Find('-') then begin
// 					 repeat
// 					  Loans.CalcFields(Loans."Outstanding Balance");
// 					  if Loans."Outstanding Balance">0 then begin
// 						MSL_I:=Loans."Loan  No.";
// 						  if "Checkoff Lines-Distributed".SPL_P='INTEREST PAID'then begin
// 						  SFL_P:=Loans."Outstanding Balance"*0.01;
// 						  SHARES:="Employee Name"-SFL_P;
// 						  end;
// 						Modify;
// 					  end;
// 					 until Loans.Next=0;
// 					end;
// 				  //END;
// 				/*UNTIL RcptHeader.NEXT=0;
// 				END;*/

// 			end;

// 		}
// 	}

// 	requestpage
// 	{


// 		SaveValues = false;	  layout
// 		{
// 			area(content)
// 			{
// 				field(ASATDATE;ASATDATE)
// 				{
// 					ApplicationArea = Basic;
// 					Caption = 'As At';
// 				}
// 				field(ForNavOpenDesigner;ReportForNavOpenDesigner)
// 				{
// 					ApplicationArea = Basic;
// 					Caption = 'Design';
// 					Visible = ReportForNavAllowDesign;
// 						trigger OnValidate()
// 						begin
// 							ReportForNav.LaunchDesigner(ReportForNavOpenDesigner);
// 							CurrReport.RequestOptionsPage.Close();
// 						end;

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
// 		;ReportsForNavInit;

// 	end;

// 	trigger OnPostReport()
// 	begin
// 		;ReportForNav.Post;
// 	end;

// 	trigger OnPreReport()
// 	begin
// 		;ReportsForNavPre;
// 	end;
// 	var
// 		Rcpt: Record "Checkoff Lines-Distributed";
// 		PNo: Integer;
// 		Cust: Record "Members Register";
// 		Dept: Code[10];
// 		Loans: Record "Loans Register";
// 		LoanType: Record "Loan Products Setup";
// 		Pdate: Date;
// 		Variance: Decimal;
// 		ASATDATE: Date;
// 		BaldateTXT: Text[30];
// 		Baldate: Date;
// 		Employees: Record "Checkoff Lines-Distributed";
// 		RcptHeader: Record "Checkoff Header-Distributed";

// 	// --> Reports ForNAV Autogenerated code - do not delete or modify
// 	var 
// 		[WithEvents]
// 		ReportForNav : DotNet ForNavReport51516480_v6_3_0_2259;
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
