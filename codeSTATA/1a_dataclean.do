**************************************************************
* POLICY SHOCKS AND RIN PRICES
* DATA CLEANING
* CODE BY: GABRIEL LADE  
**************************************************************
*****************************************
*Importing and Merging RIN Data
*****************************************
*****************
*RIN Data Update 1
* Note: - Only have D6 RINs in this file.
import excel "$data_rin\RIN_Hist1.xlsx", clear ///
       sheet("Ethanol RINS") firstrow case(lower) 
tab productname 
	   
rename price prin_eth
generate date=publicationdate
	format date %td
drop publicationdate 

*Dropping low and high prices 
drop if pricetype=="Low"
drop if pricetype=="High"	
drop pricetype
drop productname period 

foreach x in "07" "08" "09" "10" "11" "12" {
	replace vintage =`x' if vintage==20`x'
	
}
* 
*Reshaping wide by vintage
reshape wide prin_eth, i(date) j(vintage)

sort date
order date
save $temp\rins.dta, replace

*****************
*RIN Data Update 2
* Note: - Have D3, D4, D5, & D6 RINs
import excel "$data_rin\RIN_Hist2.xlsx", clear ///
       sheet("RIN History") firstrow case(lower) 
tab productname

*Renaming variables
rename price prin_ 
generate date=publicationdate
	format date %td
drop publicationdate 
destring vintage, replace

*Dropping low and high prices 
drop if pricetype=="Low"
drop if pricetype=="High"	
drop pricetype
drop  period 

*Reshaping by type wide
drop if productname=="Cellulosic RIN"
encode productname, gen(type)
drop productname
reshape wide prin_, i(date vintage) j(type) //Adv=1; Bio=2; Eth=4
	rename prin_1 prin_adv
	rename prin_2 prin_bio
	rename prin_3 prin_eth

*Reshaping wide by vintage
foreach x in "08" "09" "10" "11" "12" "13" "14" {
	replace vintage =`x' if vintage==20`x'
	
}
* 
reshape wide prin_eth prin_adv prin_bio, i(date) j(vintage)
 
*Sorting and ordering data	
sort date
append using $temp\rins.dta
sort date
duplicates drop
save $temp\rins.dta, replace

*****************
*RIN Data Update 3
* Note: - Have D3, D4, D5, & D6 RINs
import excel "$data_rin\RIN_Hist3.xlsx",  ///
       sheet("RIN History") firstrow case(lower) clear
tab productname

*Renaming variables
rename price prin_ 
generate date=publicationdate
	format date %td
drop publicationdate 
destring vintage, replace

*Dropping low and high prices 
drop if pricetype=="Low"
drop if pricetype=="High"	
drop pricetype
drop  period 

*Reshaping by type wide
drop if productname=="Cellulosic RIN"
encode productname, gen(type)
drop productname
reshape wide prin_, i(date vintage) j(type) //Adv=1; Bio=2; Eth=4
	rename prin_1 prin_adv
	rename prin_2 prin_bio
	rename prin_3 prin_eth

*Reshaping wide by vintage
foreach x in "10" "11" "12" "13" "14" {
	replace vintage =`x' if vintage==20`x'
	
}
* 
reshape wide prin_eth prin_adv prin_bio, i(date) j(vintage)
 
*Sorting and ordering data	
sort date
append using $temp\rins.dta
sort date
duplicates drop
save $temp\rins.dta, replace

*****************
*RIN Data Update 4
* Note: - Have D3, D4, D5, & D6 RINs
import excel "$data_rin\RIN_Hist4.xlsx",  ///
       sheet("Sheet1") firstrow case(lower) clear
tab productname

*Renaming variables
rename price prin_ 
generate date=publicationdate
	format date %td
drop publicationdate 
destring vintage, replace

*Dropping low and high prices 
drop if pricetype=="Low"
drop if pricetype=="High"	
drop pricetype

*Reshaping by type wide
drop if productname=="Cellulosic RIN"
encode productname, gen(type)
drop productname
reshape wide prin_, i(date vintage) j(type) //Adv=1; Bio=2; Eth=4
	rename prin_1 prin_adv
	rename prin_2 prin_bio
	rename prin_3 prin_eth

*Reshaping wide by vintage
foreach x in "12" "13" "14" "15" {
	replace vintage =`x' if vintage==20`x'
	
}
* 
reshape wide prin_eth prin_adv prin_bio, i(date) j(vintage)
 
*Sorting and ordering data	
sort date
append using $temp\rins.dta
sort date
duplicates drop
save $temp\rins.dta, replace

*****************
*RIN Data Update 5
* Note: - Have D3, D4, D5, & D6 RINs
import excel "$data_rin\RIN_Hist5.xlsx",  ///
       sheet("RIN History") firstrow case(lower) clear
tab productname

*Renaming variables
rename price prin_ 
generate date=publicationdate
	format date %td
drop publicationdate 
destring vintage, replace

*Dropping low and high prices 
drop if pricetype=="Low"
drop if pricetype=="High"	
drop pricetype period

*Reshaping by type wide
drop if productname=="Cellulosic RIN"
encode productname, gen(type)
drop productname
reshape wide prin_, i(date vintage) j(type) //Adv=1; Bio=2; Eth=4
	rename prin_1 prin_adv
	rename prin_2 prin_bio
	rename prin_3 prin_eth

*Reshaping wide by vintage
foreach x in "12" "13" "14" "15" {
	replace vintage =`x' if vintage==20`x'
	
}
* 
reshape wide prin_eth prin_adv prin_bio, i(date) j(vintage)
 
*Sorting and ordering data	
sort date
append using $temp\rins.dta
sort date
duplicates drop
save $temp\rins.dta, replace

*****************
*RIN Data Update 6
* Note: - Have D3, D4, D5, & D6 RINs
import excel "$data_rin\RIN_Hist6.xlsx",  ///
       sheet("RIN History") firstrow case(lower) clear
tab productname

*Renaming variables
rename price prin_ 
generate date=publicationdate
	format date %td
drop publicationdate 
destring vintage, replace

*Dropping low and high prices 
drop if pricetype=="Low"
drop if pricetype=="High"	
drop pricetype period

*Reshaping by type wide
drop if productname=="Cellulosic RIN"
encode productname, gen(type)
drop productname
reshape wide prin_, i(date vintage) j(type) //Adv=1; Bio=2; Eth=4
	rename prin_1 prin_adv
	rename prin_2 prin_bio
	rename prin_3 prin_eth

*Reshaping wide by vintage
foreach x in "12" "13" "14" "15" {
	replace vintage =`x' if vintage==20`x'
	
}
* 
reshape wide prin_eth prin_adv prin_bio, i(date) j(vintage)
 
*Sorting and ordering data	
sort date
append using $temp\rins.dta

*Some prices reported twice between data updates - take mean to be safe
collapse (mean) prin*, by(date)
sort date

save $temp\rins.dta, replace


*********************************************
*FUTURES DATA
* Notes: - For main analysis use July 2014 ethanol, soybean oil and WTI prices. 
*        - Also pull in continuous contracts of each for robustness. 
*********************************************

*****************
*CME Soybean oil Futures Prices
* - Source: https://www.quandl.com/collections/futures/cme-soybean-oil-futures

*December 2013 Soybean Oil Futures
quandl, quandlcode(CME/BOZ2013) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle soy_z13
label var soy_z13 "CME Soybean Oil Futures Dec 2013"
save $temp\commodities, replace

*March 2014 Soybean Oil Futures
quandl, quandlcode(CME/BOH2014) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle soy_h14
label var soy_h14 "CME Soybean Oil Futures March 2014"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*May 2014 Soybean Oil Futures
quandl, quandlcode(CME/BOK2014) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle soy_k14
label var soy_k14 "CME Soybean Oil Futures May 2014"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*July 2014 Soybean Oil Futures
quandl, quandlcode(CME/BON2014) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle soy_n14
label var soy_n14 "CME Soybean Oil Futures Jul 2014"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*Sept 2014 Soybean Oil Futures
quandl, quandlcode(CME/BOU2014) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle soy_u14
label var soy_u14 "CME Soybean Oil Futures Sept 2014"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*Dec 2014 Soybean Oil Futures
quandl, quandlcode(CME/BOZ2014) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle soy_z14
label var soy_z14 "CME Soybean Oil Futures Dec 2014"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*March 2015 Soybean Oil Futures
quandl, quandlcode(CME/BOH2015) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle soy_h15
label var soy_h15 "CME Soybean Oil Futures Dec 2015"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*May 2015 Soybean Oil Futures
quandl, quandlcode(CME/BOK2015) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle soy_k15
label var soy_k15 "CME Soybean Oil Futures May 2015"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*July 2015 Soybean Oil Futures
quandl, quandlcode(CME/BON2015) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle soy_n15
label var soy_n15 "CME Soybean Oil Futures July 2015"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*Sep 2015 Soybean Oil Futures
quandl, quandlcode(CME/BOU2015) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle soy_u15
label var soy_u15 "CME Soybean Oil Futures September 2015"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*December 2015 Soybean Oil Futures
quandl, quandlcode(CME/BOZ2015) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle soy_z15
label var soy_z15 "CME Soybean Oil Futures December 2015"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*July 2016 Soybean Oil Futures
quandl, quandlcode(CME/BON2016) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle soy_n16
label var soy_n16 "CME Soybean Oil Futures July 2016"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*CME Continuous Soybean Oil Futures
* - Source: https://www.quandl.com/data/CHRIS/CME_BO1-Soybean-Oil-Futures-Continuous-Contract-1-BO1-Front-Month
quandl, quandlcode(CHRIS/CME_BO1) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle soy_cont 
label var soy_cont "CME Soybean Oil Futures (Continuous)"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*****************
*CME Ethanol Futures Prices
* - Source: https://www.quandl.com/collections/futures/cme-ethanol-futures

*December 2013 Ethanol Futures
quandl, quandlcode(CME/EHZ2013) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle eth_z13
label var eth_z13 "CME Ethanol Futures Dec 2013"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*March 2014 Ethanol Futures
quandl, quandlcode(CME/EHH2014) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle eth_h14
label var eth_h14 "CME Ethanol Futures March 2014"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*May 2014 Ethanol Futures
quandl, quandlcode(CME/EHK2014) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle eth_k14
label var eth_k14 "CME Ethanol Futures May 2014"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*July 2014 Ethanol Futures
quandl, quandlcode(CME/EHN2014) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle eth_n14
label var eth_n14 "CME Ethanol Futures Jul 2014"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*Sept 2014 Ethanol Futures
quandl, quandlcode(CME/EHU2014) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle eth_u14
label var eth_u14 "CME Ethanol Futures Sept 2014"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*Dec 2014 Ethanol Futures
quandl, quandlcode(CME/EHZ2014) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle eth_z14
label var eth_z14 "CME Ethanol Futures Dec 2014"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*March 2015 Ethanol Futures
quandl, quandlcode(CME/EHH2015) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle eth_h15
label var eth_h15 "CME Ethanol Futures Dec 2015"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*May 2015 Ethanol Futures
quandl, quandlcode(CME/EHK2015) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle eth_k15
label var eth_k15 "CME Ethanol Futures May 2015"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*July 2015 Ethanol Futures
quandl, quandlcode(CME/EHN2015) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle eth_n15
label var eth_n15 "CME Ethanol Futures July 2015"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*Sep 2015 Ethanol Futures
quandl, quandlcode(CME/EHU2015) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle eth_u15
label var eth_u15 "CME Ethanol Futures September 2015"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*December 2015 Ethanol Futures
quandl, quandlcode(CME/EHZ2015) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle eth_z15
label var eth_z15 "CME Ethanol Futures December 2015"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*July 2016 Ethanol Futures
quandl, quandlcode(CME/EHN2016) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle eth_n16
label var eth_n16 "CME Ethanol Futures July 2016"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*CME Continuous Ethanol Futures
* - Source: https://www.quandl.com/data/CHRIS/CME_BO1-Soybean-Oil-Futures-Continuous-Contract-1-BO1-Front-Month
quandl, quandlcode(CHRIS/CME_EH1) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle eth_cont 
label var eth_cont "CME Ethanol Futures (Continuous)"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace 
 
*****************
*CME WTI Crude Oil Futures Prices
* - Source: https://www.quandl.com/collections/futures/cme-wti-crude-oil-futures

*December 2013 WTI Futures
quandl, quandlcode(CME/CLZ2013) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle wti_z13
label var wti_z13 "CME WTI Futures Dec 2013"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*March 2014 WTI Futures
quandl, quandlcode(CME/CLH2014) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle wti_h14
label var wti_h14 "CME WTI Futures March 2014"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*May 2014 WTI Futures
quandl, quandlcode(CME/CLK2014) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle wti_k14
label var wti_k14 "CME WTI Futures May 2014"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*July 2014 WTI Futures
quandl, quandlcode(CME/CLN2014) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle wti_n14
label var wti_n14 "CME WTI Futures Jul 2014"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*Sept 2014 WTI Futures
quandl, quandlcode(CME/CLU2014) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle wti_u14
label var wti_u14 "CME WTI Futures Sept 2014"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*Dec 2014 WTI Futures
quandl, quandlcode(CME/CLZ2014) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle wti_z14
label var wti_z14 "CME WTI Futures Dec 2014"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*March 2015 WTI Futures
quandl, quandlcode(CME/CLH2015) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle wti_h15
label var wti_h15 "CME WTI Futures Dec 2015"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*May 2015 WTI Futures
quandl, quandlcode(CME/CLK2015) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle wti_k15
label var wti_k15 "CME WTI Futures May 2015"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*July 2015 WTI Futures
quandl, quandlcode(CME/CLN2015) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle wti_n15
label var wti_n15 "CME WTI Futures July 2015"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*Sep 2015 WTI Futures
quandl, quandlcode(CME/CLU2015) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle wti_u15
label var wti_u15 "CME WTI Futures September 2015"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*December 2015 WTI Futures
quandl, quandlcode(CME/CLZ2015) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle wti_z15
label var wti_z15 "CME WTI Futures December 2015"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*July 2016 WTI Futures
quandl, quandlcode(CME/CLN2016) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle wti_n16
label var wti_n16 "CME WTI Futures July 2016"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*CME Continuous WTI Futures
* - Source: https://www.quandl.com/data/CHRIS/CME_BO1-Soybean-Oil-Futures-Continuous-Contract-1-BO1-Front-Month
quandl, quandlcode(CHRIS/CME_CL1) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle wti_cont 
label var wti_cont "CME WTI Futures (Continuous)"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace 

*****************
*CME Corn Futures Prices
* - Source: https://www.quandl.com/collections/futures/cme-corn-futures

*December 2013 Corn Futures
quandl, quandlcode(CME/CZ2013) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle corn_z13
label var corn_z13 "CME Corn Futures Dec 2013"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*March 2014 Corn Futures
quandl, quandlcode(CME/CH2014) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle corn_h14
label var corn_h14 "CME Corn Futures March 2014"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*May 2014 Corn Futures
quandl, quandlcode(CME/CK2014) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle corn_k14
label var corn_k14 "CME Corn Futures May 2014"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*July 2014 Corn Futures
quandl, quandlcode(CME/CN2014) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle corn_n14
label var corn_n14 "CME Corn Futures Jul 2014"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*Sept 2014 Corn Futures
quandl, quandlcode(CME/CU2014) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle corn_u14
label var corn_u14 "CME Corn Futures Sept 2014"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*Dec 2014 Corn Futures
quandl, quandlcode(CME/CZ2014) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle corn_z14
label var corn_z14 "CME Corn Futures Dec 2014"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*March 2015 Corn Futures
quandl, quandlcode(CME/CH2015) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle corn_h15
label var corn_h15 "CME Corn Futures Dec 2015"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*May 2015 Corn Futures
quandl, quandlcode(CME/CK2015) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle corn_k15
label var corn_k15 "CME Corn Futures May 2015"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*July 2015 Corn Futures
quandl, quandlcode(CME/CN2015) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle corn_n15
label var corn_n15 "CME Corn Futures July 2015"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*Sep 2015 Corn Futures
quandl, quandlcode(CME/CU2015) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle corn_u15
label var corn_u15 "CME Corn Futures September 2015"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*December 2015 Corn Futures
quandl, quandlcode(CME/CZ2015) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle corn_z15
label var corn_z15 "CME Corn Futures December 2015"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*CME Continuous Corn Futures
* - Source: https://www.quandl.com/data/CHRIS/CME_C1-Corn-Futures-Continuous-Contract-1-C1-Front-Month
quandl, quandlcode(CHRIS/CME_C1) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle corn_cont 
label var corn_cont "CME Corn Futures (Continuous)"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace 

*****************
*ICE No. 11 Sugar Futures Prices
* - Source: https://www.quandl.com/collections/futures/ice-sugar-no-11-futures

*March 2014 No. 11 Sugar Futures
quandl, quandlcode(ICE/SBH2014) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle sug_h14
label var sug_h14 "ICE No. 11 Sugar Futures March 2014"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*May 2014 No. 11 Sugar Futures
quandl, quandlcode(ICE/SBK2014) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle sug_k14
label var sug_k14 "ICE No. 11 Sugar Futures May 2014"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*July 2014 ICE No. 11 Sugar Futures
quandl, quandlcode(ICE/SBN2014) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle sug_n14
label var sug_n14 "ICE No. 11 Sugar Futures Jul 2014"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*October 2014 ICE No. 11 Sugar Futures
quandl, quandlcode(ICE/SBV2014) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle sug_u14
label var sug_u14 "ICE No. 11 Sugar Futures Oct 2014"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*March 2015 ICE No. 11 Sugar Futures
quandl, quandlcode(ICE/SBH2015) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle sug_h15
label var sug_h15 "ICE No. 11 Sugar Futures Dec 2015"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*May 2015 ICE No. 11 Sugar Futures
quandl, quandlcode(ICE/SBK2015) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle sug_k15
label var sug_k15 "ICE No. 11 Sugar Futures May 2015"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*July 2015 ICE No. 11 Sugar Futures
quandl, quandlcode(ICE/SBN2015) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle sug_n15
label var sug_n15 "ICE No. 11 Sugar Futures July 2015"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace

*Oct 2015 No. 11 Sugar Futures
quandl, quandlcode(ICE/SBV2015) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle sug_u15
label var sug_u15 "ICE No. 11 Sugar Futures October 2015"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace
 
*ICE Continuous No. 11 Sugar Futures
* - Source: https://www.quandl.com/data/CHRIS/ICE_SB1-Sugar-No-11-Futures-Continuous-Contract-1-SB1-Front-Month
quandl, quandlcode(CHRIS/ICE_SB1) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle sug_cont 
label var sug_cont "ICE No. 11 Sugar Futures (Continuous)"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace 
 
*****************
*RBOB Futures
* - Source: https://www.quandl.com/collections/futures/cme-gasoline-futures

*July 2014 CME NYMEX Gasoline Futures
quandl, quandlcode(CME/RBN2014) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle rbob_n14
label var rbob_n14 "CME RBOB Futures July 2014"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace 
 
*CME Continuous RBOB Futures
* - Source: https://www.quandl.com/data/CHRIS/CME_RB1-RBOB-Gasoline-Physical-Futures-Continuous-Contract-1-RB1-Front-Month
quandl, quandlcode(CHRIS/CME_RB1) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle rbob_cont 
label var rbob_cont "CME RBOB Futures (Continuous)"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace 
 
*****************
*ULSD Futures
* - Source: https://www.quandl.com/collections/futures/cme-heating-oil-futures

*July 2014 CME Heating Oil Futures
quandl, quandlcode(CME/HON2014) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle ulsd_n14
label var ulsd_n14 "CME ULSD Futures July 2014"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace 
 
*CME Continuous Heating Oil Futures
* - Source: https://www.quandl.com/data/CHRIS/CME_HO1-NY-Harbor-ULSD-Futures-Continuous-Contract-1-HO1-Front-Month
quandl, quandlcode(CHRIS/CME_RB1) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle ulsd_cont 
label var ulsd_cont "CME ULSD Futures (Continuous)"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace 
 
*****************
*Natural Gas Futures
* - Source: https://www.quandl.com/collections/futures/cme-natural-gas-henry-hub-penultimate-financial-futures

*July 2014 CME NYMEX Natural Gas Futures
quandl, quandlcode(CME/NGN2014) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle ng_n14
label var ng_n14 "CME Nat Gas Futures July 2014"

merge 1:1 date using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace 
 
*CME Continuous Natural Gas Futures
* - Source: https://www.quandl.com/data/CHRIS/CME_NG1-Natural-Gas-Henry-Hub-Physical-Futures-Continuous-Contract-1-NG1-Front-Month
quandl, quandlcode(CHRIS/CME_NG1) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
gen year=year(date)
keep if year>2011
keep date settle
rename settle ng_cont 
label var ng_cont "CME Nat Gas Futures (Continuous)"

merge 1:1 date using $temp\commodities
drop _merge
sort date
gen year=year(date)
gen month=month(date)
gen week=week(date)
save $temp\commodities, replace 

*****************
*Coal Prices - EIA Central Appalachia Coal Price ($/short ton)
* - Source: https://www.quandl.com/data/EIA/COAL-US-Coal-Prices-by-Region
* - Note: Only have weekly data
quandl, quandlcode(EIA/COAL) authtoken(yUBxDHgtF5SQYDmmELRQ) clear

gen year=substr(weekended,1,4)
	destring year, replace
gen month=substr(weekended,6,2)
	destring month, replace
gen day=substr(weekended,9,2)
	destring day, replace
gen date=mdy(month,day,year)	
	format date %td
gen week=week(date)	
	
keep if year>2011
keep year month week centralappalachia12500btu12so2
rename centralappalachia12500btu12so2 coal_price
label var coal_price "EIA Central Appalachia Coal Price"

collapse (mean) coal_price, by(year month week)
 
merge 1:m year month week using $temp\commodities
drop _merge
sort date
save $temp\commodities, replace 


*********************************************
*MACROECONOMIC INDICATORS
*********************************************
*FRED 3 Month Tbill
quandl, quandlcode(FRED/DTB3) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
rename value tbill3m
keep tbill3m date
label var tbill3m "3 Month US Treasury Bill"
save $temp\macro, replace 

*FRED 10 Year Tbill
quandl, quandlcode(FRED/DGS10) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
rename value tbill10y
keep date tbill10y
label var tbill10y "10 Year US Treasury Bill"

merge 1:1 date using $temp\macro
drop _merge
sort date
save $temp\macro, replace 

*DJIA
quandl, quandlcode(YAHOO/INDEX_DJI) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
keep date close
rename close djia
label var djia "Dow Jones Industrial Average"

merge 1:1 date using $temp\macro
drop _merge
sort date
save $temp\macro, replace 
 	
*S&P 500
quandl, quandlcode(YAHOO/INDEX_GSPC) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
rename close sp500
keep sp500 date
label var sp500 "S&P 500 Index"

merge 1:1 date using $temp\macro
drop _merge
sort date
save $temp\macro, replace 

*Russel 3000 Index
quandl, quandlcode(YAHOO/INDEX_RUA) authtoken(yUBxDHgtF5SQYDmmELRQ) clear
rename close rus
keep rus date
label var rus "Russell 3000 Index"

merge 1:1 date using $temp\macro
drop _merge
sort date
save $temp\macro, replace 

* Goldman Sachs Commodity Index Index
use $data_gs/quandl_historical_gsindex.dta
rename index1 gs_index
label var gs_index "Goldman Sachs Comodity Index"

merge 1:1 date using $temp\macro
drop _merge
sort date
save $temp\macro, replace 


*********************************************
*BIOFUEL COMPANIES
*********************************************
*ADM
import delimited $data_stock\ADM.csv, clear
rename close stock_adm
gen date1=date(date,"MDY")	
	format date1 %td
keep date1 stock_adm
rename date1 date
label var stock_adm "ADM Stock Price"
save $temp\stock, replace 

*ANDE
import delimited $data_stock\ANDE.csv, clear varnames(1)
rename close stock_ande
gen date1=date(date,"MDY")	
	format date1 %td
keep date1 stock_ande
rename date1 date
destring stock_ande, replace force
label var stock_ande "ANDE Stock Price"
merge 1:1 date using $temp\stock
drop _merge
sort date
save $temp\stock, replace 

*CZZ
import delimited $data_stock\CZZ.csv, clear
rename close stock_czz
gen date1=date(date,"MDY")	
	format date1 %td
keep date1 stock_czz
rename date1 date
label var stock_czz "CZZ Stock Price"
merge 1:1 date using $temp\stock
drop _merge
sort date
save $temp\stock, replace 

*FF
import delimited $data_stock\FF.csv, clear
rename close stock_ff
gen date1=date(date,"MDY")	
	format date1 %td
keep date1 stock_ff
rename date1 date
label var stock_ff "FF Stock Price"
merge 1:1 date using $temp\stock
drop _merge
sort date
save $temp\stock, replace 

*GEVO
import delimited $data_stock\GEVO.csv, clear
rename close stock_gevo
gen date1=date(date,"MDY")	
	format date1 %td
keep date1 stock_gevo
rename date1 date
label var stock_gevo "GEVO Stock Price"
merge 1:1 date using $temp\stock
drop _merge
sort date
save $temp\stock, replace 

*GPRE
import delimited $data_stock\GPRE.csv, clear
rename close stock_gpre
gen date1=date(date,"MDY")	
	format date1 %td
keep date1 stock_gpre
rename date1 date
label var stock_gpre "GPRE Stock Price"
merge 1:1 date using $temp\stock
drop _merge
sort date
save $temp\stock, replace 

*KIOR
import delimited $data_stock\KIOR.csv, clear
rename close stock_kior
gen date1=date(date,"MDY")	
	format date1 %td
keep date1 stock_kior
rename date1 date
label var stock_kior "KIOR Stock Price"
merge 1:1 date using $temp\stock
drop _merge
sort date
save $temp\stock, replace

*MEIL
import delimited $data_stock\MEIL.csv, clear varnames(1)
rename close stock_meil
gen date1=date(date,"MDY")	
	format date1 %td
keep date1 stock_meil
rename date1 date
label var stock_meil "MEIL Stock Price"
destring stock_meil, replace force
merge 1:1 date using $temp\stock
drop _merge
sort date
save $temp\stock, replace

*NTOIY
import delimited $data_stock\NTOIY.csv, clear varnames(1)
rename close stock_ntoiy
gen date1=date(date,"MDY")	
	format date1 %td
keep date1 stock_ntoiy
rename date1 date
label var stock_ntoiy "NTOIY Stock Price"
destring stock_ntoiy, replace force
merge 1:1 date using $temp\stock
drop _merge
sort date
save $temp\stock, replace  
 
*PEIX
import delimited $data_stock\PEIX.csv, clear
rename close stock_peix
gen date1=date(date,"MDY")	
	format date1 %td
keep date1 stock_peix
rename date1 date
label var stock_peix "PEIX Stock Price"
merge 1:1 date using $temp\stock
drop _merge
sort date
save $temp\stock, replace  

*REGI
import delimited $data_stock\REGI.csv, clear
rename close stock_regi
gen date1=date(date,"MDY")	
	format date1 %td
keep date1 stock_regi
rename date1 date
label var stock_regi "REGI Stock Price"
merge 1:1 date using $temp\stock
drop _merge
sort date
save $temp\stock, replace   

*SZYM
import delimited $data_stock\SZYM.csv, clear
rename close stock_szym
gen date1=date(date,"MDY")	
	format date1 %td
keep date1 stock_szym
rename date1 date
label var stock_szym "SZYM Stock Price"
merge 1:1 date using $temp\stock
drop _merge
sort date
save $temp\stock, replace  

*VLO
import delimited $data_stock\VLO.csv, clear
rename close stock_vlo
gen date1=date(date,"MDY")	
	format date1 %td
keep date1 stock_vlo
rename date1 date
label var stock_vlo "VLO Stock Price"
merge 1:1 date using $temp\stock
drop _merge
sort date
order date
save $temp\stock, replace  
       
*********************************************
*MERGING AND CLEANING DATA
*********************************************
use $temp\rins.dta, clear

*Merging in commodities data
merge 1:1 date using $temp\commodities
drop _merge

*Merging in macro indicators
merge 1:1 date using $temp\macro
drop _merge

*Merging in stock prices 
merge 1:1 date using $temp\stock
drop _merge

*Dropping early period data
* Keeping data only after 4/1/2008 (when we observe earliest RIN prices)
sort date
drop if date<17623

*Creating average RIN price series
egen prin_eth_cont=rowmean(prin_eth7 prin_eth8 prin_eth9 prin_eth10 prin_eth11 ///
						   prin_eth12 prin_eth13 prin_eth14 prin_eth15 prin_eth2016)
label var prin_eth_cont "Average Ethanol (D6) RIN Prices"
		
egen prin_adv_cont=rowmean(prin_adv8 prin_adv9 prin_adv10 prin_adv11 prin_adv12 ///
					  prin_adv13 prin_adv14 prin_adv15)
label var prin_adv_cont "Average Advanced (D5) RIN Prices"

egen prin_bio_cont=rowmean(prin_bio8 prin_bio9 prin_bio10 prin_bio11 ///
					  prin_bio12 prin_bio13 prin_bio14 prin_bio15   )
label var prin_bio_cont "Average Biodiesel (D4) RIN Prices"
				   
*Dropping if RIN prices are not reported
* Notes: - Some commodity prices are reported on holidays or weekends when
*           no RIN prices are reported. 
*        - Implicitly treats e.g. Friday to Monday price changes as a single day. 
drop if prin_eth_cont==.

*Replacing commodity market data with previous prices if missing
* Note: - Some days where RIN prices are reported but commodity prices are not. 
*       - We assume that the commodity price was the same as the previous day. 
*       - Innocuous given that data are daily.
foreach y in ng_cont ng_n14 rbob_cont rbob_n14 sug_cont sug_u15 sug_n15 ///
			 sug_k15 sug_h15 sug_u14 sug_n14 sug_k14 sug_h14 corn_cont ///
			 corn_z15 corn_u15 corn_n15 corn_k15 corn_h15 corn_z14 corn_u14 ///
			 corn_n14 corn_k14 corn_h14 corn_z13 wti_cont wti_z15 wti_u15 ///
			 wti_n15 wti_k15 wti_h15 wti_z14 wti_u14 wti_n14 wti_k14 ///
			 wti_h14 wti_z13 eth_cont eth_z15 eth_u15 eth_n15 eth_k15 ///
			 eth_h15 eth_z14 eth_u14 eth_n14 eth_k14 eth_h14 eth_z13 ///
			 soy_cont soy_z15 soy_u15 soy_n15 soy_k15 soy_h15 soy_z14 ///
			 soy_u14 soy_n14 soy_k14 soy_h14 soy_z13 rus sp500 djia ///
			 tbill10y tbill3m ulsd_cont ulsd_n14 gs_index stock_vlo ///
			 stock_szym stock_regi stock_peix stock_ntoiy stock_meil ///
			 stock_kior stock_gpre stock_gevo stock_ff stock_czz ///
			 stock_ande stock_adm wti_n16 eth_n16 soy_n16 coal_price {
	replace `y' = `y'[_n-1] if missing(`y') & `y'[_n+2]!=.
}
* 
replace eth_cont = eth_cont[_n-1] if missing(eth_cont) & eth_cont[_n-2]!=.

**********************
*FLEXIBLE TIME POLYNOMIALS & DOW & MONTH INDICATORS
**********************
gen t=_n
foreach x of numlist  2(1)6 {
	gen t`x'=t^`x'
	}
gen day=dow(date)

******************
*POLICY ANNOUNCEMENT INDICATORS
* Notes: - Creating indicators for day of and five days post each event. 
*        - 2013 PR released on 1/31/2013 (date=19389, t=1215)
*        - 2013 FR released on 8/6/2016 (date=19576, t=1344)
*        - Reuters Article released on 10/11/2013 (date=19642, t=1391)
*        - 2014 PR released on 11/15/2013 (date=19677, t=1416)
*		2014-2016 PROPOSED RULE - 5/29/2015 (t=1798)
*		2014-2016 FINAL RULE - 11/30/2015 (t=1925)
* 		2017 PROPOSED RULE -  5/18/2016 (t=2042)
* 		2017 PROPOSED RULE -  11/23/2016 (OUT OF SAMPLE)
******************
*2013 proposed rule 
foreach x of numlist 1215(1)1225 {
	local j=`x'-1215
	gen pr13_`j'=0
	replace pr13_`j'=1 if t==`x'
}
*
*2013 final rule 
foreach x of numlist 1344(1)1354 {
	local j=`x'-1344
	gen fr13_`j'=0
	replace fr13_`j'=1 if t==`x'
}
*	
* 2014 Leaked Rule
foreach x of numlist  1391(1)1401 {
	local j=`x'-1391
	gen leak14_`j'=0
	replace leak14_`j'=1 if t==`x'
}
*
* 2014 Proposed Rule
foreach x of numlist  1416(1)1426 {
	local j=`x'-1416
	gen pr14_`j'=0
	replace pr14_`j'=1 if t==`x'
}
*
*2014-2016 Proposed Rule
foreach x of numlist  1798(1)1802 {
	local j=`x'-1798
	gen pr1416_`j'=0
	replace pr1416_`j'=1 if t==`x'
}
*
*2014-2016 Final Rule
foreach x of numlist  1925(1)1929 {
	local j=`x'-1925
	gen fr1416_`j'=0
	replace fr1416_`j'=1 if t==`x'
}
*
*2017 Proposed Rule
foreach x of numlist  2042(1)2046 {
	local j=`x'-2042
	gen pr17_`j'=0
	replace pr17_`j'=1 if t==`x'
}
*
*******************
*Converting commodity price data to cents 
*RIN prices 
foreach y in prin_adv14 prin_bio14 prin_eth14 prin_adv15 prin_bio15 ///
	         prin_eth15 prin_adv2016 prin_bio2016 prin_eth2016 prin_adv13 ///
			 prin_bio13 prin_eth13 prin_adv12 prin_bio12 prin_eth12 ///
			 prin_adv10 prin_bio10 prin_eth10 prin_adv11 prin_bio11 ///
			 prin_eth11 prin_adv8 prin_bio8 prin_eth8 prin_adv9 prin_bio9 ///
			 prin_eth9 prin_eth7 prin_eth_cont prin_adv_cont prin_bio_cont {
	replace `y'=`y'*100
}
*
*Oil prices    
foreach y in wti_cont wti_z15 wti_u15 wti_n15 wti_k15 wti_h15 wti_z14 ///
			 wti_u14 wti_n14 wti_k14 wti_h14 wti_z13 wti_n16 {
	replace `y'=`y'/42*100
}
*
*Ethanol prices
foreach y in eth_cont eth_z15 eth_u15 eth_n15 eth_k15  eth_h15 eth_z14 ///
			eth_u14 eth_n14 eth_k14 eth_h14 eth_z13 eth_n16 {
	replace `y'=`y'*100
}
*
*Soybean Oil prices
foreach y in soy_cont soy_z15 soy_u15 soy_n15 soy_k15 soy_h15 soy_z14 ///
			 soy_u14 soy_n14 soy_k14 soy_h14 soy_z13 soy_n16 {
	replace `y'=`y'*7.7
}
*	     
*Corn prices
foreach y in corn_cont corn_z15 corn_u15 corn_n15 corn_k15 corn_h15 corn_z14 ///
			  corn_u14 corn_n14 corn_k14 corn_h14 corn_z13 {
	replace `y'=`y'/2.77/0.75
}
*	
*Sugar prices
foreach y in sug_cont sug_u15 sug_n15 sug_k15 sug_h15 sug_u14 sug_n14 ///
			 sug_k14 sug_h14 {
	replace `y'=`y'*14
}
*	
*Gasoline, diesel, and natural gas prices
foreach y in ng_cont ng_n14 rbob_cont rbob_n14 ulsd_cont ulsd_n14 {
	replace `y'=`y'*100
}
*
*Stock prices
foreach y in stock_vlo stock_szym stock_regi stock_peix stock_ntoiy  ///
			 stock_meil stock_kior stock_gpre stock_gevo stock_ff stock_czz ///
			 stock_ande stock_adm {
	replace `y'=`y'*100
}
*			 

*******************
*Logging all price data
foreach y in ng_cont ng_n14 rbob_cont rbob_n14 sug_cont sug_u15 sug_n15 ///
			 sug_k15 sug_h15 sug_u14 sug_n14 sug_k14 sug_h14 corn_cont ///
			 corn_z15 corn_u15 corn_n15 corn_k15 corn_h15 corn_z14 corn_u14 ///
			 corn_n14 corn_k14 corn_h14 corn_z13 wti_cont wti_z15 wti_u15 ///
			 wti_n15 wti_k15 wti_h15 wti_z14 wti_u14 wti_n14 wti_k14 ///
			 wti_h14 wti_z13 eth_cont eth_z15 eth_u15 eth_n15 eth_k15 ///
			 eth_h15 eth_z14 eth_u14 eth_n14 eth_k14 eth_h14 eth_z13 ///
			 soy_cont soy_z15 soy_u15 soy_n15 soy_k15 soy_h15 soy_z14 ///
			 soy_u14 soy_n14 soy_k14 soy_h14 soy_z13 rus sp500 djia ///
			 tbill10y tbill3m ulsd_cont ulsd_n14 prin_adv14 prin_bio14 ///
	         prin_eth15 prin_adv2016 prin_bio2016 prin_eth2016 prin_adv13 /// 
			 prin_bio13 prin_eth13 prin_adv12 prin_bio12 prin_eth12 ///
			 prin_adv10 prin_bio10 prin_eth10 prin_adv11 prin_bio11 ///
			 prin_eth11 prin_adv8 prin_bio8 prin_eth8 prin_adv9 prin_bio9 ///
			 prin_eth9 prin_eth7 prin_eth_cont prin_adv_cont prin_bio_cont ///
			 prin_eth14 prin_adv15 prin_bio15 gs_index stock_vlo stock_szym ///
			 stock_regi stock_peix stock_ntoiy stock_meil stock_kior ///
			 stock_gpre stock_gevo stock_ff stock_czz stock_ande stock_adm ///
			 wti_n16 eth_n16 soy_n16 coal_price {
	gen l`y'=log(`y') 
}
*
*******************
*Generating indicator for samples
*Notes: - Main results (sample_main): 8/6/12-5/15/14 (19211-19858) 
*       - Alternative 1 (sample_alt1): 1/2/13-5/15/14 (19360-19858) 
*       - Alternative 2 (sample_alt2): 1/3/11-5/15/14 (18630-19858)
*       - Extension (sample_ext): 10/15/2014-6/30/2016 (20011-20635)
gen sample_main=0
	replace sample_main=1 if date>=19211 & date<=19858		 

gen sample_alt1=0
	replace sample_alt1=1 if date>=19360 & date<=19858
	
gen sample_alt2=0
	replace sample_alt2=1 if date>=18630 & date<=19858
	
gen sample_ext=0
	replace sample_ext=1 if date>=20011  
	
*Sorting and cleaning final data
sort date
order date t prin_eth13 prin_adv13 prin_bio13 wti_n14 eth_n14 soy_n14 ///
	  t2 t3 t4 t5 t6 day month pr13_0 pr13_1 pr13_2 pr13_3 pr13_4 pr13_5 ///
	  pr13_6 pr13_7 pr13_8 pr13_9 pr13_10 fr13_0 fr13_1 fr13_2 fr13_3 fr13_4 ///
	  fr13_5 fr13_6 fr13_7 fr13_8 fr13_9 fr13_10 leak14_0 leak14_1 leak14_2 ///
	  leak14_3 leak14_4 leak14_5 leak14_6 leak14_7 leak14_8 leak14_9 leak14_10 ///
	  pr14_0 pr14_1 pr14_2 pr14_3  pr14_4 pr14_5 pr14_6 pr14_7 pr14_8 ///
	  pr14_9 pr14_10 lprin_eth13 lprin_adv13 lprin_bio13 lwti_n14 leth_n14 ///
	  lsoy_n14 lgs_index lstock* 
	  
save $clean\policy_shocks_$outputdate, replace
