***************************************************************
* POLICY SHOCKS AND RIN PRICES
* MAIN REGRESSIONS AND RESULTS FIGURES: COMMODITY PRICES
* CODE BY: GABRIEL LADE  
* LAST MAJOR UPDATE: 02/19/2019
***************************************************************

********************************************************************************
*WTI, ETHANOL, SOYBEAN OIL, CORN, & SUGAR COMMODITY EFFECTS - BASELINE   
********************************************************************************
eststo clear
*Column 1: WTI - No Time Controls
eststo: newey d.lwti_n14 d.lrus  ///
		fr13_0-fr13_2 leak14_0-leak14_2 pr14_0-pr14_2 if sample_main==1, lag(5)

		*Storing even study estimates	
		estadd scalar fr13_0 = _b[fr13_0]
		estadd scalar fr13_1 = _b[fr13_1]
		estadd scalar fr13_2 = _b[fr13_2]
		estadd scalar leak14_0 = _b[leak14_0]
		estadd scalar leak14_1 = _b[leak14_1]
		estadd scalar leak14_2 = _b[leak14_2]
		estadd scalar pr14_0 = _b[pr14_0]
		estadd scalar pr14_1 = _b[pr14_1]
		estadd scalar pr14_2 = _b[pr14_2]

		*Storing regression descriptor
		estadd local time "No"

		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if sample_main==1, xb
		gen e=d.lwti_n14-xb if sample_main==1		
			replace e=. if t>=1344 & t<1346 //2013 Final Rule
			replace e=. if t>=1391 & t<1393 //Reuters Article
			replace e=. if t>=1416 & t<1418 //2013 Final Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)
	drop xb e
	est store A

*Column 2: WTI - Time Controls
eststo: newey d.lwti_n14 d.lrus  ///
		fr13_0-fr13_2 leak14_0-leak14_2 pr14_0-pr14_2 ///
		t t2-t4 i.day i.month if sample_main==1, lag(5)	

		*Storing even study estimates	
		estadd scalar fr13_0 = _b[fr13_0]
		estadd scalar fr13_1 = _b[fr13_1]
		estadd scalar fr13_2 = _b[fr13_2]
		estadd scalar leak14_0 = _b[leak14_0]
		estadd scalar leak14_1 = _b[leak14_1]
		estadd scalar leak14_2 = _b[leak14_2]
		estadd scalar pr14_0 = _b[pr14_0]
		estadd scalar pr14_1 = _b[pr14_1]
		estadd scalar pr14_2 = _b[pr14_2]

		*Storing regression descriptor
		estadd local time "Yes"

		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if sample_main==1, xb
		gen e=d.lwti_n14-xb if sample_main==1		
			replace e=. if t>=1344 & t<1346 //2013 Final Rule
			replace e=. if t>=1391 & t<1393 //Reuters Article
			replace e=. if t>=1416 & t<1418 //2013 Final Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)	
	drop xb e
	est store B
	
*Column 3: Ethanol - No Time Controls
eststo: newey d.leth_n14 d.lrus d.lgs_index  ///
		fr13_0-fr13_2 leak14_0-leak14_2 pr14_0-pr14_2 if sample_main==1, lag(5)

		*Storing even study estimates	
		estadd scalar fr13_0 = _b[fr13_0]
		estadd scalar fr13_1 = _b[fr13_1]
		estadd scalar fr13_2 = _b[fr13_2]
		estadd scalar leak14_0 = _b[leak14_0]
		estadd scalar leak14_1 = _b[leak14_1]
		estadd scalar leak14_2 = _b[leak14_2]
		estadd scalar pr14_0 = _b[pr14_0]
		estadd scalar pr14_1 = _b[pr14_1]
		estadd scalar pr14_2 = _b[pr14_2]

		*Storing regression descriptor
		estadd local time "No"

		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if sample_main==1, xb
		gen e=d.leth_n14-xb if sample_main==1		
			replace e=. if t>=1344 & t<1346 //2013 Final Rule
			replace e=. if t>=1391 & t<1393 //Reuters Article
			replace e=. if t>=1416 & t<1418 //2013 Final Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)	
	drop xb e
	est store C

*Column 4: Ethanol - Time Controls
eststo: newey d.leth_n14 d.lrus d.lgs_index  ///
		fr13_0-fr13_2 leak14_0-leak14_2 pr14_0-pr14_2 ///
		t t2-t4 i.day i.month if sample_main==1, lag(5)	

		*Storing even study estimates	
		estadd scalar fr13_0 = _b[fr13_0]
		estadd scalar fr13_1 = _b[fr13_1]
		estadd scalar fr13_2 = _b[fr13_2]
		estadd scalar leak14_0 = _b[leak14_0]
		estadd scalar leak14_1 = _b[leak14_1]
		estadd scalar leak14_2 = _b[leak14_2]
		estadd scalar pr14_0 = _b[pr14_0]
		estadd scalar pr14_1 = _b[pr14_1]
		estadd scalar pr14_2 = _b[pr14_2]

		*Storing regression descriptor
		estadd local time "Yes"

		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if sample_main==1, xb
		gen e=d.leth_n14-xb if sample_main==1		
			replace e=. if t>=1344 & t<1346 //2013 Final Rule
			replace e=. if t>=1391 & t<1393 //Reuters Article
			replace e=. if t>=1416 & t<1418 //2013 Final Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)	
	drop xb e
	est store D
	
*Column 5: Soybean Oil - No Time Controls
eststo: newey d.lsoy_n14 d.lrus d.lgs_index  ///
		fr13_0-fr13_2 leak14_0-leak14_2 pr14_0-pr14_2 if sample_main==1, lag(5)

		*Storing even study estimates	
		estadd scalar fr13_0 = _b[fr13_0]
		estadd scalar fr13_1 = _b[fr13_1]
		estadd scalar fr13_2 = _b[fr13_2]
		estadd scalar leak14_0 = _b[leak14_0]
		estadd scalar leak14_1 = _b[leak14_1]
		estadd scalar leak14_2 = _b[leak14_2]
		estadd scalar pr14_0 = _b[pr14_0]
		estadd scalar pr14_1 = _b[pr14_1]
		estadd scalar pr14_2 = _b[pr14_2]

		*Storing regression descriptor
		estadd local time "No"

		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if sample_main==1, xb
		gen e=d.lsoy_n14-xb if sample_main==1		
			replace e=. if t>=1344 & t<1346 //2013 Final Rule
			replace e=. if t>=1391 & t<1393 //Reuters Article
			replace e=. if t>=1416 & t<1418 //2013 Final Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)	
	drop xb e
	est store E

*Column 6: Soybean Oil - Time Controls
eststo: newey d.lsoy_n14 d.lrus d.lgs_index  ///
		fr13_0-fr13_2 leak14_0-leak14_2 pr14_0-pr14_2 ///
		t t2-t4 i.day i.month if sample_main==1, lag(5)	

		*Storing even study estimates	
		estadd scalar fr13_0 = _b[fr13_0]
		estadd scalar fr13_1 = _b[fr13_1]
		estadd scalar fr13_2 = _b[fr13_2]
		estadd scalar leak14_0 = _b[leak14_0]
		estadd scalar leak14_1 = _b[leak14_1]
		estadd scalar leak14_2 = _b[leak14_2]
		estadd scalar pr14_0 = _b[pr14_0]
		estadd scalar pr14_1 = _b[pr14_1]
		estadd scalar pr14_2 = _b[pr14_2]

		*Storing regression descriptor
		estadd local time "Yes"

		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if sample_main==1, xb
		gen e=d.lsoy_n14-xb if sample_main==1		
			replace e=. if t>=1344 & t<1346 //2013 Final Rule
			replace e=. if t>=1391 & t<1393 //Reuters Article
			replace e=. if t>=1416 & t<1418 //2013 Final Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)	
	drop xb e
	est store F
	
*Column 7: Corn - No Time Controls
eststo: newey d.lcorn_n14 d.lrus d.lgs_index  ///
		fr13_0-fr13_2 leak14_0-leak14_2 pr14_0-pr14_2 if sample_main==1, lag(5)

		*Storing even study estimates	
		estadd scalar fr13_0 = _b[fr13_0]
		estadd scalar fr13_1 = _b[fr13_1]
		estadd scalar fr13_2 = _b[fr13_2]
		estadd scalar leak14_0 = _b[leak14_0]
		estadd scalar leak14_1 = _b[leak14_1]
		estadd scalar leak14_2 = _b[leak14_2]
		estadd scalar pr14_0 = _b[pr14_0]
		estadd scalar pr14_1 = _b[pr14_1]
		estadd scalar pr14_2 = _b[pr14_2]

		*Storing regression descriptor
		estadd local time "No"

		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if sample_main==1, xb
		gen e=d.lcorn_n14-xb if sample_main==1		
			replace e=. if t>=1344 & t<=1346 //2013 Final Rule
			replace e=. if t>=1391 & t<=1393 //Reuters Article
			replace e=. if t>=1416 & t<=1418 //2013 Final Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)
	drop xb e
	est store G

*Column 8: Corn - Time Controls
eststo: newey d.lcorn_n14 d.lrus d.lgs_index  ///
		fr13_0-fr13_2 leak14_0-leak14_2 pr14_0-pr14_2 ///
		t t2-t4 i.day i.month if sample_main==1, lag(5)	

		*Storing even study estimates	
		estadd scalar fr13_0 = _b[fr13_0]
		estadd scalar fr13_1 = _b[fr13_1]
		estadd scalar fr13_2 = _b[fr13_2]
		estadd scalar leak14_0 = _b[leak14_0]
		estadd scalar leak14_1 = _b[leak14_1]
		estadd scalar leak14_2 = _b[leak14_2]
		estadd scalar pr14_0 = _b[pr14_0]
		estadd scalar pr14_1 = _b[pr14_1]
		estadd scalar pr14_2 = _b[pr14_2]

		*Storing regression descriptor
		estadd local time "Yes"

		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if sample_main==1, xb
		gen e=d.lcorn_n14-xb if sample_main==1		
			replace e=. if t>=1344 & t<1346 //2013 Final Rule
			replace e=. if t>=1391 & t<1393 //Reuters Article
			replace e=. if t>=1416 & t<1418 //2013 Final Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)
	drop xb e
	est store H
	
*Column 9: Sugar - No Time Controls
eststo: newey d.lsug_n14 d.lrus d.lgs_index  ///
		fr13_0-fr13_2 leak14_0-leak14_2 pr14_0-pr14_2 if sample_main==1, lag(5)

		*Storing even study estimates	
		estadd scalar fr13_0 = _b[fr13_0]
		estadd scalar fr13_1 = _b[fr13_1]
		estadd scalar fr13_2 = _b[fr13_2]
		estadd scalar leak14_0 = _b[leak14_0]
		estadd scalar leak14_1 = _b[leak14_1]
		estadd scalar leak14_2 = _b[leak14_2]
		estadd scalar pr14_0 = _b[pr14_0]
		estadd scalar pr14_1 = _b[pr14_1]
		estadd scalar pr14_2 = _b[pr14_2]

		*Storing regression descriptor
		estadd local time "No"

		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if sample_main==1, xb
		gen e=d.lsug_n14-xb if sample_main==1		
			replace e=. if t>=1344 & t<=1346 //2013 Final Rule
			replace e=. if t>=1391 & t<=1393 //Reuters Article
			replace e=. if t>=1416 & t<=1418 //2013 Final Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)	
	drop xb e
	est store I

*Column 10: Sugar - Time Controls
eststo: newey d.lsug_n14 d.lrus d.lgs_index  ///
		fr13_0-fr13_2 leak14_0-leak14_2 pr14_0-pr14_2 ///
		t t2-t4 i.day i.month if sample_main==1, lag(5)	

		*Storing even study estimates	
		estadd scalar fr13_0 = _b[fr13_0]
		estadd scalar fr13_1 = _b[fr13_1]
		estadd scalar fr13_2 = _b[fr13_2]
		estadd scalar leak14_0 = _b[leak14_0]
		estadd scalar leak14_1 = _b[leak14_1]
		estadd scalar leak14_2 = _b[leak14_2]
		estadd scalar pr14_0 = _b[pr14_0]
		estadd scalar pr14_1 = _b[pr14_1]
		estadd scalar pr14_2 = _b[pr14_2]

		*Storing regression descriptor
		estadd local time "Yes"

		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if sample_main==1, xb
		gen e=d.lsug_n14-xb if sample_main==1		
			replace e=. if t>=1344 & t<=1346 //2013 Final Rule
			replace e=. if t>=1391 & t<=1393 //Reuters Article
			replace e=. if t>=1416 & t<=1418 //2013 Final Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)
	drop xb e
	est store J
	
esttab A B C D E F G H I J using $tables\comregs_$outputdate.tex, replace label ///
    booktabs b(a2) nonumber ///
	drop(_cons fr13* leak14* pr14* t* 1.* 2.* 3.* 4.* 5.* 6.* 7.* 8.* ///
		 9.* 10.* 11.* 12.* D*) ///
    starlevels(* 0.10 ** 0.05 *** 0.01) ///
	title(Commodity Market Abnormal Return Estimates \\ ///
	(Dependent Variable: Log Differenced Commodity Prices) ///
	\label{table:commodity_sq}) ///
	cells(b(fmt(3) star) se(fmt(3) par)) ///
	scalars("fr13_0 2013 Final Rule: Day 0" "fr13_1   Day 1" ///
		    "fr13_2 Day 2" ///
			"leak14_0 Reuters Article: Day 0" ///
		    "leak14_1 Day 1" "leak14_2 Day 2" ///
	        "pr14_0 2014 Proposed Rule: Day 0" "pr14_1 Day 1" ///
	        "pr14_2 Day 2"  ///
		    "time Time Controls" ///
			"sq10_lb SQ 10\% Lower Bound" "sq10_ub SQ 10\% Upper Bound" /// 
			"sq5_lb SQ 5\% Lower Bound" "sq5_ub SQ 5\% Upper Bound" /// 
			"sq1_lb SQ 1\% Lower Bound" "sq1_ub SQ 1\% Upper Bound") /// 
	 sfmt(3) ///
	 mlabels((1) (2) (3) (4) (5) (6) (7) (8) (9) (10)) collabels(none) ///
	 note(All price series are futures contract prices for July 2014 contracts. ///
	      SQ test critical values are estimated from the empirical residual ///
	      distribution excluding event days. Abnormal returns represent ///
		  those that cannot be explained by corresponding movements in ///
		  the S\&P-GS Commodity Index, the Russel 3000 Index, and a daily mean ///
		  return. WTI regressions exclude the S\&P-GS Commodity Index.  ///
		  *, **, and ***  denote significance at  the 10\%, 5\%, ///
		  and 1\% confidence  levels, respectively.)  
		
		  
********************************************************************************
*WTI - ALL CONTRACTS   
******************************************************************************** 
	 
foreach x in z13 h14 k14 n14 u14 z14 h15 k15 n15 u15 z15 {
	newey d.lwti_`x' d.lrus  ///
		fr13_0-fr13_1 leak14_0-leak14_1 pr14_0-pr14_1 ///
		t t2-t4 i.day i.month if sample_main==1, lag(5)	

		*Storing even study estimates	
		scalar fr0_`x' = _b[fr13_0]
		scalar fr1_`x' = _b[fr13_1]
		scalar leak0_`x' = _b[leak14_0]
		scalar leak1_`x' = _b[leak14_1]
		scalar pr0_`x' = _b[pr14_0]
		scalar pr1_`x' = _b[pr14_1]

		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if sample_main==1, xb
		gen e=d.lwti_n14-xb if sample_main==1		
			replace e=. if t>=1344 & t<1346 //2013 Final Rule
			replace e=. if t>=1391 & t<1393 //Reuters Article
			replace e=. if t>=1416 & t<1418 //2013 Final Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)	
	drop xb e
}
*
*Creating matrix
matrix A = (scalar(fr0_z13),scalar(fr1_z13),scalar(leak0_z13),scalar(leak1_z13),scalar(pr0_z13),scalar(pr1_z13) \ ///
            scalar(fr0_h14),scalar(fr1_h14),scalar(leak0_h14),scalar(leak1_h14),scalar(pr0_h14),scalar(pr1_h14)  \ ///
            scalar(fr0_k14),scalar(fr1_k14),scalar(leak0_k14),scalar(leak1_k14),scalar(pr0_k14),scalar(pr1_k14)  \ ///
            scalar(fr0_n14),scalar(fr1_n14),scalar(leak0_n14),scalar(leak1_n14),scalar(pr0_n14),scalar(pr1_n14)  \ ///
            scalar(fr0_u14),scalar(fr1_u14),scalar(leak0_u14),scalar(leak1_u14),scalar(pr0_u14),scalar(pr1_u14)  \ ///
            scalar(fr0_z14),scalar(fr1_z14),scalar(leak0_z14),scalar(leak1_z14),scalar(pr0_z14),scalar(pr1_z14)  \ ///
            scalar(fr0_h15),scalar(fr1_h15),scalar(leak0_h15),scalar(leak1_h15),scalar(pr0_h15),scalar(pr1_h15)  \ ///
            scalar(fr0_k15),scalar(fr1_k15),scalar(leak0_k15),scalar(leak1_k15),scalar(pr0_k15),scalar(pr1_k15)  \ ///
            scalar(fr0_n15),scalar(fr1_n15),scalar(leak0_n15),scalar(leak1_n15),scalar(pr0_n15),scalar(pr1_n15)  \ ///
            scalar(fr0_u15),scalar(fr1_u15),scalar(leak0_u15),scalar(leak1_u15),scalar(pr0_u15),scalar(pr1_u15)  \ ///
            scalar(fr0_z15),scalar(fr1_z15),scalar(leak0_z15),scalar(leak1_z15),scalar(pr0_z15),scalar(pr1_z15))
	   
*Labeling columns and rows
mat rownames A ="December-13"  ///
                "March-14"  ///
				"May-14"  ///
				"July-14"  ///
				"September-14"  ///
				"December-14"  ///
				"March-15"  ///
				"May-15"  ///
				"July-15"  ///
				"September-15"  ///
				"December-15"  ///
				
mat colnames A = "Day 0" "Day 1" "Day 0" "Day 1" "Day 0" "Day 1"  
		
*Exporting table
esttab matrix(A, fmt(3)) using $tables\wti_appendix_$outputdate.tex, replace  ///
    booktabs b(a2) title(WTI Contract Abnormal Returns) mlabels() 

	
********************************************************************************
*ETHANOL - ALL CONTRACTS   
********************************************************************************
foreach x in z13 h14 k14 n14 u14 z14 h15 k15 n15 u15 z15 {

	*Fixing missing value in ethanol prices 
	replace leth_`x' = leth_`x'[_n-1] if missing(leth_`x') & leth_`x'[_n+2]!=. 
	
	newey d.leth_`x' d.lrus  ///
		fr13_0-fr13_1 leak14_0-leak14_1 pr14_0-pr14_1 ///
		t t2-t4 i.day i.month if sample_main==1, lag(5)	

		*Storing even study estimates	
		scalar fr0_`x' = _b[fr13_0]
		scalar fr1_`x' = _b[fr13_1]
		scalar leak0_`x' = _b[leak14_0]
		scalar leak1_`x' = _b[leak14_1]
		scalar pr0_`x' = _b[pr14_0]
		scalar pr1_`x' = _b[pr14_1]

		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if sample_main==1, xb
		gen e=d.lwti_n14-xb if sample_main==1		
			replace e=. if t>=1344 & t<1346 //2013 Final Rule
			replace e=. if t>=1391 & t<1393 //Reuters Article
			replace e=. if t>=1416 & t<1418 //2013 Final Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)	
	drop xb e
}
*
*Creating matrix
matrix A = (scalar(fr0_z13),scalar(fr1_z13),scalar(leak0_z13),scalar(leak1_z13),scalar(pr0_z13),scalar(pr1_z13) \ ///
            scalar(fr0_h14),scalar(fr1_h14),scalar(leak0_h14),scalar(leak1_h14),scalar(pr0_h14),scalar(pr1_h14)  \ ///
            scalar(fr0_k14),scalar(fr1_k14),scalar(leak0_k14),scalar(leak1_k14),scalar(pr0_k14),scalar(pr1_k14)  \ ///
            scalar(fr0_n14),scalar(fr1_n14),scalar(leak0_n14),scalar(leak1_n14),scalar(pr0_n14),scalar(pr1_n14)  \ ///
            scalar(fr0_u14),scalar(fr1_u14),scalar(leak0_u14),scalar(leak1_u14),scalar(pr0_u14),scalar(pr1_u14)  \ ///
            scalar(fr0_z14),scalar(fr1_z14),scalar(leak0_z14),scalar(leak1_z14),scalar(pr0_z14),scalar(pr1_z14)  \ ///
            scalar(fr0_h15),scalar(fr1_h15),scalar(leak0_h15),scalar(leak1_h15),scalar(pr0_h15),scalar(pr1_h15)  \ ///
            scalar(fr0_k15),scalar(fr1_k15),scalar(leak0_k15),scalar(leak1_k15),scalar(pr0_k15),scalar(pr1_k15)  \ ///
            scalar(fr0_n15),scalar(fr1_n15),scalar(leak0_n15),scalar(leak1_n15),scalar(pr0_n15),scalar(pr1_n15)  \ ///
            scalar(fr0_u15),scalar(fr1_u15),scalar(leak0_u15),scalar(leak1_u15),scalar(pr0_u15),scalar(pr1_u15)  \ ///
            scalar(fr0_z15),scalar(fr1_z15),scalar(leak0_z15),scalar(leak1_z15),scalar(pr0_z15),scalar(pr1_z15))
	   
*Labeling columns and rows
mat rownames A ="December-13"  ///
                "March-14"  ///
				"May-14"  ///
				"July-14"  ///
				"September-14"  ///
				"December-14"  ///
				"March-15"  ///
				"May-15"  ///
				"July-15"  ///
				"September-15"  ///
				"December-15"  ///
				
mat colnames A = "Day 0" "Day 1" "Day 0" "Day 1" "Day 0" "Day 1"  
		
*Exporting table
esttab matrix(A, fmt(3)) using $tables\eth_appendix_$outputdate.tex, replace  ///
    booktabs b(a2) title(Ethanol Contract Abnormal Returns) mlabels() 
	
********************************************************************************
*SOYBEAN OIL - ALL CONTRACTS   
********************************************************************************
foreach x in z13 h14 k14 n14 u14 z14 h15 k15 n15 u15 z15 {

	newey d.lsoy_`x' d.lrus  ///
		fr13_0-fr13_1 leak14_0-leak14_1 pr14_0-pr14_1 ///
		t t2-t4 i.day i.month if sample_main==1, lag(5)	

		*Storing even study estimates	
		scalar fr0_`x' = _b[fr13_0]
		scalar fr1_`x' = _b[fr13_1]
		scalar leak0_`x' = _b[leak14_0]
		scalar leak1_`x' = _b[leak14_1]
		scalar pr0_`x' = _b[pr14_0]
		scalar pr1_`x' = _b[pr14_1]

		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if sample_main==1, xb
		gen e=d.lwti_n14-xb if sample_main==1		
			replace e=. if t>=1344 & t<1346 //2013 Final Rule
			replace e=. if t>=1391 & t<1393 //Reuters Article
			replace e=. if t>=1416 & t<1418 //2013 Final Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)	
	drop xb e
}
*
*Creating matrix
matrix A = (scalar(fr0_z13),scalar(fr1_z13),scalar(leak0_z13),scalar(leak1_z13),scalar(pr0_z13),scalar(pr1_z13) \ ///
            scalar(fr0_h14),scalar(fr1_h14),scalar(leak0_h14),scalar(leak1_h14),scalar(pr0_h14),scalar(pr1_h14)  \ ///
            scalar(fr0_k14),scalar(fr1_k14),scalar(leak0_k14),scalar(leak1_k14),scalar(pr0_k14),scalar(pr1_k14)  \ ///
            scalar(fr0_n14),scalar(fr1_n14),scalar(leak0_n14),scalar(leak1_n14),scalar(pr0_n14),scalar(pr1_n14)  \ ///
            scalar(fr0_u14),scalar(fr1_u14),scalar(leak0_u14),scalar(leak1_u14),scalar(pr0_u14),scalar(pr1_u14)  \ ///
            scalar(fr0_z14),scalar(fr1_z14),scalar(leak0_z14),scalar(leak1_z14),scalar(pr0_z14),scalar(pr1_z14)  \ ///
            scalar(fr0_h15),scalar(fr1_h15),scalar(leak0_h15),scalar(leak1_h15),scalar(pr0_h15),scalar(pr1_h15)  \ ///
            scalar(fr0_k15),scalar(fr1_k15),scalar(leak0_k15),scalar(leak1_k15),scalar(pr0_k15),scalar(pr1_k15)  \ ///
            scalar(fr0_n15),scalar(fr1_n15),scalar(leak0_n15),scalar(leak1_n15),scalar(pr0_n15),scalar(pr1_n15)  \ ///
            scalar(fr0_u15),scalar(fr1_u15),scalar(leak0_u15),scalar(leak1_u15),scalar(pr0_u15),scalar(pr1_u15)  \ ///
            scalar(fr0_z15),scalar(fr1_z15),scalar(leak0_z15),scalar(leak1_z15),scalar(pr0_z15),scalar(pr1_z15))
	   
*Labeling columns and rows
mat rownames A ="December-13"  ///
                "March-14"  ///
				"May-14"  ///
				"July-14"  ///
				"September-14"  ///
				"December-14"  ///
				"March-15"  ///
				"May-15"  ///
				"July-15"  ///
				"September-15"  ///
				"December-15"  ///
				
mat colnames A = "Day 0" "Day 1" "Day 0" "Day 1" "Day 0" "Day 1"  
		
*Exporting table
esttab matrix(A, fmt(3)) using $tables\soy_appendix_$outputdate.tex, replace  ///
    booktabs b(a2) title(Soybean Oil Contract Abnormal Returns) mlabels() 	
	
	
********************************************************************************
*CORN - ALL CONTRACTS   
********************************************************************************
foreach x in z13 h14 k14 n14 u14 z14 h15 k15 n15 u15 z15 {

	newey d.lcorn_`x' d.lrus  ///
		fr13_0-fr13_1 leak14_0-leak14_1 pr14_0-pr14_1 ///
		t t2-t4 i.day i.month if sample_main==1, lag(5)	

		*Storing even study estimates	
		scalar fr0_`x' = _b[fr13_0]
		scalar fr1_`x' = _b[fr13_1]
		scalar leak0_`x' = _b[leak14_0]
		scalar leak1_`x' = _b[leak14_1]
		scalar pr0_`x' = _b[pr14_0]
		scalar pr1_`x' = _b[pr14_1]

		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if sample_main==1, xb
		gen e=d.lwti_n14-xb if sample_main==1		
			replace e=. if t>=1344 & t<1346 //2013 Final Rule
			replace e=. if t>=1391 & t<1393 //Reuters Article
			replace e=. if t>=1416 & t<1418 //2013 Final Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)		
	drop xb e
}
*
*Creating matrix
matrix A = (scalar(fr0_z13),scalar(fr1_z13),scalar(leak0_z13),scalar(leak1_z13),scalar(pr0_z13),scalar(pr1_z13) \ ///
            scalar(fr0_h14),scalar(fr1_h14),scalar(leak0_h14),scalar(leak1_h14),scalar(pr0_h14),scalar(pr1_h14)  \ ///
            scalar(fr0_k14),scalar(fr1_k14),scalar(leak0_k14),scalar(leak1_k14),scalar(pr0_k14),scalar(pr1_k14)  \ ///
            scalar(fr0_n14),scalar(fr1_n14),scalar(leak0_n14),scalar(leak1_n14),scalar(pr0_n14),scalar(pr1_n14)  \ ///
            scalar(fr0_u14),scalar(fr1_u14),scalar(leak0_u14),scalar(leak1_u14),scalar(pr0_u14),scalar(pr1_u14)  \ ///
            scalar(fr0_z14),scalar(fr1_z14),scalar(leak0_z14),scalar(leak1_z14),scalar(pr0_z14),scalar(pr1_z14)  \ ///
            scalar(fr0_h15),scalar(fr1_h15),scalar(leak0_h15),scalar(leak1_h15),scalar(pr0_h15),scalar(pr1_h15)  \ ///
            scalar(fr0_k15),scalar(fr1_k15),scalar(leak0_k15),scalar(leak1_k15),scalar(pr0_k15),scalar(pr1_k15)  \ ///
            scalar(fr0_n15),scalar(fr1_n15),scalar(leak0_n15),scalar(leak1_n15),scalar(pr0_n15),scalar(pr1_n15)  \ ///
            scalar(fr0_u15),scalar(fr1_u15),scalar(leak0_u15),scalar(leak1_u15),scalar(pr0_u15),scalar(pr1_u15)  \ ///
            scalar(fr0_z15),scalar(fr1_z15),scalar(leak0_z15),scalar(leak1_z15),scalar(pr0_z15),scalar(pr1_z15))
	   
*Labeling columns and rows
mat rownames A ="December-13"  ///
                "March-14"  ///
				"May-14"  ///
				"July-14"  ///
				"September-14"  ///
				"December-14"  ///
				"March-15"  ///
				"May-15"  ///
				"July-15"  ///
				"September-15"  ///
				"December-15"  ///
				
mat colnames A = "Day 0" "Day 1" "Day 0" "Day 1" "Day 0" "Day 1"  
		
*Exporting table
esttab matrix(A, fmt(3)) using $tables\corn_appendix_$outputdate.tex, replace  ///
    booktabs b(a2) title(Corn Contract Abnormal Returns) mlabels() 	
	

********************************************************************************
*SUGAR - ALL CONTRACTS   
********************************************************************************
foreach x in h14 k14 n14 u14 h15 k15 n15 u15 {

	newey d.lsug_`x' d.lrus  ///
		fr13_0-fr13_1 leak14_0-leak14_1 pr14_0-pr14_1 ///
		t t2-t4 i.day i.month if sample_main==1, lag(5)	

		*Storing even study estimates	
		scalar fr0_`x' = _b[fr13_0]
		scalar fr1_`x' = _b[fr13_1]
		scalar leak0_`x' = _b[leak14_0]
		scalar leak1_`x' = _b[leak14_1]
		scalar pr0_`x' = _b[pr14_0]
		scalar pr1_`x' = _b[pr14_1]

		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb if sample_main==1, xb
		gen e=d.lwti_n14-xb if sample_main==1		
			replace e=. if t>=1344 & t<1346 //2013 Final Rule
			replace e=. if t>=1391 & t<1393 //Reuters Article
			replace e=. if t>=1416 & t<1418 //2013 Final Rule
			_pctile e, p(0.5,2.5,5,95,97.5,99.5) //Summarizing and collecting 1% and 5%
		estadd scalar sq10_lb = r(r3)	
		estadd scalar sq10_ub = r(r4)	
		estadd scalar sq5_lb = r(r2)	
		estadd scalar sq5_ub = r(r5)	
		estadd scalar sq1_lb = r(r1)	
		estadd scalar sq1_ub = r(r6)	
	drop xb e
}
*
*Creating matrix
matrix A = (scalar(fr0_h14),scalar(fr1_h14),scalar(leak0_h14),scalar(leak1_h14),scalar(pr0_h14),scalar(pr1_h14)  \ ///
            scalar(fr0_k14),scalar(fr1_k14),scalar(leak0_k14),scalar(leak1_k14),scalar(pr0_k14),scalar(pr1_k14)  \ ///
            scalar(fr0_n14),scalar(fr1_n14),scalar(leak0_n14),scalar(leak1_n14),scalar(pr0_n14),scalar(pr1_n14)  \ ///
            scalar(fr0_u14),scalar(fr1_u14),scalar(leak0_u14),scalar(leak1_u14),scalar(pr0_u14),scalar(pr1_u14)  \ ///
            scalar(fr0_h15),scalar(fr1_h15),scalar(leak0_h15),scalar(leak1_h15),scalar(pr0_h15),scalar(pr1_h15)  \ ///
            scalar(fr0_k15),scalar(fr1_k15),scalar(leak0_k15),scalar(leak1_k15),scalar(pr0_k15),scalar(pr1_k15)  \ ///
            scalar(fr0_n15),scalar(fr1_n15),scalar(leak0_n15),scalar(leak1_n15),scalar(pr0_n15),scalar(pr1_n15)  \ ///
            scalar(fr0_u15),scalar(fr1_u15),scalar(leak0_u15),scalar(leak1_u15),scalar(pr0_u15),scalar(pr1_u15))
	   
*Labeling columns and rows
mat rownames A ="March-14"  ///
				"May-14"  ///
				"July-14"  ///
				"September-14"  ///
				"March-15"  ///
				"May-15"  ///
				"July-15"  ///
				"September-15"  ///
				
mat colnames A = "Day 0" "Day 1" "Day 0" "Day 1" "Day 0" "Day 1"  
		
*Exporting table
esttab matrix(A, fmt(3)) using $tables\sug_appendix_$outputdate.tex, replace  ///
    booktabs b(a2) title(Sugar Contract Abnormal Returns) mlabels() 	
	
	