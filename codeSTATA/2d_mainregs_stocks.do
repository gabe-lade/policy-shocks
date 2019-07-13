***************************************************************
* POLICY SHOCKS AND RIN PRICES
* MAIN REGRESSIONS AND RESULTS FIGURES: STOCK MARKET EFFECTS
* CODE BY: GABRIEL LADE  
* LAST MAJOR UPDATE: 02/17/2019
***************************************************************

********************************************************************************
*BIOFUEL FIRM STOCK MARKET EFFECTS - BASELINE   
********************************************************************************
********************************************************************************
//preserve
*Keeping only necessary variables for reshape
keep lstock_adm lstock_ande lstock_czz lstock_ff lstock_gevo lstock_gpre ///
	 lstock_meil lstock_ntoiy lstock_peix lstock_regi lstock_szym lrus ///
	 lgs_index t t2-t6 day month date sample_main ///
	 fr13_0 fr13_1 fr13_2 fr13_3 fr13_4 ///
	 leak14_0 leak14_1 leak14_2 leak14_3 leak14_4 ///
	 pr14_0 pr14_1 pr14_2 pr14_3 pr14_4 pr14_5 

*Manipulating stock prices for reshape
keep if sample_main==1	           
	
rename lstock_adm lstock1
rename lstock_ande lstock2
rename lstock_czz lstock3
rename lstock_ff lstock4
rename lstock_gevo lstock5
rename lstock_gpre lstock6
rename lstock_meil lstock7
rename lstock_ntoiy lstock8
rename lstock_peix lstock9
rename lstock_regi lstock10
rename lstock_szym lstock11

reshape long lstock, i(date t) j(cat)
	
gen stock_name="adm" if cat==1
	replace stock_name="ande" if cat==2
	replace stock_name="czz" if cat==3
	replace stock_name="ff" if cat==4
	replace stock_name="gevo" if cat==5
	replace stock_name="gpre" if cat==6
	replace stock_name="meil" if cat==7
	replace stock_name="ntoiy" if cat==8
	replace stock_name="peix" if cat==9
	replace stock_name="regi" if cat==10
	replace stock_name="szym" if cat==11
drop cat	
encode stock_name, gen(stock_n)

**************
*Creating Biofuel Prodocer Type Indicators

* Biodiesel Producers
gen conv=0	
	replace conv=1 if stock_name=="adm"   
	replace conv=1 if stock_name=="ande"   
	replace conv=1 if stock_name=="gpre"   
	replace conv=1 if stock_name=="peix"   
	
* Biodiesel Producers
gen bio=0	
	replace bio=1 if stock_name=="adm"   
	replace bio=1 if stock_name=="ff"     
	replace bio=1 if stock_name=="meil"     
	replace bio=1 if stock_name=="ntoiy"  
	replace bio=1 if stock_name=="regi"    
	replace bio=1 if stock_name=="szym"   

* Advanced Producers (Including Biodiesel Producers)
gen adv=0
	replace adv=1 if stock_name=="adm"   
	replace adv=1 if stock_name=="czz"   
	replace adv=1 if stock_name=="ff"    
	replace adv=1 if stock_name=="gevo"  
	replace adv=1 if stock_name=="meil"  
	replace adv=1 if stock_name=="ntoiy" 
	replace adv=1 if stock_name=="peix"  
	replace adv=1 if stock_name=="regi"  
	replace adv=1 if stock_name=="szym" 

* Advanced Producers (Including Biodiesel Producers)
gen adv_alt=0
	replace adv_alt=1 if stock_name=="czz"   
	replace adv_alt=1 if stock_name=="gevo"  
	replace adv_alt=1 if stock_name=="peix"  	

*Creating policy-biodiesel/advanced firm interactions
local policies fr13_0 fr13_1 fr13_2 fr13_3 fr13_4 ///
			   leak14_0 leak14_1 leak14_2 leak14_3 leak14_4 ///
			   pr14_0 pr14_1 pr14_2 pr14_3 pr14_4
			   
*Biodiesel-Policy Interactions	
foreach x of local policies {
	gen bio_`x'=bio*`x'
}
*	
*Advanced-Policy Interactions	
foreach x of local policies {
	gen adv_`x'=adv*`x'
}
*	
*Advanced(Alternative)-Policy Interactions	
foreach x of local policies {
	gen adv_alt_`x'=adv_alt*`x'
}
*	

**************
*Regression - Grouped Effects, No time controls
eststo clear
sort stock_n t
xtset stock_n t	
eststo xi: reg d.lstock d.lrus d.lgs_index ///
		   fr13_0-fr13_4 leak14_0-leak14_4 pr14_0-pr14_4 i.stock_n, ///
		   vce(cluster stock_n)
		
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
		
		*Number of firms
		distinct stock_name if e(sample)
		estadd scalar n_firms =  r(ndistinct)
	
		*Storing regression descriptor
		estadd local time "No"		
		
		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb, xb
		gen e=d.lstock-xb 
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
		
*Regression - Grouped Effects, Time controls
eststo xi: reg d.lstock d.lrus d.lgs_index ///
		   fr13_0-fr13_4 leak14_0-leak14_4 pr14_0-pr14_4 ///
		   t t2-t4 i.day i.month i.stock_n, vce(cluster stock_n)
		
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
		
		*Number of firms
		distinct stock_name if e(sample)
		estadd scalar n_firms =  r(ndistinct)
		
		*Storing regression descriptor
		estadd local time "Yes"		
		
		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb, xb
		gen e=d.lstock-xb 
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

*Regression - Conventional Firms, No time controls
eststo xi: reg d.lstock d.lrus d.lgs_index ///
		   fr13_0-fr13_4 leak14_0-leak14_4 pr14_0-pr14_4 i.stock_n ///
		   if conv==1, vce(cluster stock_n)
		
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
		
		*Number of firms
		distinct stock_name if e(sample)
		estadd scalar n_firms =  r(ndistinct)
		
		*Storing regression descriptor
		estadd local time "No"			
		
		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb, xb
		gen e=d.lstock-xb 
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
	
*Regression - Advanced Firms, Time controls
eststo xi: reg d.lstock d.lrus d.lgs_index ///
		   fr13_0-fr13_4 leak14_0-leak14_4 pr14_0-pr14_4 ///
		   t t2-t4 i.day i.month i.stock_n if conv==1, ///
		   vce(cluster stock_n)
		
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
		
		*Number of firms
		distinct stock_name if e(sample)
		estadd scalar n_firms =  r(ndistinct)
		
		*Storing regression descriptor
		estadd local time "No"		
		
		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb, xb
		gen e=d.lstock-xb 
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
	
*Regression - Advanced Firms, No time controls
eststo xi: reg d.lstock d.lrus d.lgs_index ///
		   fr13_0-fr13_4 leak14_0-leak14_4 pr14_0-pr14_4 i.stock_n ///
		   if adv_alt==1, vce(cluster stock_n)
		
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
		
		*Number of firms
		distinct stock_name if e(sample)
		estadd scalar n_firms =  r(ndistinct)
		
		*Storing regression descriptor
		estadd local time "No"			
		
		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb, xb
		gen e=d.lstock-xb 
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
	
*Regression - Advanced Firms, Time controls
eststo xi: reg d.lstock d.lrus d.lgs_index ///
		   fr13_0-fr13_4 leak14_0-leak14_4 pr14_0-pr14_4 ///
		   t t2-t4 i.day i.month i.stock_n if adv_alt==1, ///
		   vce(cluster stock_n)
		
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
		
		*Number of firms
		distinct stock_name if e(sample)
		estadd scalar n_firms =  r(ndistinct)
		
		*Storing regression descriptor
		estadd local time "No"		
		
		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb, xb
		gen e=d.lstock-xb 
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
	
*Regression - Biodiesel Firms, No time controls
eststo xi: reg d.lstock d.lrus d.lgs_index ///
		fr13_0-fr13_4 leak14_0-leak14_4 pr14_0-pr14_4 i.stock_n ///
		if bio==1, vce(cluster stock_n)	
		
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
		
		*Number of firms
		distinct stock_name if e(sample)
		estadd scalar n_firms =  r(ndistinct)
		
		*Storing regression descriptor
		estadd local time "No"		
		
		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb, xb
		gen e=d.lstock-xb 
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
	est store G
	
*Regression - Biodiesel Firms, Time controls
eststo xi: reg d.lstock d.lrus d.lgs_index ///
		fr13_0-fr13_4 leak14_0-leak14_4 pr14_0-pr14_4 ///
		t t2-t4 i.day i.month i.stock_n if bio==1, vce(cluster stock_n)
		
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
		
		*Number of firms
		distinct stock_name if e(sample)
		estadd scalar n_firms =  r(ndistinct)
		
		*Storing regression descriptor
		estadd local time "Yes"		
		
		*Generating and storing SQ critical values - Removing 'shock' days
		predict xb, xb
		gen e=d.lstock-xb 
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
	est store H
	
esttab A B C D E F G H using $tables\rinbiofirms_$outputdate.tex, replace label ///
    booktabs b(a2) nonumber ///
	drop(fr13* leak14* pr14* t* D* 1* 2* 3* 4* 5* 6* 7* 8* 9* _cons) ///
    starlevels(* 0.10 ** 0.05 *** 0.01) ///
	title(RIN Even Study Regression Results \\ (Dependent Variable: ///
	Log Biofuel Firm Stock Prices) \label{table:firms2})  ///
	cells(b(fmt(3) star) se(fmt(3) par)) ///
	scalars("fr13_0 2013 Final Rule: Day 0" "fr13_1   Day 1" ///
		    "fr13_2 Day 2" "fr13_3  Day 3" ///
			"fr13_4 Day 4" "leak14_0 Reuters Article: Day 0" ///
		    "leak14_1 Day 1" "leak14_2 Day 2" ///
		    "leak14_3 Day 3" "leak14_4 Day 4" ///
	        "pr14_0 2014 Proposed Rule: Day 0" "pr14_1 Day 1" ///
	        "pr14_2 Day 2" "pr14_3 Day 3" ///
			"pr14_4 Day 4" "n_firms Firms" "time Time Controls" ///
			"sq10_lb SQ 10\% Lower Bound" "sq10_ub SQ 10\% Upper Bound" /// 
			"sq5_lb SQ 5\% Lower Bound" "sq5_ub SQ 5\% Upper Bound" /// 
			"sq1_lb SQ 1\% Lower Bound" "sq1_ub SQ 1\% Upper Bound") sfmt(3) ///			
	 mlabels((1) (2) (3) (4) (5) (6) (7) (8)) collabels(none) ///
	 note(Results are presented grouping for all firms, advanced biofuel firms, ///
	      and biodiesel firms. All regressions include controls for returns ///
		  due to changes in the Russell 3000 index and the S\&P-GS ///
		  commodity index. Inference for abnormal returns are based on  ///
	      SQ critical values given at the bottom of the table. ///
		  *, **, and ***  denote significance at  the 10\%, 5\%, ///
		  and 1\% confidence  levels, respectively.)  	
	

/*	
*Defining biofuel companies
local bio adm ande czz ff gevo gpre kior meil ntoiy peix regi szym vlo
	
* Converting everything to log returns
gen mret=log(rus/l.rus)
drop rus

foreach v of local bio {
 		gen `v'ret=log(`v'/l.`v')
		drop `v'
}
		
*******************************************************************
* Restricting estimation window to 120 days before event
* Note: First event occurs on t=400, event windows are therefore
*			120 days: drop if t<280
*			90 days:  drop if t<310
*			60 days:  drop if t<340
*******************************************************************
drop if t<340

* Flexible Time Controls
gen q=_n
gen q2=q^2
gen q3=q^3
gen q4=q^4
gen q5=q^5
gen q6=q^6
gen day=dow(date)
gen month=month(date)

* Estimating log returns model 
foreach v of local bio {
	preserve
	
	keep date t mret fr2013* leak* pr2014* `v'ret

	quietly newey `v'ret fr2013* leak* pr2014* mret, lag(5)
			 
	* Saving Regression Results
	regsave
	keep var coef stderr N
	rename coef coef_`v'
	rename stderr se_`v'
	rename N N_`v'
	saveold reg_`v', replace 
	
	restore
}

* Estimating log returns model with time controls
foreach v of local bio {
	preserve
	
	keep date t mret fr2013* leak* pr2014* q* day month `v'ret

	quietly newey `v'ret fr2013* leak* pr2014* mret q* day month, lag(5)
			 
	* Saving Regression Results
	regsave
	keep var coef stderr N
	rename coef coef_`v'_flex
	rename stderr se_`v'_flex
	rename N N_`v'_flex
	saveold reg_`v'_flex, replace 
	
	restore
}


* Combining Coefficient Results
use reg_adm, clear
local bio2 ande czz ff gevo gpre kior meil ntoiy peix regi szym vlo
		  
foreach v of local bio2 {
	merge 1:1 var using reg_`v'
	drop _merge
	pause
	saveold log_coefs, replace
}


foreach v of local bio {
	merge 1:1 var using reg_`v'_flex
	drop _merge
	pause
	saveold log_coefs, replace
}

encode var, gen(var1)
drop var
rename var1 var
order var
//export excel using "C:\Users\lade\Desktop\Analysis (New)\2013 rins\stata\yahoo stock prices\Stock_Ind_Results60.xls", firstrow(variables) replace
outsheet using "C:\Users\Gabriel\Dropbox\RIN Project\Analysis (New)\2013 rins\stata yahoo stock prices\Stock_Ind_Results60.csv", comma replace
*/

*********************************************
*********************************************
* Event study estimates - Combined Regressions 
*********************************************
*********************************************
use stocks, clear

*************************************************************************
*************************************************************************
*************************************************************************
* Data Management
*************************************************************************
*************************************************************************
*************************************************************************
local bio adm ande czz ff gevo gpre kior meil ntoiy peix regi szym vlo

* Converting everything to log returns
gen mret=log(rus/l.rus)
drop rus

foreach v of local bio {
 		gen stock`v'=log(`v'/l.`v')
		drop `v'
}
          
* Renaming variables
rename stockadm stock1 
rename stockande stock2
rename stockczz stock3
rename stockff stock4
rename stockgevo stock5
rename stockgpre stock6
rename stockkior stock7
rename stockmeil stock8
rename stockntoiy stock9
rename stockpeix stock10
rename stockregi stock11
rename stockszym stock12
rename stockvlo stock13

*******************************************************************
* Restricting estimation window to 120 days before event
* Note: First event occurs on t=400, event windows are therefore
*			120 days: drop if t<280
*			90 days:  drop if t<310
*			60 days:  drop if t<340
*******************************************************************
drop if t<280
drop leak* fr* pr*

reshape long stock, i(t mret date) j(id)
rename stock price



**********************
*2013 Final Rule 
* Note: - Occurs on 8/6/2013 (t=400)
**********************
foreach x of numlist  400(1)405 {
	local j=`x'-400
	gen fr2013_`j'=0
	replace fr2013_`j'=1 if t==`x'
	}

**********************
* Reuters Leaked Article
* Note: - Occurs on 10/11/2013 (t=447)
**********************
foreach x of numlist  447(1)452 {
	local j=`x'-447
	gen leak_`j'=0
	replace leak_`j'=1 if t==`x'
	}

**********************
* 2014 Proposed Rule
* Note: - Occurs on 11/15/2013 (t=472)
**********************
foreach x of numlist  472(1)477 {
	local j=`x'-472
	gen pr2014_`j'=0
	replace pr2014_`j'=1 if t==`x'
	}

**********************
* Classification Indicators
**********************	
* Biodiesel Producers
gen bio=0	
	replace bio=1 if stock==1    //adm
	replace bio=1 if stock==4    //ff
	replace bio=1 if stock==8    //meil
	replace bio=1 if stock==9    //ntoiy
	replace bio=1 if stock==11   //regi
	replace bio=1 if stock==12   //szym

* Cellulosic Producers
gen cell=0
	replace cell=1 if stock==7   //kior

* Advanced Producers
gen adv=0
	replace adv=1 if stock==1    //adm
	replace adv=1 if stock==3    //czz
	replace adv=1 if stock==4    //ff
	replace adv=1 if stock==5    //gevo
	replace adv=1 if stock==7    //kior
	replace adv=1 if stock==8    //meil
	replace adv=1 if stock==9    //ntoiy
	replace adv=1 if stock==10   //peix
	replace adv=1 if stock==11   //regi
	replace adv=1 if stock==12   //szym

	

order date t stock price fr* leak* pr*

* Generating flexible time controls
drop t
gen t=_n
gen t2=t^2
gen t3=t^3
gen t4=t^4
gen t5=t^5
gen t6=t^6
gen day=dow(date)
gen month=month(date)
	
sort t stock

*************************************************************************
*************************************************************************
*************************************************************************
* Regressions
*************************************************************************
*************************************************************************
*************************************************************************
drop if stock==7 //Droping Kior!

xtset stock t
eststo clear	

eststo: reg price fr2013_* leak* pr2014* /// 
			adv_fr* adv_leak* adv_pr2014* ///
            bio_fr* bio_leak* bio_pr2014* ///
			mret i.stock, cluster(stock)
	
******************************************************
*****************************************************
* Event Day CARs
*****************************************************
*****************************************************
* Conventional 
lincom fr2013_0 
test fr2013_0  =0

* Advanced  
lincom fr2013_0  + adv_fr2013_0 
test fr2013_0 + adv_fr2013_0   =0

* Biodiesel 
lincom fr2013_0 +adv_fr2013_0   + bio_fr2013_0   
test fr2013_0 +adv_fr2013_0   + bio_fr2013_0   =0


*****************************************************
*****************************************************
* 2 Day CARs
*****************************************************
*****************************************************
* Conventional 
lincom fr2013_0 + fr2013_1 + fr2013_2  
test fr2013_0 + fr2013_1 + fr2013_2 =0

* Advanced  
lincom fr2013_0 + fr2013_1 + fr2013_2  + adv_fr2013_0 + adv_fr2013_1 + adv_fr2013_2 
test fr2013_0 + fr2013_1 + fr2013_2  + adv_fr2013_0 + adv_fr2013_1 + adv_fr2013_2  =0

* Biodiesel - 5 Day
lincom fr2013_0 + fr2013_1 + fr2013_2   + ///
adv_fr2013_0 + adv_fr2013_1 + adv_fr2013_2  + ///
bio_fr2013_0 + bio_fr2013_1 + bio_fr2013_2  

test fr2013_0 + fr2013_1 + fr2013_2  + ///
adv_fr2013_0 + adv_fr2013_1 + adv_fr2013_2  + ///
bio_fr2013_0 + bio_fr2013_1 + bio_fr2013_2   =0 


*****************************************************
*****************************************************
* 5 Day
*****************************************************
*****************************************************
* Conventional - 5 Day
lincom fr2013_0 + fr2013_1 + fr2013_2 + fr2013_3 + fr2013_4 + fr2013_5

test fr2013_0 + fr2013_1 + fr2013_2 + fr2013_3 + fr2013_4 + fr2013_5=0

* Advanced - 5 Day
lincom fr2013_0 + fr2013_1 + fr2013_2 + fr2013_3 + fr2013_4 + fr2013_5 + ///
adv_fr2013_0 + adv_fr2013_1 + adv_fr2013_2 + adv_fr2013_3 + adv_fr2013_4 + adv_fr2013_5

test fr2013_0 + fr2013_1 + fr2013_2 + fr2013_3 + fr2013_4 + fr2013_5 + ///
adv_fr2013_0 + adv_fr2013_1 + adv_fr2013_2 + adv_fr2013_3 + adv_fr2013_4 + adv_fr2013_5 =0

* Biodiesel - 5 Day
lincom fr2013_0 + fr2013_1 + fr2013_2 + fr2013_3 + fr2013_4 + fr2013_5 + ///
adv_fr2013_0 + adv_fr2013_1 + adv_fr2013_2 + adv_fr2013_3 + adv_fr2013_4 + adv_fr2013_5 + ///
bio_fr2013_0 + bio_fr2013_1 + bio_fr2013_2 + bio_fr2013_3 + bio_fr2013_4 + bio_fr2013_5 

test fr2013_0 + fr2013_1 + fr2013_2 + fr2013_3 + fr2013_4 + fr2013_5 + ///
adv_fr2013_0 + adv_fr2013_1 + adv_fr2013_2 + adv_fr2013_3 + adv_fr2013_4 + adv_fr2013_5 + ///
bio_fr2013_0 + bio_fr2013_1 + bio_fr2013_2 + bio_fr2013_3 + bio_fr2013_4 + bio_fr2013_5 =0 


*****************************************************************************
*****************************************************************************
* With Time Controls
*****************************************************************************
*****************************************************************************
eststo: reg price fr2013_* leak* pr2014* ///
			adv_fr* adv_leak* adv_pr2014* ///
            bio_fr* bio_leak* bio_pr2014* ///
			mret i.stock i.day i.month t*, cluster(stock)
			
******************************************************
*****************************************************
* Event Day CARs
*****************************************************
*****************************************************
* Conventional 
lincom fr2013_0 
test fr2013_0  =0

* Advanced  
lincom fr2013_0  + adv_fr2013_0 
test fr2013_0 + adv_fr2013_0   =0

* Biodiesel 
lincom fr2013_0 +adv_fr2013_0   + bio_fr2013_0   
test fr2013_0 +adv_fr2013_0   + bio_fr2013_0   =0


*****************************************************
*****************************************************
* 2 Day CARs
*****************************************************
*****************************************************
* Conventional 
lincom fr2013_0 + fr2013_1 + fr2013_2  
test fr2013_0 + fr2013_1 + fr2013_2 =0

* Advanced  
lincom fr2013_0 + fr2013_1 + fr2013_2  + adv_fr2013_0 + adv_fr2013_1 + adv_fr2013_2 
test fr2013_0 + fr2013_1 + fr2013_2  + adv_fr2013_0 + adv_fr2013_1 + adv_fr2013_2  =0

* Biodiesel - 5 Day
lincom fr2013_0 + fr2013_1 + fr2013_2   + ///
adv_fr2013_0 + adv_fr2013_1 + adv_fr2013_2  + ///
bio_fr2013_0 + bio_fr2013_1 + bio_fr2013_2  

test fr2013_0 + fr2013_1 + fr2013_2  + ///
adv_fr2013_0 + adv_fr2013_1 + adv_fr2013_2  + ///
bio_fr2013_0 + bio_fr2013_1 + bio_fr2013_2   =0 


*****************************************************
*****************************************************
* 5 Day
*****************************************************
*****************************************************
* Conventional - 5 Day
lincom fr2013_0 + fr2013_1 + fr2013_2 + fr2013_3 + fr2013_4 + fr2013_5

test fr2013_0 + fr2013_1 + fr2013_2 + fr2013_3 + fr2013_4 + fr2013_5=0

* Advanced - 5 Day
lincom fr2013_0 + fr2013_1 + fr2013_2 + fr2013_3 + fr2013_4 + fr2013_5 + ///
adv_fr2013_0 + adv_fr2013_1 + adv_fr2013_2 + adv_fr2013_3 + adv_fr2013_4 + adv_fr2013_5

test fr2013_0 + fr2013_1 + fr2013_2 + fr2013_3 + fr2013_4 + fr2013_5 + ///
adv_fr2013_0 + adv_fr2013_1 + adv_fr2013_2 + adv_fr2013_3 + adv_fr2013_4 + adv_fr2013_5 =0

* Biodiesel - 5 Day
lincom fr2013_0 + fr2013_1 + fr2013_2 + fr2013_3 + fr2013_4 + fr2013_5 + ///
adv_fr2013_0 + adv_fr2013_1 + adv_fr2013_2 + adv_fr2013_3 + adv_fr2013_4 + adv_fr2013_5 + ///
bio_fr2013_0 + bio_fr2013_1 + bio_fr2013_2 + bio_fr2013_3 + bio_fr2013_4 + bio_fr2013_5 

test fr2013_0 + fr2013_1 + fr2013_2 + fr2013_3 + fr2013_4 + fr2013_5 + ///
adv_fr2013_0 + adv_fr2013_1 + adv_fr2013_2 + adv_fr2013_3 + adv_fr2013_4 + adv_fr2013_5 + ///
bio_fr2013_0 + bio_fr2013_1 + bio_fr2013_2 + bio_fr2013_3 + bio_fr2013_4 + bio_fr2013_5 =0 

			
esttab using stock_agg_fr13.csv, cells(b(star fmt(3)) se(par fmt(3)))  star(* 0.05 ** 0.01)  replace
esttab using stock_agg_fr13_plain.csv, cells(b(fmt(3))  se(par fmt(3)))  plain  replace
