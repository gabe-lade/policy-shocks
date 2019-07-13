***************************************************************
* POLICY SHOCKS AND RIN PRICES
* ROBUSTNESS CHECKS: RINS RESULTS
* CODE BY: GABRIEL LADE  
* LAST MAJOR UPDATE: 02/17/2019
***************************************************************   		

********************************************************************************
*RINS ROBUST 1 - ALTERNATIVE NORMAL RETURNS  
********************************************************************************
eststo clear
*Column 1: Conventional RINs - No Time Controls
	eststo: newey d.lprin_eth13 d.lrbob_n14 d.lcorn_n14 ///
	        d.lsug_n14 d.lsoy_n14 d.lng_n14 ///
		    fr13_0-fr13_4 leak14_0-leak14_4 pr14_0-pr14_4 if sample_main==1, lag(5)
		*Storing even study estimates	
		estadd scalar fr13_0 = _b[fr13_0]
		estadd scalar fr13_1 = _b[fr13_1]
		estadd scalar fr13_2 = _b[fr13_2]
		estadd scalar fr13_3 = _b[fr13_3]
		estadd scalar fr13_4 = _b[fr13_4]
		estadd scalar leak14_0 = _b[leak14_0]
		estadd scalar leak14_1 = _b[leak14_1]
		estadd scalar leak14_2 = _b[leak14_2]
		estadd scalar leak14_3 = _b[leak14_3]
		estadd scalar leak14_4 = _b[leak14_4]
		estadd scalar pr14_0 = _b[pr14_0]
		estadd scalar pr14_1 = _b[pr14_1]
		estadd scalar pr14_2 = _b[pr14_2]
		estadd scalar pr14_3 = _b[pr14_3]
		estadd scalar pr14_4 = _b[pr14_4]

		*Storing regression descriptor
		estadd local time "No"

		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if sample_main==1, xb
		gen e=d.lprin_eth13-xb if sample_main==1		
			replace e=. if t>=1344 & t<1349 //2013 Final Rule
			replace e=. if t>=1391 & t<1396 //Reuters Article
			replace e=. if t>=1416 & t<1421 //2013 Final Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)	
	drop xb e
	est store A

*Column 2: Conventional RINs - Time Controls
	eststo: newey d.lprin_eth13 d.lrbob_n14 d.lcorn_n14 ///
	        d.lsug_n14 d.lsoy_n14 d.lng_n14 ///
		    fr13_0-fr13_4 leak14_0-leak14_4 pr14_0-pr14_4 ///
			t t2-t4 i.day i.month if sample_main==1, lag(5)		
		*Storing even study estimates	
		estadd scalar fr13_0 = _b[fr13_0]
		estadd scalar fr13_1 = _b[fr13_1]
		estadd scalar fr13_2 = _b[fr13_2]
		estadd scalar fr13_3 = _b[fr13_3]
		estadd scalar fr13_4 = _b[fr13_4]
		estadd scalar leak14_0 = _b[leak14_0]
		estadd scalar leak14_1 = _b[leak14_1]
		estadd scalar leak14_2 = _b[leak14_2]
		estadd scalar leak14_3 = _b[leak14_3]
		estadd scalar leak14_4 = _b[leak14_4]
		estadd scalar pr14_0 = _b[pr14_0]
		estadd scalar pr14_1 = _b[pr14_1]
		estadd scalar pr14_2 = _b[pr14_2]
		estadd scalar pr14_3 = _b[pr14_3]
		estadd scalar pr14_4 = _b[pr14_4]

		*Storing regression descriptor
		estadd local time "Yes"

		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if sample_main==1, xb
		gen e=d.lprin_eth13-xb if sample_main==1		
			replace e=. if t>=1344 & t<1349 //2013 Final Rule
			replace e=. if t>=1391 & t<1396 //Reuters Article
			replace e=. if t>=1416 & t<1421 //2013 Final Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)
	drop xb e
	est store B

*Column 3: Advanced RINs - No Controls
	eststo: newey d.lprin_adv13 d.lrbob_n14 d.lcorn_n14 ///
	        d.lsug_n14 d.lsoy_n14 d.lng_n14 ///
		    fr13_0-fr13_4 leak14_0-leak14_4 pr14_0-pr14_4 if sample_main==1, lag(5)
		*Storing even study estimates	
		estadd scalar fr13_0 = _b[fr13_0]
		estadd scalar fr13_1 = _b[fr13_1]
		estadd scalar fr13_2 = _b[fr13_2]
		estadd scalar fr13_3 = _b[fr13_3]
		estadd scalar fr13_4 = _b[fr13_4]
		estadd scalar leak14_0 = _b[leak14_0]
		estadd scalar leak14_1 = _b[leak14_1]
		estadd scalar leak14_2 = _b[leak14_2]
		estadd scalar leak14_3 = _b[leak14_3]
		estadd scalar leak14_4 = _b[leak14_4]
		estadd scalar pr14_0 = _b[pr14_0]
		estadd scalar pr14_1 = _b[pr14_1]
		estadd scalar pr14_2 = _b[pr14_2]
		estadd scalar pr14_3 = _b[pr14_3]
		estadd scalar pr14_4 = _b[pr14_4]

		*Storing regression descriptor
		estadd local time "No"

		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if sample_main==1, xb
		gen e=d.lprin_adv13-xb if sample_main==1		
			replace e=. if t>=1344 & t<1349 //2013 Final Rule
			replace e=. if t>=1391 & t<1396 //Reuters Article
			replace e=. if t>=1416 & t<1421 //2013 Final Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)
	drop xb e
	est store C

*Column 4: Advanced RINs - Time Controls
	eststo: newey d.lprin_adv13 d.lrbob_n14 d.lcorn_n14 ///
	        d.lsug_n14 d.lsoy_n14 d.lng_n14 ///
			fr13_0-fr13_4 leak14_0-leak14_4 pr14_0-pr14_4 ///
			t t2-t4 i.day i.month if sample_main==1, lag(5)
		*Storing even study estimates	
		estadd scalar fr13_0 = _b[fr13_0]
		estadd scalar fr13_1 = _b[fr13_1]
		estadd scalar fr13_2 = _b[fr13_2]
		estadd scalar fr13_3 = _b[fr13_3]
		estadd scalar fr13_4 = _b[fr13_4]
		estadd scalar leak14_0 = _b[leak14_0]
		estadd scalar leak14_1 = _b[leak14_1]
		estadd scalar leak14_2 = _b[leak14_2]
		estadd scalar leak14_3 = _b[leak14_3]
		estadd scalar leak14_4 = _b[leak14_4]
		estadd scalar pr14_0 = _b[pr14_0]
		estadd scalar pr14_1 = _b[pr14_1]
		estadd scalar pr14_2 = _b[pr14_2]
		estadd scalar pr14_3 = _b[pr14_3]
		estadd scalar pr14_4 = _b[pr14_4]

		*Storing regression descriptor
		estadd local time "Yes"

		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if sample_main==1, xb
		gen e=d.lprin_adv13-xb if sample_main==1		
			replace e=. if t>=1344 & t<1349 //2013 Final Rule
			replace e=. if t>=1391 & t<1396 //Reuters Article
			replace e=. if t>=1416 & t<1421 //2013 Final Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)	
	drop xb e
	est store D
	
*Column 5: Biodiesel RINs - No Controls
	eststo: newey d.lprin_bio13 d.lulsd_n14 d.lcorn_n14 ///
	        d.lsug_n14 d.lsoy_n14 d.lng_n14 ///
		    fr13_0-fr13_4 leak14_0-leak14_4 pr14_0-pr14_4 if sample_main==1, lag(5)
		*Storing even study estimates	
		estadd scalar fr13_0 = _b[fr13_0]
		estadd scalar fr13_1 = _b[fr13_1]
		estadd scalar fr13_2 = _b[fr13_2]
		estadd scalar fr13_3 = _b[fr13_3]
		estadd scalar fr13_4 = _b[fr13_4]
		estadd scalar leak14_0 = _b[leak14_0]
		estadd scalar leak14_1 = _b[leak14_1]
		estadd scalar leak14_2 = _b[leak14_2]
		estadd scalar leak14_3 = _b[leak14_3]
		estadd scalar leak14_4 = _b[leak14_4]
		estadd scalar pr14_0 = _b[pr14_0]
		estadd scalar pr14_1 = _b[pr14_1]
		estadd scalar pr14_2 = _b[pr14_2]
		estadd scalar pr14_3 = _b[pr14_3]
		estadd scalar pr14_4 = _b[pr14_4]

		*Storing regression descriptor
		estadd local time "No"

		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if sample_main==1, xb
		gen e=d.lprin_bio13-xb if sample_main==1		
			replace e=. if t>=1344 & t<1349 //2013 Final Rule
			replace e=. if t>=1391 & t<1396 //Reuters Article
			replace e=. if t>=1416 & t<1421 //2013 Final Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)	
	drop xb e
	est store E

*Column 6: Biodiesel RINs - Time Controls
	eststo: newey d.lprin_bio13 d.lulsd_n14 d.lcorn_n14 ///
	        d.lsug_n14 d.lsoy_n14 d.lng_n14 ///
		    fr13_0-fr13_4 leak14_0-leak14_4 pr14_0-pr14_4 ///
			 t t2-t4 i.day i.month if sample_main==1, lag(5)
		*Storing even study estimates	
		estadd scalar fr13_0 = _b[fr13_0]
		estadd scalar fr13_1 = _b[fr13_1]
		estadd scalar fr13_2 = _b[fr13_2]
		estadd scalar fr13_3 = _b[fr13_3]
		estadd scalar fr13_4 = _b[fr13_4]
		estadd scalar leak14_0 = _b[leak14_0]
		estadd scalar leak14_1 = _b[leak14_1]
		estadd scalar leak14_2 = _b[leak14_2]
		estadd scalar leak14_3 = _b[leak14_3]
		estadd scalar leak14_4 = _b[leak14_4]
		estadd scalar pr14_0 = _b[pr14_0]
		estadd scalar pr14_1 = _b[pr14_1]
		estadd scalar pr14_2 = _b[pr14_2]
		estadd scalar pr14_3 = _b[pr14_3]
		estadd scalar pr14_4 = _b[pr14_4]

		*Storing regression descriptor
		estadd local time "Yes"

		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if sample_main==1, xb
		gen e=d.lprin_bio13-xb if sample_main==1		
			replace e=. if t>=1344 & t<1349 //2013 Final Rule
			replace e=. if t>=1391 & t<1396 //Reuters Article
			replace e=. if t>=1416 & t<1421 //2013 Final Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)
	drop xb e
	est store F
	
esttab A B C D E F using $tables\rinregs_robust_$outputdate.tex, replace label ///
    booktabs b(a2) nonumber ///
	drop(_cons fr13* leak14* pr14* t* 1.* 2.* 3.* 4.* 5.* 6.* 7.* 8.* ///
		 9.* 10.* 11.* 12.*) ///
    starlevels(* 0.10 ** 0.05 *** 0.01) ///
	title(RIN Event Study Regression Results \\ ///
	(Dependent Variable: Log Differenced 2013 RIN Prices) \label{table:rin_robust1})  ///
	cells(b(fmt(3) star) se(fmt(3) par)) ///
	scalars("fr13_0 2013 Final Rule: Day 0" "fr13_1   Day 1" ///
		    "fr13_2 Day 2" "fr13_3  Day 3" ///
			"fr13_4 Day 4" "leak14_0 Reuters Article: Day 0" ///
		    "leak14_1 Day 1" "leak14_2 Day 2" ///
		    "leak14_3 Day 3" "leak14_4 Day 4" ///
	        "pr14_0 2014 Proposed Rule: Day 0" "pr14_1 Day 1" ///
	        "pr14_2 Day 2" "pr14_3 Day 3" ///
			"pr14_4 Day 4" "time Time Controls" ///
			"sq10_lb SQ 10\% Lower Bound" "sq10_ub SQ 10\% Upper Bound" /// 
			"sq5_lb SQ 5\% Lower Bound" "sq5_ub SQ 5\% Upper Bound" /// 
			"sq1_lb SQ 1\% Lower Bound" "sq1_ub SQ 1\% Upper Bound") ///		
	 varlabels(D.lrbob_n14 "RBOB Futures" D.lulsd_n14 "ULSD Futures" ///
	           D.lcorn_n14 "Corn Futures" D.lsug_n14 "Sugar Futures" ///
			   D.lsug_n14 "Sugar Futures" D.lsoy_n14 "Soybean Oil Futures" ///
			   D.lng_n14 "Natural Gas Futures") sfmt(3) ///	
	 mlabels((1) (2) (3) (4) (5) (6)) collabels(none) ///
	 note(Notes: Normal return standard errors in parentheses are Newey-West errors ///
	      with 5 lags. Inference for abnormal returns are based on  ///
	      sample quantile critical values given at the bottom of the table ///
		  \citep{Gelbach1}. *, **, and ***  denote significance at the ///
		  10\%, 5\%, and 1\% confidence  levels, respectively.)  


********************************************************************************
*RINS ROBUSTNESS 2 - LEVELS  
********************************************************************************
eststo clear
*Column 1: Conventional RINs - No Controls
	eststo: newey d.prin_eth13 d.wti_n14 d.eth_n14 d.soy_n14 ///
		    fr13_0-fr13_4 leak14_0-leak14_4 pr14_0-pr14_4 if sample_main==1, lag(21)
		*Storing even study estimates	
		estadd scalar fr13_0 = _b[fr13_0]
		estadd scalar fr13_1 = _b[fr13_1]
		estadd scalar fr13_2 = _b[fr13_2]
		estadd scalar fr13_3 = _b[fr13_3]
		estadd scalar fr13_4 = _b[fr13_4]
		estadd scalar leak14_0 = _b[leak14_0]
		estadd scalar leak14_1 = _b[leak14_1]
		estadd scalar leak14_2 = _b[leak14_2]
		estadd scalar leak14_3 = _b[leak14_3]
		estadd scalar leak14_4 = _b[leak14_4]
		estadd scalar pr14_0 = _b[pr14_0]
		estadd scalar pr14_1 = _b[pr14_1]
		estadd scalar pr14_2 = _b[pr14_2]
		estadd scalar pr14_3 = _b[pr14_3]
		estadd scalar pr14_4 = _b[pr14_4]

		*Storing regression descriptor
		estadd local time "No"

		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if sample_main==1, xb
		gen e=d.prin_eth13-xb if sample_main==1		
			replace e=. if t>=1344 & t<1349 //2013 Final Rule
			replace e=. if t>=1391 & t<1396 //Reuters Article
			replace e=. if t>=1416 & t<1421 //2013 Final Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)	
	drop xb e
	est store A

*Column 2: Conventional RINs - Time Controls
	eststo: newey d.prin_eth13 d.wti_n14 d.eth_n14 d.soy_n14 ///
		    fr13_0-fr13_4 leak14_0-leak14_4 pr14_0-pr14_4 ///
			t t2-t4 i.day i.month if sample_main==1, lag(5)		
		*Storing even study estimates	
		estadd scalar fr13_0 = _b[fr13_0]
		estadd scalar fr13_1 = _b[fr13_1]
		estadd scalar fr13_2 = _b[fr13_2]
		estadd scalar fr13_3 = _b[fr13_3]
		estadd scalar fr13_4 = _b[fr13_4]
		estadd scalar leak14_0 = _b[leak14_0]
		estadd scalar leak14_1 = _b[leak14_1]
		estadd scalar leak14_2 = _b[leak14_2]
		estadd scalar leak14_3 = _b[leak14_3]
		estadd scalar leak14_4 = _b[leak14_4]
		estadd scalar pr14_0 = _b[pr14_0]
		estadd scalar pr14_1 = _b[pr14_1]
		estadd scalar pr14_2 = _b[pr14_2]
		estadd scalar pr14_3 = _b[pr14_3]
		estadd scalar pr14_4 = _b[pr14_4]

		*Storing regression descriptor
		estadd local time "Yes"

		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if sample_main==1, xb
		gen e=d.prin_eth13-xb if sample_main==1		
			replace e=. if t>=1344 & t<1349 //2013 Final Rule
			replace e=. if t>=1391 & t<1396 //Reuters Article
			replace e=. if t>=1416 & t<1421 //2013 Final Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)
	drop xb e
	est store B

*Column 3: Advanced RINs - No Controls
	eststo: newey d.prin_adv13 d.wti_n14 d.eth_n14 d.soy_n14 ///
		    fr13_0-fr13_4 leak14_0-leak14_4 pr14_0-pr14_4 if sample_main==1, lag(5)
		*Storing even study estimates	
		estadd scalar fr13_0 = _b[fr13_0]
		estadd scalar fr13_1 = _b[fr13_1]
		estadd scalar fr13_2 = _b[fr13_2]
		estadd scalar fr13_3 = _b[fr13_3]
		estadd scalar fr13_4 = _b[fr13_4]
		estadd scalar leak14_0 = _b[leak14_0]
		estadd scalar leak14_1 = _b[leak14_1]
		estadd scalar leak14_2 = _b[leak14_2]
		estadd scalar leak14_3 = _b[leak14_3]
		estadd scalar leak14_4 = _b[leak14_4]
		estadd scalar pr14_0 = _b[pr14_0]
		estadd scalar pr14_1 = _b[pr14_1]
		estadd scalar pr14_2 = _b[pr14_2]
		estadd scalar pr14_3 = _b[pr14_3]
		estadd scalar pr14_4 = _b[pr14_4]

		*Storing regression descriptor
		estadd local time "No"

		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if sample_main==1, xb
		gen e=d.prin_adv13-xb if sample_main==1		
			replace e=. if t>=1344 & t<1349 //2013 Final Rule
			replace e=. if t>=1391 & t<1396 //Reuters Article
			replace e=. if t>=1416 & t<1421 //2013 Final Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)
	drop xb e
	est store C

*Column 4: Advanced RINs - Time Controls
	eststo: newey d.prin_adv13 d.wti_n14 d.eth_n14 d.soy_n14 ///
		    fr13_0-fr13_4 leak14_0-leak14_4 pr14_0-pr14_4 ///
			t t2-t4 i.day i.month if sample_main==1, lag(5)
		*Storing even study estimates	
		estadd scalar fr13_0 = _b[fr13_0]
		estadd scalar fr13_1 = _b[fr13_1]
		estadd scalar fr13_2 = _b[fr13_2]
		estadd scalar fr13_3 = _b[fr13_3]
		estadd scalar fr13_4 = _b[fr13_4]
		estadd scalar leak14_0 = _b[leak14_0]
		estadd scalar leak14_1 = _b[leak14_1]
		estadd scalar leak14_2 = _b[leak14_2]
		estadd scalar leak14_3 = _b[leak14_3]
		estadd scalar leak14_4 = _b[leak14_4]
		estadd scalar pr14_0 = _b[pr14_0]
		estadd scalar pr14_1 = _b[pr14_1]
		estadd scalar pr14_2 = _b[pr14_2]
		estadd scalar pr14_3 = _b[pr14_3]
		estadd scalar pr14_4 = _b[pr14_4]

		*Storing regression descriptor
		estadd local time "Yes"

		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if sample_main==1, xb
		gen e=d.prin_adv13-xb if sample_main==1		
			replace e=. if t>=1344 & t<1349 //2013 Final Rule
			replace e=. if t>=1391 & t<1396 //Reuters Article
			replace e=. if t>=1416 & t<1421 //2013 Final Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)
	drop xb e
	est store D
	
*Column 5: Biodiesel RINs - No Controls
	eststo: newey d.prin_bio13 d.wti_n14 d.eth_n14 d.soy_n14 ///
		    fr13_0-fr13_4 leak14_0-leak14_4 pr14_0-pr14_4 if sample_main==1, lag(5)
		*Storing even study estimates	
		estadd scalar fr13_0 = _b[fr13_0]
		estadd scalar fr13_1 = _b[fr13_1]
		estadd scalar fr13_2 = _b[fr13_2]
		estadd scalar fr13_3 = _b[fr13_3]
		estadd scalar fr13_4 = _b[fr13_4]
		estadd scalar leak14_0 = _b[leak14_0]
		estadd scalar leak14_1 = _b[leak14_1]
		estadd scalar leak14_2 = _b[leak14_2]
		estadd scalar leak14_3 = _b[leak14_3]
		estadd scalar leak14_4 = _b[leak14_4]
		estadd scalar pr14_0 = _b[pr14_0]
		estadd scalar pr14_1 = _b[pr14_1]
		estadd scalar pr14_2 = _b[pr14_2]
		estadd scalar pr14_3 = _b[pr14_3]
		estadd scalar pr14_4 = _b[pr14_4]

		*Storing regression descriptor
		estadd local time "No"

		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if sample_main==1, xb
		gen e=d.prin_bio13-xb if sample_main==1		
			replace e=. if t>=1344 & t<1349 //2013 Final Rule
			replace e=. if t>=1391 & t<1396 //Reuters Article
			replace e=. if t>=1416 & t<1421 //2013 Final Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)	
	drop xb e
	est store E

*Column 6: Biodiesel RINs - Time Controls
	eststo: newey d.prin_bio13 d.wti_n14 d.eth_n14 d.soy_n14 ///
		    fr13_0-fr13_4 leak14_0-leak14_4 pr14_0-pr14_4 ///
			t t2-t4 i.day i.month if sample_main==1, lag(5)
		*Storing even study estimates	
		estadd scalar fr13_0 = _b[fr13_0]
		estadd scalar fr13_1 = _b[fr13_1]
		estadd scalar fr13_2 = _b[fr13_2]
		estadd scalar fr13_3 = _b[fr13_3]
		estadd scalar fr13_4 = _b[fr13_4]
		estadd scalar leak14_0 = _b[leak14_0]
		estadd scalar leak14_1 = _b[leak14_1]
		estadd scalar leak14_2 = _b[leak14_2]
		estadd scalar leak14_3 = _b[leak14_3]
		estadd scalar leak14_4 = _b[leak14_4]
		estadd scalar pr14_0 = _b[pr14_0]
		estadd scalar pr14_1 = _b[pr14_1]
		estadd scalar pr14_2 = _b[pr14_2]
		estadd scalar pr14_3 = _b[pr14_3]
		estadd scalar pr14_4 = _b[pr14_4]

		*Storing regression descriptor
		estadd local time "Yes"

		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if sample_main==1, xb
		gen e=d.prin_bio13-xb if sample_main==1		
			replace e=. if t>=1344 & t<1349 //2013 Final Rule
			replace e=. if t>=1391 & t<1396 //Reuters Article
			replace e=. if t>=1416 & t<1421 //2013 Final Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)
	drop xb e
	est store F
	
esttab A B C D E F using $tables\rin_robust_levels_$outputdate.tex, replace label ///
    booktabs b(a2) nonumber ///
	drop(_cons fr13* leak14* pr14* t* 1.* 2.* 3.* 4.* 5.* 6.* 7.* 8.* ///
		 9.* 10.* 11.* 12.*) ///
    starlevels(* 0.10 ** 0.05 *** 0.01) ///
	title(RIN Event Study Regression Results \\ (Dependent Variable: Differenced 2013 RIN Prices) \label{table:rin_robust2})  ///
	cells(b(fmt(2) star) se(fmt(2) par)) ///
	scalars("fr13_0 2013 Final Rule: Day 0" "fr13_1   Day 1" ///
		    "fr13_2 Day 2" "fr13_3  Day 3" ///
			"fr13_4 Day 4" "leak14_0 Reuters Article: Day 0" ///
		    "leak14_1 Day 1" "leak14_2 Day 2" ///
		    "leak14_3 Day 3" "leak14_4 Day 4" ///
	        "pr14_0 2014 Proposed Rule: Day 0" "pr14_1 Day 1" ///
	        "pr14_2 Day 2" "pr14_3 Day 3" ///
			"pr14_4 Day 4" "time Time Controls" ///
			"sq10_lb SQ 10\% Lower Bound" "sq10_ub SQ 10\% Upper Bound" /// 
			"sq5_lb SQ 5\% Lower Bound" "sq5_ub SQ 5\% Upper Bound" /// 
			"sq1_lb SQ 1\% Lower Bound" "sq1_ub SQ 1\% Upper Bound") sfmt(2) ///		
	 varlabels(D.wti_n14 "Oil Futures" D.eth_n14 "Ethanol Futures" ///
	           D.soy_n14 "Soybean Oil Futures") ///	
	 mlabels((1) (2) (3) (4) (5) (6)) collabels(none) ///
	 note(Notes: Normal return standard errors in parentheses are Newey-West errors ///
	      with 5 lags. Inference for abnormal returns are based on  ///
	      sample quantile critical values given at the bottom of the table ///
		  \citep{Gelbach1}. *, **, and ***  denote significance at the ///
		  10\%, 5\%, and 1\% confidence  levels, respectively.)  
		  

********************************************************************************
*RINS ROBUSTNESS 3 - ALTERNATIVE TIME PERIODS   
********************************************************************************
eststo clear
*Column 1: Conventional RINs - Time Controls, Cont Contract (1/3/11-5/15/14)
 	eststo: newey d.lprin_eth_cont d.lwti_cont d.leth_cont d.lsoy_cont ///
		    fr13_0-fr13_4 leak14_0-leak14_4 pr14_0-pr14_4 ///
			t t2-t4 i.day i.month if sample_alt2==1, lag(5) 
	
		*Storing event study estimates	
		estadd scalar fr13_0 = _b[fr13_0]
		estadd scalar fr13_1 = _b[fr13_1]
		estadd scalar fr13_2 = _b[fr13_2]
		estadd scalar fr13_3 = _b[fr13_3]
		estadd scalar fr13_4 = _b[fr13_4]
		estadd scalar leak14_0 = _b[leak14_0]
		estadd scalar leak14_1 = _b[leak14_1]
		estadd scalar leak14_2 = _b[leak14_2]
		estadd scalar leak14_3 = _b[leak14_3]
		estadd scalar leak14_4 = _b[leak14_4]
		estadd scalar pr14_0 = _b[pr14_0]
		estadd scalar pr14_1 = _b[pr14_1]
		estadd scalar pr14_2 = _b[pr14_2]
		estadd scalar pr14_3 = _b[pr14_3]
		estadd scalar pr14_4 = _b[pr14_4]

		*Storing regression descriptor
		estadd local time "Yes"
		estadd local sample "1/3/11-5/15/14"

		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if e(sample), xb
		gen e=d.lprin_eth_cont-xb if e(sample)==1		
			replace e=. if t>=1344 & t<1349 //2013 Final Rule
			replace e=. if t>=1391 & t<1396 //Reuters Article
			replace e=. if t>=1416 & t<1421 //2013 Final Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)
	drop xb e
	est store A

*Column 2: Conventional RINs - Time Controls, 2013 RINs, 1/2/13-5/15/14
 	eststo: newey d.lprin_eth13 d.lwti_n14 d.leth_n14 d.lsoy_n14 ///
		    fr13_0-fr13_4 leak14_0-leak14_4 pr14_0-pr14_4 ///
			t t2-t4 i.day i.month if sample_alt1==1, lag(5)	  			
		*Storing even study estimates	
		estadd scalar fr13_0 = _b[fr13_0]
		estadd scalar fr13_1 = _b[fr13_1]
		estadd scalar fr13_2 = _b[fr13_2]
		estadd scalar fr13_3 = _b[fr13_3]
		estadd scalar fr13_4 = _b[fr13_4]
		estadd scalar leak14_0 = _b[leak14_0]
		estadd scalar leak14_1 = _b[leak14_1]
		estadd scalar leak14_2 = _b[leak14_2]
		estadd scalar leak14_3 = _b[leak14_3]
		estadd scalar leak14_4 = _b[leak14_4]
		estadd scalar pr14_0 = _b[pr14_0]
		estadd scalar pr14_1 = _b[pr14_1]
		estadd scalar pr14_2 = _b[pr14_2]
		estadd scalar pr14_3 = _b[pr14_3]
		estadd scalar pr14_4 = _b[pr14_4]

		*Storing regression descriptor
		estadd local time "Yes"
		estadd local sample "1/2/13-5/15/14"

		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if e(sample), xb
		gen e=d.lprin_eth13-xb if e(sample)	
			replace e=. if t>=1344 & t<1349 //2013 Final Rule
			replace e=. if t>=1391 & t<1396 //Reuters Article
			replace e=. if t>=1416 & t<1421 //2013 Final Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)
	drop xb e
	est store B

*Column 3: Advanced RINs - Time Controls, Cont Contract (1/3/11-5/15/14)
 	eststo: newey d.lprin_adv_cont d.lwti_cont d.leth_cont d.lsoy_cont ///
		    fr13_0-fr13_4 leak14_0-leak14_4 pr14_0-pr14_4 ///
			t t2-t4 i.day i.month if sample_alt2==1, lag(5) 
	
		*Storing event study estimates	
		estadd scalar fr13_0 = _b[fr13_0]
		estadd scalar fr13_1 = _b[fr13_1]
		estadd scalar fr13_2 = _b[fr13_2]
		estadd scalar fr13_3 = _b[fr13_3]
		estadd scalar fr13_4 = _b[fr13_4]
		estadd scalar leak14_0 = _b[leak14_0]
		estadd scalar leak14_1 = _b[leak14_1]
		estadd scalar leak14_2 = _b[leak14_2]
		estadd scalar leak14_3 = _b[leak14_3]
		estadd scalar leak14_4 = _b[leak14_4]
		estadd scalar pr14_0 = _b[pr14_0]
		estadd scalar pr14_1 = _b[pr14_1]
		estadd scalar pr14_2 = _b[pr14_2]
		estadd scalar pr14_3 = _b[pr14_3]
		estadd scalar pr14_4 = _b[pr14_4]

		*Storing regression descriptor
		estadd local time "Yes"
		estadd local sample "1/3/11-5/15/14"

		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if e(sample), xb
		gen e=d.lprin_adv_cont-xb if e(sample)==1		
			replace e=. if t>=1344 & t<1349 //2013 Final Rule
			replace e=. if t>=1391 & t<1396 //Reuters Article
			replace e=. if t>=1416 & t<1421 //2013 Final Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)
	drop xb e
	est store C

*Column 4: Advanced RINs - Time Controls, 2013 RINs, 1/2/13-5/15/14
 	eststo: newey d.lprin_adv13 d.lwti_n14 d.leth_n14 d.lsoy_n14 ///
		    fr13_0-fr13_4 leak14_0-leak14_4 pr14_0-pr14_4 ///
			t t2-t4 i.day i.month if sample_alt1==1, lag(5)	  			
		*Storing even study estimates	
		estadd scalar fr13_0 = _b[fr13_0]
		estadd scalar fr13_1 = _b[fr13_1]
		estadd scalar fr13_2 = _b[fr13_2]
		estadd scalar fr13_3 = _b[fr13_3]
		estadd scalar fr13_4 = _b[fr13_4]
		estadd scalar leak14_0 = _b[leak14_0]
		estadd scalar leak14_1 = _b[leak14_1]
		estadd scalar leak14_2 = _b[leak14_2]
		estadd scalar leak14_3 = _b[leak14_3]
		estadd scalar leak14_4 = _b[leak14_4]
		estadd scalar pr14_0 = _b[pr14_0]
		estadd scalar pr14_1 = _b[pr14_1]
		estadd scalar pr14_2 = _b[pr14_2]
		estadd scalar pr14_3 = _b[pr14_3]
		estadd scalar pr14_4 = _b[pr14_4]

		*Storing regression descriptor
		estadd local time "Yes"
		estadd local sample "1/2/13-5/15/14"

		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if e(sample), xb
		gen e=d.lprin_adv13-xb if e(sample)	
			replace e=. if t>=1344 & t<1349 //2013 Final Rule
			replace e=. if t>=1391 & t<1396 //Reuters Article
			replace e=. if t>=1416 & t<1421 //2013 Final Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)
	drop xb e
	est store D
	
*Column 5: Biodiesel RINs - Time Controls, Cont Contract (1/3/11-5/15/14)
 	eststo: newey d.lprin_bio_cont d.lwti_cont d.leth_cont d.lsoy_cont ///
		    fr13_0-fr13_4 leak14_0-leak14_4 pr14_0-pr14_4 ///
			t t2-t4 i.day i.month if sample_alt2==1, lag(5) 
	
		*Storing event study estimates	
		estadd scalar fr13_0 = _b[fr13_0]
		estadd scalar fr13_1 = _b[fr13_1]
		estadd scalar fr13_2 = _b[fr13_2]
		estadd scalar fr13_3 = _b[fr13_3]
		estadd scalar fr13_4 = _b[fr13_4]
		estadd scalar leak14_0 = _b[leak14_0]
		estadd scalar leak14_1 = _b[leak14_1]
		estadd scalar leak14_2 = _b[leak14_2]
		estadd scalar leak14_3 = _b[leak14_3]
		estadd scalar leak14_4 = _b[leak14_4]
		estadd scalar pr14_0 = _b[pr14_0]
		estadd scalar pr14_1 = _b[pr14_1]
		estadd scalar pr14_2 = _b[pr14_2]
		estadd scalar pr14_3 = _b[pr14_3]
		estadd scalar pr14_4 = _b[pr14_4]

		*Storing regression descriptor
		estadd local time "Yes"
		estadd local sample "1/3/11-5/15/14"

		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if e(sample), xb
		gen e=d.lprin_bio_cont-xb if e(sample)==1		
			replace e=. if t>=1344 & t<1349 //2013 Final Rule
			replace e=. if t>=1391 & t<1396 //Reuters Article
			replace e=. if t>=1416 & t<1421 //2013 Final Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)
	drop xb e
	est store E

*Column 6: Advanced RINs - Time Controls, 2013 RINs, 1/2/13-5/15/14
 	eststo: newey d.lprin_bio13 d.lwti_n14 d.leth_n14 d.lsoy_n14 ///
		    fr13_0-fr13_4 leak14_0-leak14_4 pr14_0-pr14_4 ///
			t t2-t4 i.day i.month if sample_alt1==1, lag(5)	  			
		*Storing even study estimates	
		estadd scalar fr13_0 = _b[fr13_0]
		estadd scalar fr13_1 = _b[fr13_1]
		estadd scalar fr13_2 = _b[fr13_2]
		estadd scalar fr13_3 = _b[fr13_3]
		estadd scalar fr13_4 = _b[fr13_4]
		estadd scalar leak14_0 = _b[leak14_0]
		estadd scalar leak14_1 = _b[leak14_1]
		estadd scalar leak14_2 = _b[leak14_2]
		estadd scalar leak14_3 = _b[leak14_3]
		estadd scalar leak14_4 = _b[leak14_4]
		estadd scalar pr14_0 = _b[pr14_0]
		estadd scalar pr14_1 = _b[pr14_1]
		estadd scalar pr14_2 = _b[pr14_2]
		estadd scalar pr14_3 = _b[pr14_3]
		estadd scalar pr14_4 = _b[pr14_4]

		*Storing regression descriptor
		estadd local time "Yes"
		estadd local sample "1/2/13-5/15/14"

		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if e(sample), xb
		gen e=d.lprin_bio13-xb if e(sample)	
			replace e=. if t>=1344 & t<1349 //2013 Final Rule
			replace e=. if t>=1391 & t<1396 //Reuters Article
			replace e=. if t>=1416 & t<1421 //2013 Final Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)
	drop xb e
	est store F
	
esttab A B C D E F using $tables\rin_robust_periods_$outputdate.tex, replace label ///
    booktabs b(a2) nonumber ///
	drop(_cons fr13* leak14* pr14* t* 1.* 2.* 3.* 4.* 5.* 6.* 7.* 8.* ///
		 9.* 10.* 11.* 12.*) ///
    starlevels(* 0.10 ** 0.05 *** 0.01) ///
	title(RIN Event Study Regression Results \\ (Dependent Variable: Differenced 2013 RIN Prices) \label{table:rin_robust3})  ///
	cells(b(fmt(3) star) se(fmt(3) par)) ///
	scalars("fr13_0 2013 Final Rule: Day 0" "fr13_1   Day 1" ///
		    "fr13_2 Day 2" "fr13_3  Day 3" ///
			"fr13_4 Day 4" "leak14_0 Reuters Article: Day 0" ///
		    "leak14_1 Day 1" "leak14_2 Day 2" ///
		    "leak14_3 Day 3" "leak14_4 Day 4" ///
	        "pr14_0 2014 Proposed Rule: Day 0" "pr14_1 Day 1" ///
	        "pr14_2 Day 2" "pr14_3 Day 3" ///
			"pr14_4 Day 4" "time Time Controls" "sample Sample" ///
			"sq10_lb SQ 10\% Lower Bound" "sq10_ub SQ 10\% Upper Bound" /// 
			"sq5_lb SQ 5\% Lower Bound" "sq5_ub SQ 5\% Upper Bound" /// 
			"sq1_lb SQ 1\% Lower Bound" "sq1_ub SQ 1\% Upper Bound") sfmt(3) ///		
	 varlabels(D.wti_n14 "Oil Futures" D.eth_n14 "Ethanol Futures" ///
	           D.soy_n14 "Soybean Oil Futures") ///	
	 mlabels((1) (2) (3) (4) (5) (6)) collabels(none) ///
	 note(Notes: Normal return standard errors in parentheses are Newey-West errors ///
	      with 5 lags. Inference for abnormal returns are based on  ///
	      sample quantile critical values given at the bottom of the table ///
		  \citep{Gelbach1}. *, **, and ***  denote significance at the ///
		  10\%, 5\%, and 1\% confidence  levels, respectively.)  
		  
		  
********************************************************************************
*CHANGE IN VALUE OF RVO - LEVELS SPECIFICATION
********************************************************************************
preserve
*Keeping only necessary variables for reshape
keep prin_eth13 prin_adv13 prin_bio13 ///
	 wti_n14 eth_n14 soy_n14 ///
	 fr13_0 fr13_1 fr13_2 fr13_3 fr13_4 ///
	 leak14_0 leak14_1 leak14_2 leak14_3 leak14_4 ///
	 pr14_0 pr14_1 pr14_2 pr14_3 pr14_4 pr14_5 ///
	 t t2-t6 day month date sample_main
	 
*Renaming RIN prices to prep for reshape
rename prin_adv13 prin1      // 1 is Advanced
rename prin_bio13 prin2  	 // 2 is Biodiesel
rename prin_eth13 prin3      // 3 is Ethanol

*Reshaping to long data form
reshape long prin, i(date t) j(cat)
sort t cat

*Creating category indicators
gen eth=0
	replace eth=1 if cat==3
gen adv=0
	replace adv=1 if cat==1
gen bio=0
	replace bio=1 if cat==2

*Creating differenced fuel prices
gen dwti=d.wti_n14
gen deth=d.eth_n14
gen dsoy=d.soy_n14

* Creating policy announcement interactions
local xvars fr13_0 fr13_1 fr13_2 fr13_3 fr13_4 leak14_0 leak14_1 leak14_2 ///
       leak14_3 leak14_4 pr14_0 pr14_1 pr14_2 pr14_3 pr14_4 ///
	   dwti deth dsoy
foreach x of local xvars {
	gen eth_`x'=eth*`x'
}
*	
foreach x of local xvars {
	gen adv_`x'=adv*`x'
}
*
foreach x of local xvars {
	gen bio_`x'=bio*`x'
}
*
*Generating month-by-year variable to cluster standard errors
gen year=year(date)
gen ym=ym(year,month)
	format ym %tm

*Setting panel data
xtset cat t

*Fully interacted regression
reg d.prin eth_* adv_* bio_* i.cat if sample_main==1, vce(cluster ym)

***********
*2013 Mandate Levels
*Notes:	 - 2013 Mandate Levels (ignoring 6 mgals of cellulosic):
*		     Undifferentiated Conventional = 13.8  bgals
*		     Undifferentialted Advance = 1.47  bgals
*            Biodiesel = 1.28 bgals
***********
local eth_man=13.8
local adv_man=1.47
local bio_man=1.28

***********
* Attributable Loss - 2013 Final Rule 
* Notes: - Released on 8/6/2016 (date=19576, t=1344)
***********
* Day 0 RVO Losses
lincom _b[eth_fr13_0]*`eth_man'/100 + ///
	   _b[adv_fr13_0]*`adv_man'/100 + ///
	   _b[bio_fr13_0]*`bio_man'/100 
	scalar fr13_d0=r(estimate)	
	scalar fr13_d0_lb= r(estimate)+invnorm(0.025)*r(se)
	scalar fr13_d0_ub=r(estimate)+invnorm(0.975)*r(se)	
	
	
* Day 0 - Day 2 RVO Losses
lincom (_b[eth_fr13_0]+_b[eth_fr13_1]+_b[eth_fr13_2])*`eth_man'/100 + ///
	   (_b[adv_fr13_0]+_b[adv_fr13_1]+_b[adv_fr13_2])*`adv_man'/100 + ///
	   (_b[bio_fr13_0]+_b[bio_fr13_1]+_b[bio_fr13_2])*`bio_man'/100 
	scalar fr13_d2=r(estimate)	
	scalar fr13_d2_lb= r(estimate)+invnorm(0.025)*r(se)
	scalar fr13_d2_ub=r(estimate)+invnorm(0.975)*r(se)	
	
* Day 0 - Day 4 RVO Losses
lincom (_b[eth_fr13_0]+_b[eth_fr13_1]+_b[eth_fr13_2]+_b[eth_fr13_3]+_b[eth_fr13_4])*`eth_man'/100 + ///
	   (_b[adv_fr13_0]+_b[adv_fr13_1]+_b[adv_fr13_2]+_b[adv_fr13_3]+_b[adv_fr13_4])*`adv_man'/100 + ///
	   (_b[bio_fr13_0]+_b[bio_fr13_1]+_b[bio_fr13_2]+_b[bio_fr13_3]+_b[bio_fr13_4])*`bio_man'/100 
 	scalar fr13_d4=r(estimate)	
	scalar fr13_d4_lb= r(estimate)+invnorm(0.025)*r(se)
	scalar fr13_d4_ub=r(estimate)+invnorm(0.975)*r(se)	
 
***********
* Attributable Loss - Reuters Article
* Notes: - Released on 10/11/2013 (date=19642, t=1391)
***********
* Day 0 RVO Losses
lincom _b[eth_leak14_0]*`eth_man'/100 + ///
	   _b[adv_leak14_0]*`adv_man'/100 + ///
	   _b[bio_leak14_0]*`bio_man'/100 
	scalar leak14_d0=r(estimate)	
	scalar leak14_d0_lb= r(estimate)+invnorm(0.025)*r(se)
	scalar leak14_d0_ub=r(estimate)+invnorm(0.975)*r(se)	
	
* Day 0 - Day 2 RVO Losses
lincom (_b[eth_leak14_0]+_b[eth_leak14_1]+_b[eth_leak14_2])*`eth_man'/100 + ///
	   (_b[adv_leak14_0]+_b[adv_leak14_1]+_b[adv_leak14_2])*`adv_man'/100 + ///
	   (_b[bio_leak14_0]+_b[bio_leak14_1]+_b[bio_leak14_2])*`bio_man'/100 
	scalar leak14_d2=r(estimate)	
	scalar leak14_d2_lb= r(estimate)+invnorm(0.025)*r(se)
	scalar leak14_d2_ub=r(estimate)+invnorm(0.975)*r(se)	
	
* Day 0 - Day 4 RVO Losses
lincom (_b[eth_leak14_0]+_b[eth_leak14_1]+_b[eth_leak14_2]+_b[eth_leak14_3]+_b[eth_leak14_4])*`eth_man'/100 + ///
	   (_b[adv_leak14_0]+_b[adv_leak14_1]+_b[adv_leak14_2]+_b[adv_leak14_3]+_b[adv_leak14_4])*`adv_man'/100 + ///
	   (_b[bio_leak14_0]+_b[bio_leak14_1]+_b[bio_leak14_2]+_b[bio_leak14_3]+_b[bio_leak14_4])*`bio_man'/100 
	scalar leak14_d4=r(estimate)	
	scalar leak14_d4_lb= r(estimate)+invnorm(0.025)*r(se)
	scalar leak14_d4_ub=r(estimate)+invnorm(0.975)*r(se)	 
 
***********
* Attributable Loss - 2014 Proposed Rule
* Notes: - Released on 11/15/2013 (date=19677, t=1416)
***********
* Day 0 RVO Losses
lincom _b[eth_pr14_0]*`eth_man'/100 + ///
	   _b[adv_pr14_0]*`adv_man'/100 + ///
	   _b[bio_pr14_0]*`bio_man'/100 
	scalar pr14_d0=r(estimate)	
	scalar pr14_d0_lb= r(estimate)+invnorm(0.025)*r(se)
	scalar pr14_d0_ub=r(estimate)+invnorm(0.975)*r(se)	
	
* Day 0 - Day 2 RVO Losses
lincom (_b[eth_pr14_0]+_b[eth_pr14_1]+_b[eth_pr14_2])*`eth_man'/100 + ///
	   (_b[adv_pr14_0]+_b[adv_pr14_1]+_b[adv_pr14_2])*`adv_man'/100 + ///
	   (_b[bio_pr14_0]+_b[bio_pr14_1]+_b[bio_pr14_2])*`bio_man'/100 
	scalar pr14_d2=r(estimate)	
	scalar pr14_d2_lb= r(estimate)+invnorm(0.025)*r(se)
	scalar pr14_d2_ub=r(estimate)+invnorm(0.975)*r(se)	
	
* Day 0 - Day 4 RVO Losses
lincom (_b[eth_pr14_0]+_b[eth_pr14_1]+_b[eth_pr14_2]+_b[eth_pr14_3]+_b[eth_pr14_4])*`eth_man'/100 + ///
	   (_b[adv_pr14_0]+_b[adv_pr14_1]+_b[adv_pr14_2]+_b[adv_pr14_3]+_b[adv_pr14_4])*`adv_man'/100 + ///
	   (_b[bio_pr14_0]+_b[bio_pr14_1]+_b[bio_pr14_2]+_b[bio_pr14_3]+_b[bio_pr14_4])*`bio_man'/100 
	scalar pr14_d4=r(estimate)	
	scalar pr14_d4_lb= r(estimate)+invnorm(0.025)*r(se)
	scalar pr14_d4_ub=r(estimate)+invnorm(0.975)*r(se)	
	
*Creating matrix
matrix A = (scalar(fr13_d0),scalar(fr13_d0_lb),scalar(fr13_d0_ub) \ ///
            scalar(fr13_d2),scalar(fr13_d2_lb),scalar(fr13_d2_ub) \ ///
            scalar(fr13_d4),scalar(fr13_d4_lb),scalar(fr13_d4_ub) \ ///
            scalar(leak14_d0),scalar(leak14_d0_lb),scalar(leak14_d0_ub) \ ///
            scalar(leak14_d2),scalar(leak14_d2_lb),scalar(leak14_d2_ub) \ ///
            scalar(leak14_d4),scalar(leak14_d4_lb),scalar(leak14_d4_ub) \ ///
            scalar(pr14_d0),scalar(pr14_d0_lb),scalar(pr14_d0_ub) \ ///
            scalar(pr14_d2),scalar(pr14_d2_lb),scalar(pr14_d2_ub) \ ///
            scalar(pr14_d4),scalar(pr14_d4_lb),scalar(pr14_d4_ub))
	   
*Labeling columns and rows
mat rownames A = "2013 FR Event Day Loss"  ///
                "3 Day Loss"   ///
                "5 Day Loss"   ///
                "Reuters Article Event Day Loss"  ///
                "3 Day Loss"   ///
                "5 Day Loss"   ///
                "2014 PR Event Day Loss"  ///
                "3 Day Loss"   ///
                "5 Day Loss"  
				
mat colnames A = "Change in 2013 RVO" "Lower Bound" "Upper Bound"  
		
*Exporting table
esttab matrix(A, fmt(2)) using $tables\rvolosses_levels_$outputdate.tex, replace  ///
    booktabs b(a2) ///
	title(Change in Value of the 2013 Renewable Volume Obligation ///
	\label{table:rvo_levels}) mlabels() 
restore


********************************************************************************
*CONVENTIONAL, ADVANCED, AND BIODIESEL EVENT STUDY - ADDITIONAL EVENTS
*Use 2015 RINs since traded over this period
********************************************************************************
*Additional Events:
*		2014-2016 PROPOSED RULE - 6/10/2015 (t=1798)
*		2014-2016 FINAL RULE - 11/30/2015 (t=1925)
* 		2017 PROPOSED RULE -  5/18/2016 (t=2042)
eststo clear
*Column 1: Conventional RINs - No Controls
	eststo: newey d.lprin_eth15 d.lwti_n16 d.leth_n16 d.lsoy_n16 ///
				pr1416_0-pr1416_4 fr1416_0-fr1416_4 pr17_0-pr17_4 ///
				if sample_ext, lag(5)
		*Storing even study estimates	
		estadd scalar pr1416_0 = _b[pr1416_0]
		estadd scalar pr1416_1 = _b[pr1416_1]
		estadd scalar pr1416_2 = _b[pr1416_2]
		estadd scalar pr1416_3 = _b[pr1416_3]
		estadd scalar pr1416_4 = _b[pr1416_4]
		estadd scalar fr1416_0 = _b[fr1416_0]
		estadd scalar fr1416_1 = _b[fr1416_1]
		estadd scalar fr1416_2 = _b[fr1416_2]
		estadd scalar fr1416_3 = _b[fr1416_3]
		estadd scalar fr1416_4 = _b[fr1416_4]
		estadd scalar pr17_0 = _b[pr17_0]
		estadd scalar pr17_1 = _b[pr17_1]
		estadd scalar pr17_2 = _b[pr17_2]
		estadd scalar pr17_3 = _b[pr17_3]
		estadd scalar pr17_4 = _b[pr17_4]

		*Storing regression descriptor
		estadd local time "No"
	
		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if sample_ext, xb
		gen e=d.lprin_eth15-xb if sample_ext
			replace e=. if t>=1806 & t<1810 //2014-2016 Proposed Rule  
			replace e=. if t>=1925 & t<1929 //2014-2016 Final Rule  
			replace e=. if t>=2042 & t<2046 //2017 Proposed Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)	
	drop xb e
	est store A

*Column 2: Conventional RINs - Time Controls
	eststo: newey d.lprin_eth15 d.lwti_n16 d.leth_n16 d.lsoy_n16 ///
				pr1416_0-pr1416_4 fr1416_0-fr1416_4 pr17_0-pr17_4 ///
			t t2-t4 i.day i.month if sample_ext, lag(5)		
		*Storing even study estimates	
		estadd scalar pr1416_0 = _b[pr1416_0]
		estadd scalar pr1416_1 = _b[pr1416_1]
		estadd scalar pr1416_2 = _b[pr1416_2]
		estadd scalar pr1416_3 = _b[pr1416_3]
		estadd scalar pr1416_4 = _b[pr1416_4]
		estadd scalar fr1416_0 = _b[fr1416_0]
		estadd scalar fr1416_1 = _b[fr1416_1]
		estadd scalar fr1416_2 = _b[fr1416_2]
		estadd scalar fr1416_3 = _b[fr1416_3]
		estadd scalar fr1416_4 = _b[fr1416_4]
		estadd scalar pr17_0 = _b[pr17_0]
		estadd scalar pr17_1 = _b[pr17_1]
		estadd scalar pr17_2 = _b[pr17_2]
		estadd scalar pr17_3 = _b[pr17_3]
		estadd scalar pr17_4 = _b[pr17_4]

		*Storing regression descriptor
		estadd local time "Yes"

		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if sample_ext, xb
		gen e=d.lprin_eth15-xb if sample_ext
			replace e=. if t>=1806 & t<1810 //2014-2016 Proposed Rule  
			replace e=. if t>=1925 & t<1929 //2014-2016 Final Rule  
			replace e=. if t>=2042 & t<2046 //2017 Proposed Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)
	drop xb e
	est store B

*Column 3: Advanced RINs - No Controls
	eststo: newey d.lprin_adv15 d.lwti_n16 d.leth_n16 d.lsoy_n16 ///
				pr1416_0-pr1416_4 fr1416_0-fr1416_4 pr17_0-pr17_4 ///
				if sample_ext, lag(5)
		*Storing even study estimates	
		estadd scalar pr1416_0 = _b[pr1416_0]
		estadd scalar pr1416_1 = _b[pr1416_1]
		estadd scalar pr1416_2 = _b[pr1416_2]
		estadd scalar pr1416_3 = _b[pr1416_3]
		estadd scalar pr1416_4 = _b[pr1416_4]
		estadd scalar fr1416_0 = _b[fr1416_0]
		estadd scalar fr1416_1 = _b[fr1416_1]
		estadd scalar fr1416_2 = _b[fr1416_2]
		estadd scalar fr1416_3 = _b[fr1416_3]
		estadd scalar fr1416_4 = _b[fr1416_4]
		estadd scalar pr17_0 = _b[pr17_0]
		estadd scalar pr17_1 = _b[pr17_1]
		estadd scalar pr17_2 = _b[pr17_2]
		estadd scalar pr17_3 = _b[pr17_3]
		estadd scalar pr17_4 = _b[pr17_4]

		*Storing regression descriptor
		estadd local time "No"

		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if sample_ext, xb
		gen e=d.lprin_adv15-xb if sample_ext	
			replace e=. if t>=1806 & t<1810 //2014-2016 Proposed Rule  
			replace e=. if t>=1925 & t<1929 //2014-2016 Final Rule  
			replace e=. if t>=2042 & t<2046 //2017 Proposed Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)
	drop xb e
	est store C

*Column 4: Advanced RINs - Time Controls
	eststo: newey d.lprin_adv15 d.lwti_n16 d.leth_n16 d.lsoy_n16 ///
				pr1416_0-pr1416_4 fr1416_0-fr1416_4 pr17_0-pr17_4 ///
			t t2-t4 i.day i.month if sample_ext, lag(5)
		*Storing even study estimates	
		estadd scalar pr1416_0 = _b[pr1416_0]
		estadd scalar pr1416_1 = _b[pr1416_1]
		estadd scalar pr1416_2 = _b[pr1416_2]
		estadd scalar pr1416_3 = _b[pr1416_3]
		estadd scalar pr1416_4 = _b[pr1416_4]
		estadd scalar fr1416_0 = _b[fr1416_0]
		estadd scalar fr1416_1 = _b[fr1416_1]
		estadd scalar fr1416_2 = _b[fr1416_2]
		estadd scalar fr1416_3 = _b[fr1416_3]
		estadd scalar fr1416_4 = _b[fr1416_4]
		estadd scalar pr17_0 = _b[pr17_0]
		estadd scalar pr17_1 = _b[pr17_1]
		estadd scalar pr17_2 = _b[pr17_2]
		estadd scalar pr17_3 = _b[pr17_3]
		estadd scalar pr17_4 = _b[pr17_4]
		
		*Storing regression descriptor
		estadd local time "Yes"

		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if sample_ext, xb
		gen e=d.lprin_adv15-xb if sample_ext	
			replace e=. if t>=1806 & t<1810 //2014-2016 Proposed Rule  
			replace e=. if t>=1925 & t<1929 //2014-2016 Final Rule  
			replace e=. if t>=2042 & t<2046 //2017 Proposed Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)	
	drop xb e
	est store D
	
*Column 5: Biodiesel RINs - No Controls
	eststo: newey d.lprin_bio15 d.lwti_n16 d.leth_n16 d.lsoy_n16 ///
				pr1416_0-pr1416_4 fr1416_0-fr1416_4 pr17_0-pr17_4 ///
				if sample_ext, lag(5)
		*Storing even study estimates	
		estadd scalar pr1416_0 = _b[pr1416_0]
		estadd scalar pr1416_1 = _b[pr1416_1]
		estadd scalar pr1416_2 = _b[pr1416_2]
		estadd scalar pr1416_3 = _b[pr1416_3]
		estadd scalar pr1416_4 = _b[pr1416_4]
		estadd scalar fr1416_0 = _b[fr1416_0]
		estadd scalar fr1416_1 = _b[fr1416_1]
		estadd scalar fr1416_2 = _b[fr1416_2]
		estadd scalar fr1416_3 = _b[fr1416_3]
		estadd scalar fr1416_4 = _b[fr1416_4]
		estadd scalar pr17_0 = _b[pr17_0]
		estadd scalar pr17_1 = _b[pr17_1]
		estadd scalar pr17_2 = _b[pr17_2]
		estadd scalar pr17_3 = _b[pr17_3]
		estadd scalar pr17_4 = _b[pr17_4]

		*Storing regression descriptor
		estadd local time "No"

		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if sample_ext, xb
		gen e=d.lprin_bio15-xb if sample_ext
			replace e=. if t>=1806 & t<1810 //2014-2016 Proposed Rule  
			replace e=. if t>=1925 & t<1929 //2014-2016 Final Rule  
			replace e=. if t>=2042 & t<2046 //2017 Proposed Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)
	drop xb e
	est store E

*Column 6: Biodiesel RINs - Time Controls
	eststo: newey d.lprin_bio15 d.lwti_n16 d.leth_n16 d.lsoy_n16 ///
				pr1416_0-pr1416_4 fr1416_0-fr1416_4 pr17_0-pr17_4 ///
			 t t2-t4 i.day i.month if sample_ext, lag(5)
		*Storing even study estimates	
		estadd scalar pr1416_0 = _b[pr1416_0]
		estadd scalar pr1416_1 = _b[pr1416_1]
		estadd scalar pr1416_2 = _b[pr1416_2]
		estadd scalar pr1416_3 = _b[pr1416_3]
		estadd scalar pr1416_4 = _b[pr1416_4]
		estadd scalar fr1416_0 = _b[fr1416_0]
		estadd scalar fr1416_1 = _b[fr1416_1]
		estadd scalar fr1416_2 = _b[fr1416_2]
		estadd scalar fr1416_3 = _b[fr1416_3]
		estadd scalar fr1416_4 = _b[fr1416_4]
		estadd scalar pr17_0 = _b[pr17_0]
		estadd scalar pr17_1 = _b[pr17_1]
		estadd scalar pr17_2 = _b[pr17_2]
		estadd scalar pr17_3 = _b[pr17_3]
		estadd scalar pr17_4 = _b[pr17_4]

		*Storing regression descriptor
		estadd local time "Yes"

		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if sample_ext, xb
		gen e=d.lprin_bio15-xb if sample_ext		
			replace e=. if t>=1806 & t<1810 //2014-2016 Proposed Rule  
			replace e=. if t>=1925 & t<1929 //2014-2016 Final Rule  
			replace e=. if t>=2042 & t<2046 //2017 Proposed Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)
	drop xb e
	est store F
	
esttab A B C D E F using $tables\rinregs_extension_$outputdate.tex, replace label ///
    booktabs b(a2) nonumber ///
	drop(_cons pr1416* fr1416* pr17* t* 1.* 2.* 3.* 4.* 5.* 6.* 7.* 8.* ///
		 9.* 10.* 11.* 12.*) ///
    starlevels(* 0.10 ** 0.05 *** 0.01) ///
	title(RIN Event Study Regression Results \\ (Dependent Variable: Log Differenced 2015 RIN Prices) \label{table:reg1})  ///
	cells(b(fmt(3) star) se(fmt(3) par)) ///
	scalars("pr1416_0 2014-2016 Proposed Rule: Day 0" "pr1416_1   Day 1" ///
		    "pr1416_2 Day 2" "pr1416_3  Day 3" ///
			"pr1416_4 Day 4" "fr1416_0 2014-2016 Final Rule: Day 0" ///
		    "fr1416_1 Day 1" "fr1416_2 Day 2" ///
		    "fr1416_3 Day 3" "fr1416_4 Day 4" ///
	        "pr17_0 2017 Proposed Rule: Day 0" "pr17_1 Day 1" ///
	        "pr17_2 Day 2" "pr17_3 Day 3" ///
			"pr17_4 Day 4" "time Time Controls" ///
			"sq10_lb SQ 10\% Lower Bound" "sq10_ub SQ 10\% Upper Bound" /// 
			"sq5_lb SQ 5\% Lower Bound" "sq5_ub SQ 5\% Upper Bound" /// 
			"sq1_lb SQ 1\% Lower Bound" "sq1_ub SQ 1\% Upper Bound") sfmt(3) ///		
	 varlabels(D.lwti_n16 "Oil Futures" D.leth_n16 "Ethanol Futures" ///
	           D.lsoy_n16 "Soybean Oil Futures") ///	
	 mlabels((1) (2) (3) (4) (5) (6)) collabels(none) ///
	 note(Notes: Futures contracts are for July 2016 contracts.  ///
	          Normal return standard errors in parentheses are Newey-West errors ///
	      with 5 lags. Inference for abnormal returns are based on  ///
	      sample quantile critical values given at the bottom of the table ///
		  \citep{Gelbach1}. *, **, and ***  denote significance at the ///
		  10\%, 5\%, and 1\% confidence  levels, respectively.)  

		  
		  
********************************************************************************
*CHANGE IN VALUE OF RVO
* Notes: - Need to reshape the data to long
*		 - Estimating a fully interacted panel data model - Produces equivalent
*           estimates as before with proper standard errors to combine losses
*           from each model. 
********************************************************************************
preserve

*Keeping only necessary variables for reshape			 
keep prin_eth15 prin_adv15 prin_bio15 ///
     lprin_eth15 lprin_adv15 lprin_bio15 ///
	 lwti_n16 leth_n16 lsoy_n16 ///
	 pr1416_0 pr1416_1 pr1416_2 pr1416_3 pr1416_4 ///
	 fr1416_0 fr1416_1 fr1416_2 fr1416_3 fr1416_4 ///
	 pr17_0 pr17_1 pr17_2 pr17_3 pr17_4 ///
	 t t2-t6 day month date sample_ext
	 
*Renaming RIN prices to prep for reshape
rename lprin_adv15 lprin1    // 1 is Advanced
rename lprin_bio15 lprin2	 // 2 is Biodiesel
rename lprin_eth15 lprin3    // 3 is Ethanol
rename prin_adv15 prin1      // 1 is Advanced
rename prin_bio15 prin2  	 // 2 is Biodiesel
rename prin_eth15 prin3      // 3 is Ethanol

*Reshaping to long data form
reshape long lprin prin, i(date t) j(cat)
sort t cat

*Creating category indicators
gen eth=0
	replace eth=1 if cat==3
gen adv=0
	replace adv=1 if cat==1
gen bio=0
	replace bio=1 if cat==2

*Creating differenced fuel prices
gen dwti=d.lwti_n16
gen deth=d.leth_n16
gen dsoy=d.lsoy_n16

* Creating policy announcement interactions
local xvars pr1416_0 pr1416_1 pr1416_2 pr1416_3 pr1416_4 ///
			fr1416_0 fr1416_1 fr1416_2 fr1416_3 fr1416_4 ///
			pr17_0 pr17_1 pr17_2 pr17_3 pr17_4 ///
			dwti deth dsoy
foreach x of local xvars {
	gen eth_`x'=eth*`x'
}
*	
foreach x of local xvars {
	gen adv_`x'=adv*`x'
}
*
foreach x of local xvars {
	gen bio_`x'=bio*`x'
}
*
*Generating month-by-year variable to cluster standard errors
gen year=year(date)
gen ym=ym(year,month)
	format ym %tm

*Setting panel data
xtset cat t

*Fully interacted regression
reg d.lprin eth_* adv_* bio_* i.cat if sample_ext==1, vce(cluster ym)

***********
*2015 Mandate Levels
***********
local eth_man15=14.05
local adv_man15=1.027
local bio_man15=1.73

***********
* Change in Value - 2014-2016 PROPOSED RULE
* Notes: - Released 6/10/2015 (t=1798)
***********
*Initial Ethanol RIN Price
sum prin if cat==3 & t==1798
local prin_eth0=r(mean)
*Initial Advanced RIN Price
sum prin if cat==1 & t==1798
local prin_adv0=r(mean)
*Initial Biodiesel RIN Price
sum prin if cat==2 & t==1798
local prin_bio0=r(mean)

* Day 0 RVO Losses
lincom _b[eth_pr1416_0]*`prin_eth0'*`eth_man15'/100 + ///
	   _b[adv_pr1416_0]*`prin_adv0'*`adv_man15'/100 + ///
	   _b[bio_pr1416_0]*`prin_bio0'*`bio_man15'/100 
	scalar pr1416_d0=r(estimate)	
	scalar pr1416_d0_lb= r(estimate)+invnorm(0.025)*r(se)
	scalar pr1416_d0_ub=r(estimate)+invnorm(0.975)*r(se)	
	
	
* Day 0 - Day 2 RVO Losses
lincom (_b[eth_pr1416_0]+_b[eth_pr1416_1]+_b[eth_pr1416_2])*`prin_eth0'*`eth_man15'/100 + ///
	   (_b[adv_pr1416_0]+_b[adv_pr1416_1]+_b[adv_pr1416_2])*`prin_adv0'*`adv_man15'/100 + ///
	   (_b[bio_pr1416_0]+_b[bio_pr1416_1]+_b[bio_pr1416_2])*`prin_bio0'*`bio_man15'/100 
	scalar pr1416_d2=r(estimate)	
	scalar pr1416_d2_lb= r(estimate)+invnorm(0.025)*r(se)
	scalar pr1416_d2_ub=r(estimate)+invnorm(0.975)*r(se)	
	
* Day 0 - Day 4 RVO Losses
lincom (_b[eth_pr1416_0]+_b[eth_pr1416_1]+_b[eth_pr1416_2]+_b[eth_pr1416_3]+_b[eth_pr1416_4])*`prin_eth0'*`eth_man15'/100 + ///
	   (_b[adv_pr1416_0]+_b[adv_pr1416_1]+_b[adv_pr1416_2]+_b[adv_pr1416_3]+_b[adv_pr1416_4])*`prin_adv0'*`adv_man15'/100 + ///
	   (_b[bio_pr1416_0]+_b[bio_pr1416_1]+_b[bio_pr1416_2]+_b[bio_pr1416_3]+_b[bio_pr1416_4])*`prin_bio0'*`bio_man15'/100 
 	scalar pr1416_d4=r(estimate)	
	scalar pr1416_d4_lb= r(estimate)+invnorm(0.025)*r(se)
	scalar pr1416_d4_ub=r(estimate)+invnorm(0.975)*r(se)	
 
***********
* Change in Value - 2014-2016 FINAL RULE
* Notes: - Released 11/30/2015 (t=1925)
***********
*Initial Ethanol RIN Price
sum prin if cat==3 & t==1925
local prin_eth0=r(mean)
*Initial Advanced RIN Price
sum prin if cat==1 & t==1925
local prin_adv0=r(mean)
*Initial Biodiesel RIN Price
sum prin if cat==2 & t==1925
local prin_bio0=r(mean)

* Day 0 RVO Losses
lincom _b[eth_fr1416_0]*`prin_eth0'*`eth_man15'/100 + ///
	   _b[adv_fr1416_0]*`prin_adv0'*`adv_man15'/100 + ///
	   _b[bio_fr1416_0]*`prin_bio0'*`bio_man15'/100 
	scalar fr1416_d0=r(estimate)	
	scalar fr1416_d0_lb= r(estimate)+invnorm(0.025)*r(se)
	scalar fr1416_d0_ub=r(estimate)+invnorm(0.975)*r(se)	
	
* Day 0 - Day 2 RVO Losses
lincom (_b[eth_fr1416_0]+_b[eth_fr1416_1]+_b[eth_fr1416_2])*`prin_eth0'*`eth_man15'/100 + ///
	   (_b[adv_fr1416_0]+_b[adv_fr1416_1]+_b[adv_fr1416_2])*`prin_adv0'*`adv_man15'/100 + ///
	   (_b[bio_fr1416_0]+_b[bio_fr1416_1]+_b[bio_fr1416_2])*`prin_bio0'*`bio_man15'/100 
	scalar fr1416_d2=r(estimate)	
	scalar fr1416_d2_lb= r(estimate)+invnorm(0.025)*r(se)
	scalar fr1416_d2_ub=r(estimate)+invnorm(0.975)*r(se)	
	
* Day 0 - Day 4 RVO Losses
lincom (_b[eth_fr1416_0]+_b[eth_fr1416_1]+_b[eth_fr1416_2]+_b[eth_fr1416_3]+_b[eth_fr1416_4])*`prin_eth0'*`eth_man15'/100 + ///
	   (_b[adv_fr1416_0]+_b[adv_fr1416_1]+_b[adv_fr1416_2]+_b[adv_fr1416_3]+_b[adv_fr1416_4])*`prin_adv0'*`adv_man15'/100 + ///
	   (_b[bio_fr1416_0]+_b[bio_fr1416_1]+_b[bio_fr1416_2]+_b[bio_fr1416_3]+_b[bio_fr1416_4])*`prin_bio0'*`bio_man15'/100 
	scalar fr1416_d4=r(estimate)	
	scalar fr1416_d4_lb= r(estimate)+invnorm(0.025)*r(se)
	scalar fr1416_d4_ub=r(estimate)+invnorm(0.975)*r(se)	 
 
***********
* Change in Value - 2017 PROPOSED RULE 
* Notes: - Released 5/18/2016 (t=2042)
***********
*Initial Ethanol RIN Price
sum prin if cat==3 & t==2042
local prin_eth0=r(mean)
*Initial Advanced RIN Price
sum prin if cat==1 & t==2042
local prin_adv0=r(mean)
*Initial Biodiesel RIN Price
sum prin if cat==2 & t==2042
local prin_bio0=r(mean)

* Day 0 RVO Losses
lincom _b[eth_pr17_0]*`prin_eth0'*`eth_man15'/100 + ///
	   _b[adv_pr17_0]*`prin_adv0'*`adv_man15'/100 + ///
	   _b[bio_pr17_0]*`prin_bio0'*`bio_man15'/100 
	scalar pr17_d0=r(estimate)	
	scalar pr17_d0_lb= r(estimate)+invnorm(0.025)*r(se)
	scalar pr17_d0_ub=r(estimate)+invnorm(0.975)*r(se)	
	
* Day 0 - Day 2 RVO Losses
lincom (_b[eth_pr17_0]+_b[eth_pr17_1]+_b[eth_pr17_2])*`prin_eth0'*`eth_man15'/100 + ///
	   (_b[adv_pr17_0]+_b[adv_pr17_1]+_b[adv_pr17_2])*`prin_adv0'*`adv_man15'/100 + ///
	   (_b[bio_pr17_0]+_b[bio_pr17_1]+_b[bio_pr17_2])*`prin_bio0'*`bio_man15'/100 
	scalar pr17_d2=r(estimate)	
	scalar pr17_d2_lb= r(estimate)+invnorm(0.025)*r(se)
	scalar pr17_d2_ub=r(estimate)+invnorm(0.975)*r(se)	
	
* Day 0 - Day 4 RVO Losses
lincom (_b[eth_pr17_0]+_b[eth_pr17_1]+_b[eth_pr17_2]+_b[eth_pr17_3]+_b[eth_pr17_4])*`prin_eth0'*`eth_man15'/100 + ///
	   (_b[adv_pr17_0]+_b[adv_pr17_1]+_b[adv_pr17_2]+_b[adv_pr17_3]+_b[adv_pr17_4])*`prin_adv0'*`adv_man15'/100 + ///
	   (_b[bio_pr17_0]+_b[bio_pr17_1]+_b[bio_pr17_2]+_b[bio_pr17_3]+_b[bio_pr17_4])*`prin_bio0'*`bio_man15'/100 
	scalar pr17_d4=r(estimate)	
	scalar pr17_d4_lb= r(estimate)+invnorm(0.025)*r(se)
	scalar pr17_d4_ub=r(estimate)+invnorm(0.975)*r(se)	
	
*Creating matrix
matrix A = (scalar(pr1416_d0),scalar(pr1416_d0_lb),scalar(pr1416_d0_ub) \ ///
            scalar(pr1416_d2),scalar(pr1416_d2_lb),scalar(pr1416_d2_ub) \ ///
            scalar(pr1416_d4),scalar(pr1416_d4_lb),scalar(pr1416_d4_ub) \ ///
            scalar(fr1416_d0),scalar(fr1416_d0_lb),scalar(fr1416_d0_ub) \ ///
            scalar(fr1416_d2),scalar(fr1416_d2_lb),scalar(fr1416_d2_ub) \ ///
            scalar(fr1416_d4),scalar(fr1416_d4_lb),scalar(fr1416_d4_ub) \ ///
            scalar(pr17_d0),scalar(pr17_d0_lb),scalar(pr17_d0_ub) \ ///
            scalar(pr17_d2),scalar(pr17_d2_lb),scalar(pr17_d2_ub) \ ///
            scalar(pr17_d4),scalar(pr17_d4_lb),scalar(pr17_d4_ub))
	   
*Labeling columns and rows
mat rownames A = "2014-2016 PR Event Day Loss"   ///
                "3 Day Loss"   ///
                "5 Day Loss"   ///
                "2014-2016 FR Event Day Loss"  ///
                "3 Day Loss"   ///
                "5 Day Loss"   ///
                "2017 PR Event Day Loss"  ///
                "3 Day Loss"   ///
                "5 Day Loss"  
				
mat colnames A = "Change in 2015 RVO" "Lower Bound" "Upper Bound"  
		
*Exporting table
esttab matrix(A, fmt(2)) using $tables\rvolosses_extension_$outputdate.tex, replace  ///
    booktabs b(a2) ///
	title(Change in Value of the 2015 Renewable Volume Obligation ///
	\label{table:rvo_ext}) mlabels() 
restore		 



***************************************************************
*2015 RIN GRAPH
*Notes:  - 2014-2016 PROPOSED RULE: RELEASED 5/29/2015 (t=1798, date=20237)
*	     - 2014-2016 FINAL RULE: RELEASED 11/30/2015 (t=1925, date=20422)
*	  	 - 2017 PROPOSED RULE: RELEASED 5/18/2016 (t=2042, date=20592)   
***************************************************************	
twoway (line prin_eth15 date if sample_ext, lc(orange) lw(medium) lp(solid)) ///
       (line prin_adv15 date if sample_ext, lc(blue) lw(medthick) lp(longdash)) ///
       (line prin_bio15 date if sample_ext, lc(red) lw(medthick) lp(shortdash)),  ///
	   graphregion(color(white)) bgcolor(white) ///
	   xtitle("")  /// 
	   ylabel(0(20)100, nogrid angle(0)) ///
	   xline(20237, lcolor(black) lp(solid)) ///
	   text(98 20217 "1", placement(e) size(vlarge)) ///
	   xline(20422, lcolor(black) lp(solid)) ///
	   text(98 20402 "2", placement(e) size(vlarge)) ///
	   xline(20592, lcolor(black) lp(solid)) ///
	   text(98 20572 "3", placement(e) size(vlarge)) ///
	   legend(order(1 "Conventional" 2 "Advanced" 3 "Biodiesel") ///
	   region(lcolor(white)) rows(1)) ///
	   ytitle("RIN Price (cents/gal)") ///
	   xlabel(19997 "Oct 2014" 20090 "Jan 2015" 20179 "Apr 2015" ///
		      20270 "Jul 2015" 20362 "Oct 2015" 20457 "Jan 2016" ///
		      20545 "Apr 2016" 20635 "July 2016", angle(45))
graph export $figs\rin_prices_ext_$outputdate.png, width(4000) replace
