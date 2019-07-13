***************************************************************
*POLICY SHOCKS AND RIN PRICES
*FIGURES, SUMMARY STATISTICS, & UNIT ROOT TESTS
*CODE BY: GABRIEL LADE  
*LAST MAJOR UPDATE: 10/04/2016 
***************************************************************

***************************************************************
*Graphing Front-to-Prior Year Conventional RIN Spreads
*Notes: - First construct front-year RIN prices. 
***************************************************************

*Conventional RINs Spread
gen conv_spread=.
	replace conv_spread =prin_eth12-prin_eth11 if year==2012
	replace conv_spread =prin_eth13-prin_eth12 if year==2013
	replace conv_spread =prin_eth14-prin_eth13 if year==2014

*Biodiesel RINs Spread
gen bio_spread=.
	replace bio_spread =prin_bio12-prin_bio11 if year==2012
	replace bio_spread =prin_bio13-prin_bio12 if year==2013
	replace bio_spread =prin_bio14-prin_bio13 if year==2014
	
*Advanced RINs Spread	
gen adv_spread=.
	replace adv_spread =prin_adv12-prin_adv11 if year==2012
	replace adv_spread =prin_adv13-prin_adv12 if year==2013
	replace adv_spread =prin_adv14-prin_adv13 if year==2014
	
*Smoothing - 5 day moving average
tssmooth ma conv_spread_ma = conv_spread, window(10)
tssmooth ma bio_spread_ma = bio_spread, window(10)
tssmooth ma adv_spread_ma = adv_spread, window(10)

*Summarizing
sum conv_spread_ma if year<2014

*Graph	
twoway (line conv_spread_ma date if !missing(conv_spread_ma) & date<=19858, lc(orange) lw(medium) lp(solid)) ///
	   (line adv_spread_ma date if !missing(adv_spread_ma) & date<=19858, lc(blue) lw(medthick) lp(longdash)) ///
	   (line bio_spread_ma date if !missing(bio_spread_ma) & date<=19858, lc(red) lw(medthick) lp(shortdash)), ///
	   graphregion(color(white)) bgcolor(white) ///
	   xtitle("") /// 
	   ylabel(-10(10)30, nogrid angle(0)) ///
	   legend(on pos(1) ring(0) col(1)   ///
	          order(1 "Front-to-Prior Year Conventional Spread" ///
			        2 "Front-to-Prior Year Advanced Spread" ///
	                3 "Front-to-Prior Year Biodiesel Spread") ///
	   region(lcolor(white))) ///
       yline(0, lc(black)) ///
	   ytitle("RIN Price Spread (cents/gal)") ///
	   xlabel(18995 "Jan 2012" 19176 "July 2012"   ///
		      19360 "Jan 2013" 19540 "July 2013"   ///
		      19725 "Jan 2014" 19905 "July 2014",  angle(45))
graph export $figs\conv_rin_spreads_$outputdate.png, width(4000) replace	
drop conv_spread adv_spread bio_spread adv_spread_ma bio_spread_ma

***************************************************************
*Graphing Advanced and Biodiesel to Conventional Price Spreads
*Notes: - Spreads constructed from front-year RIN prices. 
***************************************************************

*Advanced RINs Spread
gen adv_spread=.
	replace adv_spread =prin_adv12-prin_eth12 if year==2012
	replace adv_spread =prin_adv13-prin_eth13 if year==2013
	replace adv_spread =prin_adv14-prin_eth14 if year==2014

*Biodiesel RINs Spread
gen bio_spread=.
	replace bio_spread =prin_bio12-prin_eth12 if year==2012
	replace bio_spread =prin_bio13-prin_eth13 if year==2013
	replace bio_spread =prin_bio14-prin_eth14 if year==2014
	
*Smoothing - 5 day moving average
tssmooth ma adv_spread_ma = adv_spread, window(10)
tssmooth ma bio_spread_ma = bio_spread, window(10)

*Summarizing
sum adv_spread_ma if year<2013
sum bio_spread_ma if year<2013
sum adv_spread_ma if year>=2013
sum bio_spread_ma if year>=2013

*Graph	
twoway (line adv_spread_ma date if adv_spread_ma!=. & date<=19858, lc(blue) lw(medthick) lp(longdash)) ///
       (line bio_spread_ma date if bio_spread_ma!=. & date<=19858, lc(red) lw(medthick) lp(shortdash)),  ///
	   graphregion(color(white)) bgcolor(white) ///
	   xtitle("")  /// 
	   ylabel(0(40)160, nogrid angle(0)) ///
	   legend(pos(1) ring(0) col(1)   ///
	           order(1 "Advanced-Conventional Spread" ///
					2 "Biodiesel-Conventional Spread") ///
	   region(lcolor(white))  ) ///
	   ytitle("RIN Price Spread (cents/gal)") ///
	   xlabel(18995 "Jan 2012" 19176 "July 2012"   ///
		      19360 "Jan 2013" 19540 "July 2013"   ///
		      19725 "Jan 2014" 19905 "July 2014",  angle(45))
graph export $figs\rin_spreads_$outputdate.png, width(4000) replace	

***************************************************************
*2013 RIN GRAPH
*Notes: - 2013 PR released on 1/31/2013 (date=19389, t=1215)
*       - 2013 FR released on 8/6/2016 (date=19576, t=1344)
*       - Reuters Article released on 10/11/2013 (date=19642, t=1391)
*       - 2014 PR released on 11/15/2013 (date=19677, t=1416)
***************************************************************	
twoway (line prin_eth13 date if sample_main==1, lc(orange) lw(medium) lp(solid)) ///
       (line prin_adv13 date if sample_main==1, lc(blue) lw(medthick) lp(longdash)) ///
       (line prin_bio13 date if sample_main==1, lc(red) lw(medthick) lp(shortdash)),  ///
	   graphregion(color(white)) bgcolor(white) ///
	   xtitle("")  /// 
	   ylabel(0(20)160, nogrid angle(0)) ///
	   xline(19576, lcolor(black) lp(solid)) ///
	   text(158 19556 "1", placement(e) size(vlarge)) ///
	   xline(19642, lcolor(black) lp(solid)) ///
	   text(158 19622 "2", placement(e) size(vlarge)) ///
	   xline(19677, lcolor(black) lp(solid)) ///
	   text(158 19657 "3", placement(e) size(vlarge)) ///
	   legend(order(1 "Conventional" 2 "Advanced" 3 "Biodiesel") ///
	   region(lcolor(white)) rows(1)) ///
	   ytitle("RIN Price (cents/gal)")  ///
	   xlabel(19211 "Aug 2012" 19267 "Oct 2012" 19330 "Dec 2012" ///
		      19390 "Feb 2013" 19449 "Apr 2013" 19512 "Jun 2013" ///
		      19571 "Aug 2013" 19632 "Oct 2013" 19694 "Dec 2013" ///
		      19757 "Feb 2014" 19814 "Apr 2014", angle(45))
graph export $figs\rin_prices_$outputdate.png, width(4000) replace

*Summarizing data
sum prin_eth13 if year<2013
sum prin_adv13 if year<2013
sum prin_bio13 if year<2013

***************************************************************
*SUMMARY STATISTICS
***************************************************************
eststo clear
******
*2013 Ethanol RINs
sum prin_eth13 if sample_main==1, det
	scalar pe13_m = r(mean)	
	scalar pe13_sd=r(sd)
	scalar pe13_min=r(min)
	scalar pe13_max=r(max)
	scalar pe13_n=r(N)
	
******
*2013 Advanced RINs
qui sum prin_adv13 if sample_main==1, det
	scalar pa13_m = r(mean)	
	scalar pa13_sd=r(sd)
	scalar pa13_min=r(min)
	scalar pa13_max=r(max)
	scalar pa13_n=r(N)
	
******
*2013 Biodiesel RINs
qui sum prin_bio13 if sample_main==1, det
	scalar pb13_m = r(mean)	
	scalar pb13_sd=r(sd)
	scalar pb13_min=r(min)
	scalar pb13_max=r(max)
	scalar pb13_n=r(N)	
	
******
*July 2014 WTI Oil Futures  
qui sum wti_n14 if sample_main==1, det
	scalar oilfut_m = r(mean)	
	scalar oilfut_sd=r(sd)
	scalar oilfut_min=r(min)
	scalar oilfut_max=r(max)
	scalar oilfut_n=r(N)	
	
******
*July 2014 Ethanol Futures  
qui sum eth_n14 if sample_main==1, det
	scalar ethfut_m = r(mean)	
	scalar ethfut_sd=r(sd)
	scalar ethfut_min=r(min)
	scalar ethfut_max=r(max)
	scalar ethfut_n=r(N)	
	
******
*July 2014 Soybean Oil Futures  
qui sum soy_n14 if sample_main==1, det
	scalar soyfut_m = r(mean)	
	scalar soyfut_sd=r(sd)
	scalar soyfut_min=r(min)
	scalar soyfut_max=r(max)
	scalar soyfut_n=r(N)	
	
******
*July 2014 Corn Futures  
qui sum corn_n14 if sample_main==1, det
	scalar cornfut_m = r(mean)	
	scalar cornfut_sd=r(sd)
	scalar cornfut_min=r(min)
	scalar cornfut_max=r(max)
	scalar cornfut_n=r(N)		
	
******
*July 2014 Sugar Futures  
qui sum sug_n14 if sample_main==1, det
	scalar sugfut_m = r(mean)	
	scalar sugfut_sd=r(sd)
	scalar sugfut_min=r(min)
	scalar sugfut_max=r(max)
	scalar sugfut_n=r(N)	

******
*S&P-GS Commodity Index 
qui sum gs_index if sample_main==1, det
	scalar gs_m = r(mean)	
	scalar gs_sd=r(sd)
	scalar gs_min=r(min)
	scalar gs_max=r(max)
	scalar gs_n=r(N)
	
******  
*Russell 3000 Index 
qui sum rus if sample_main==1, det
	scalar rus_m = r(mean)	
	scalar rus_sd=r(sd)
	scalar rus_min=r(min)
	scalar rus_max=r(max)
	scalar rus_n=r(N)	
	
*Creating matrix
matrix A = (scalar(pe13_m),scalar(pe13_sd),scalar(pe13_min),scalar(pe13_max),scalar(pe13_n) \ ///
            scalar(pa13_m),scalar(pa13_sd),scalar(pa13_min),scalar(pa13_max),scalar(pa13_n) \ ///
            scalar(pb13_m),scalar(pb13_sd),scalar(pb13_min),scalar(pb13_max),scalar(pb13_n) \ ///
            scalar(oilfut_m),scalar(oilfut_sd),scalar(oilfut_min),scalar(oilfut_max),scalar(oilfut_n) \ ///
            scalar(ethfut_m),scalar(ethfut_sd),scalar(ethfut_min),scalar(ethfut_max),scalar(ethfut_n) \ ///
            scalar(soyfut_m),scalar(soyfut_sd),scalar(soyfut_min),scalar(soyfut_max),scalar(soyfut_n) \ ///
            scalar(cornfut_m),scalar(cornfut_sd),scalar(cornfut_min),scalar(cornfut_max),scalar(cornfut_n) \ ///
            scalar(sugfut_m),scalar(sugfut_sd),scalar(sugfut_min),scalar(sugfut_max),scalar(sugfut_n) \ ///
            scalar(gs_m),scalar(gs_sd),scalar(gs_min),scalar(gs_max),scalar(gs_n) \ ///
            scalar(rus_m),scalar(rus_sd),scalar(rus_min),scalar(rus_max),scalar(rus_n))
	   
*Labeling columns and rows
mat rownames A = "2013 Conventional (D6) RINs"  ///
                "2013 Advanced (D5) RINs"  ///
                "2013 Biodiesel (D5) RINs"  ///
                "July 2014 WTI Oil Futures"  ///
                "July 2014 Ethanol Futures"  ///
                "July 2014 Soybean Oil Futures" ///
                "July 2014 Corn Futures" ///
                "July 2014 Sugar Futures" ///  
                "S\&P-GS Commodity Index" ///  
                "Russell 3000 Index"  
				
mat colnames A = "Mean" "Std. Dev." "Min" "Max" "N"  
		
*Exporting table
esttab matrix(A, fmt(2)) using $tables\sumstats_$outputdate.tex, replace  ///
    booktabs b(a2) title(Summary Statistics \label{table:sum1}) mlabels() 

***************************************************************
*UNIT ROOT TESTS
*Notes: -DFGLS tests for the log of each price series with 1, 5, & 10 lags. 
***************************************************************
eststo clear

*Ethanol RINs
dfgls lprin_eth13 if sample_main==1, maxlag(10)
  	matrix pe13_dfgls = r(results)	
	scalar pe13_l1 = pe13_dfgls[10,5]	
	scalar pe13_l5 = pe13_dfgls[6,5]	
	scalar pe13_l10 = pe13_dfgls[1,5]	

*Advanced RINs	
dfgls lprin_adv13 if sample_main==1, maxlag(10)
  	matrix pa13_dfgls = r(results)	
	scalar pa13_l1 = pa13_dfgls[10,5]	
	scalar pa13_l5 = pa13_dfgls[6,5]	
	scalar pa13_l10 = pa13_dfgls[1,5]	  
  
*Biodiesel RINs	
dfgls lprin_bio13 if sample_main==1, maxlag(10)
  	matrix pb13_dfgls = r(results)	
	scalar pb13_l1 = pb13_dfgls[10,5]	
	scalar pb13_l5 = pb13_dfgls[6,5]	
	scalar pb13_l10 = pb13_dfgls[1,5]	 
	
*July 2014 Oil Futures
dfgls lwti_n14 if sample_main==1, maxlag(10)
  	matrix oil_dfgls = r(results)	
	scalar oil_l1 = oil_dfgls[10,5]	
	scalar oil_l5 = oil_dfgls[6,5]	
	scalar oil_l10 = oil_dfgls[1,5]	 

*July 2014 Ethanol Futures
dfgls leth_n14 if sample_main==1, maxlag(10)
  	matrix eth_dfgls = r(results)	
	scalar eth_l1 = eth_dfgls[10,5]	
	scalar eth_l5 = eth_dfgls[6,5]	
	scalar eth_l10 = eth_dfgls[1,5]	
	
*July 2014 Soybean Oil Futures
dfgls lsoy_n14 if sample_main==1, maxlag(10)
  	matrix soy_dfgls = r(results)	
	scalar soy_l1 = soy_dfgls[10,5]	
	scalar soy_l5 = soy_dfgls[6,5]	
	scalar soy_l10 = soy_dfgls[1,5]	
	
*July 2014 Corn Futures
dfgls lcorn_n14 if sample_main==1, maxlag(10)
  	matrix corn_dfgls = r(results)	
	scalar corn_l1 = corn_dfgls[10,5]	
	scalar corn_l5 = corn_dfgls[6,5]	
	scalar corn_l10 = corn_dfgls[1,5]	
	
*July 2014 Sugar Futures
dfgls lsug_n14 if sample_main==1, maxlag(10)
  	matrix sug_dfgls = r(results)	
	scalar sug_l1 = sug_dfgls[10,5]	
	scalar sug_l5 = sug_dfgls[6,5]	
	scalar sug_l10 = sug_dfgls[1,5]
	
*Goldman Sachs Commodity Price Index
dfgls lgs_index if sample_main==1, maxlag(10)
  	matrix gs_dfgls = r(results)	
	scalar gs_l1 = gs_dfgls[10,5]	
	scalar gs_l5 = gs_dfgls[6,5]	
	scalar gs_l10 = gs_dfgls[1,5]	
	
*Russell 3000 Index
dfgls lrus if sample_main==1, maxlag(10)
  	matrix rus_dfgls = r(results)	
	scalar rus_l1 = rus_dfgls[10,5]	
	scalar rus_l5 = rus_dfgls[6,5]	
	scalar rus_l10 = rus_dfgls[1,5]	
	
*Creating matrix
matrix A = (scalar(pe13_l1),scalar(pe13_l5),scalar(pe13_l10) \ ///
            scalar(pa13_l1),scalar(pa13_l5),scalar(pa13_l10) \ ///
            scalar(pb13_l1),scalar(pb13_l5),scalar(pb13_l10) \ ///
            scalar(oil_l1),scalar(oil_l5),scalar(oil_l10) \ ///
            scalar(eth_l1),scalar(eth_l5),scalar(eth_l10) \ ///
            scalar(soy_l1),scalar(soy_l5),scalar(soy_l10) \ ///
            scalar(corn_l1),scalar(corn_l5),scalar(corn_l10) \ ///
            scalar(sug_l1),scalar(sug_l5),scalar(sug_l10) \ ///
            scalar(gs_l1),scalar(gs_l5),scalar(gs_l10) \ ///
            scalar(rus_l1),scalar(rus_l5),scalar(rus_l10))
			
*Labeling columns and rows
mat rownames A ="Conventional RINs"  ///
                "Advanced RINs"  ///
                "Biodiesel RINs"  ///
                "Oil Futures"  ///
                "Ethanol Futures"  ///
                "Soybean Oil Futures" ///
                "Corn Futures" ///
                "Sugar Futures" ///
                "S\&P-GS Commodity Index" ///
                "Russell 3000 Index" 
			
mat colnames A = "1" "5" "10" 
		
*Exporting table
esttab matrix(A, fmt(2)) using $tables\unit_root_$outputdate.tex, replace  ///
    booktabs b(a2) title(Unit Root \label{table:df}) mlabels() 

***************************************************************
*COINTEGRATION TESTS
*Notes: - Estimates Engle-Granger cointegration test for each combination of
*         price series used in the event study analysis. 
***************************************************************
eststo clear

*Cointegration Test - Ethanol RINs and Oil, Ethanol, and Soybean Oil
egranger lprin_eth13 lwti_n14 leth_n14 lsoy_n14 if sample_main==1, lags(1) trend	
	scalar pe13_eg1 = e(Zt)
egranger lprin_eth13 lwti_n14 leth_n14 lsoy_n14 if sample_main==1, lags(5) trend	
	scalar pe13_eg5 = e(Zt)
egranger lprin_eth13 lwti_n14 leth_n14 lsoy_n14 if sample_main==1, lags(10) trend	
	scalar pe13_eg10 = e(Zt)
	
*Cointegration Test - Advanced RINs and Oil, Ethanol, and Soybean Oil
egranger lprin_adv13 lwti_n14 leth_n14 lsoy_n14 if sample_main==1, lags(1) trend	
	scalar pa13_eg1 = e(Zt)
egranger lprin_adv13 lwti_n14 leth_n14 lsoy_n14 if sample_main==1, lags(5) trend	
	scalar pa13_eg5 = e(Zt)
egranger lprin_adv13 lwti_n14 leth_n14 lsoy_n14 if sample_main==1, lags(10) trend	
	scalar pa13_eg10 = e(Zt)	
	
*Cointegration Test - Biodiesel RINs and Oil, Ethanol, and Soybean Oil
egranger lprin_bio13 lwti_n14 leth_n14 lsoy_n14 if sample_main==1, lags(1) trend	
	scalar pb13_eg1 = e(Zt)
egranger lprin_adv13 lwti_n14 leth_n14 lsoy_n14 if sample_main==1, lags(5) trend	
	scalar pb13_eg5 = e(Zt)
egranger lprin_adv13 lwti_n14 leth_n14 lsoy_n14 if sample_main==1, lags(10) trend	
	scalar pb13_eg10 = e(Zt)		

*Cointegration Test - Oil and the Russel 3000
egranger lwti_n14 lrus if sample_main==1, lags(1) trend	
	scalar oil_eg1 = e(Zt)
egranger lwti_n14 lrus if sample_main==1, lags(5) trend	
	scalar oil_eg5 = e(Zt)
egranger lwti_n14 lrus if sample_main==1, lags(10) trend	
	scalar oil_eg10 = e(Zt)	

*Cointegration Test - Ethanol, Russel 3000, & S&P 500-GS Index
egranger leth_n14 lrus lgs_index if sample_main==1, lags(1) trend	
	scalar eth_eg1 = e(Zt)
egranger leth_n14 lrus lgs_index if sample_main==1, lags(5) trend	
	scalar eth_eg5 = e(Zt)
egranger leth_n14 lrus lgs_index if sample_main==1, lags(10) trend	
	scalar eth_eg10 = e(Zt)		
	
*Cointegration Test - Soybean Oil, Russel 3000, & S&P 500-GS Index
egranger lsoy_n14 lrus lgs_index if sample_main==1, lags(1) trend	
	scalar soy_eg1 = e(Zt)
egranger lsoy_n14 lrus lgs_index if sample_main==1, lags(5) trend	
	scalar soy_eg5 = e(Zt)
egranger lsoy_n14 lrus lgs_index if sample_main==1, lags(10) trend	
	scalar soy_eg10 = e(Zt)	
	
*Cointegration Test - Corn, Russel 3000, & S&P 500-GS Index
egranger lcorn_n14 lrus lgs_index if sample_main==1, lags(1) trend	
	scalar corn_eg1 = e(Zt)
egranger lcorn_n14 lrus lgs_index if sample_main==1, lags(5) trend	
	scalar corn_eg5 = e(Zt)
egranger lcorn_n14 lrus lgs_index if sample_main==1, lags(10) trend	
	scalar corn_eg10 = e(Zt)	
	
*Cointegration Test - Sugar, Russel 3000, & S&P 500-GS Index
egranger lsug_n14 lrus lgs_index if sample_main==1, lags(1) trend	
	scalar sug_eg1 = e(Zt)
egranger lsug_n14 lrus lgs_index if sample_main==1, lags(5) trend	
	scalar sug_eg5 = e(Zt)
egranger lsug_n14 lrus lgs_index if sample_main==1, lags(10) trend	
	scalar sug_eg10 = e(Zt)	
	
*Creating matrix
matrix A = (scalar(pe13_eg1),scalar(pe13_eg5),scalar(pe13_eg10) \ ///
            scalar(pa13_eg1),scalar(pa13_eg5),scalar(pa13_eg10) \ ///
            scalar(pb13_eg1),scalar(pb13_eg5),scalar(pb13_eg10) \ ///
            scalar(oil_eg1),scalar(oil_eg5),scalar(oil_eg10) \ ///
            scalar(eth_eg1),scalar(eth_eg5),scalar(eth_eg10) \ ///
            scalar(soy_eg1),scalar(soy_eg5),scalar(soy_eg10) \ ///
            scalar(corn_eg1),scalar(corn_eg5),scalar(corn_eg10) \ ///
            scalar(sug_eg1),scalar(sug_eg5),scalar(sug_eg10))
			
*Labeling columns and rows
mat rownames A ="Conventional RINs: Oil, Ethanol, Soybean Oil"  ///
                "Advanced RINs: Oil, Ethanol, Soybean Oil"  ///
                "Biodiesel RINs: Oil, Ethanol, Soybean Oil"  ///
                "Oil Futures: Russell 3000 Index"  ///
                "Ethanol Futures: Russell 3000 Index, SP-GS Index"  ///
                "Soybean Oil Futures: Russell 3000 Index, SP-GS Index" ///
                "Corn Futures: Russell 3000 Index, SP-GS Index" ///
                "Sugar Futures: Russell 3000 Index, SP-GS Index"
				
mat colnames A = "1" "5" "10" 
		
*Exporting table
esttab matrix(A, fmt(2)) using $tables\cointegration_$outputdate.tex, replace  ///
    booktabs b(a2) title(Cointegration Tests \label{table:df}) mlabels()	
