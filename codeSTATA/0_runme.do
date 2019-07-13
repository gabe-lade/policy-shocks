**************************************************************
* RIN POLICY SHOCKS PROJECT
* CODE BY: GABRIEL LADE 
* 	LAST MAJOR UPDATE: 02/17/2019
**************************************************************
clear all
capture log close
set more off
set excelxlsxlargefile on

*SELECT OUTPUT DATE
global outputdate = "20190217"		 

*SELECT USER
global user 1  						 
global user1 ""

if $user == 1 cd $user1

*FOLDER DESIGNATIONS
global data "dataRAW"
global data_rin "dataRAW\dataRIN"
global data_gs "dataRAW\dataGS"
global data_stock "dataRAW\dataStocks"
global clean "dataSTATA"
global temp "dataSTATA\temp"
global tables "tablesSTATA"
global output "outSTATA"
global figs "figSTATA"
global code "codeSTATA"

*************************************
*DATA CLEAN 
*************************************
//do $code\1a_dataclean

*************************************
*IMPORTING CLEAN DATA
*************************************
use $clean\policy_shocks_ajae, clear
tsset t

*************************************
*SUMMARY STATS, GRAPHS, AND UNIT ROOT TESTS
*************************************
do $code\2a_sumstats

********************************
*RESULTS
********************************
do $code\2b_mainregs_rins
do $code\2c_mainregs_commodities
do $code\2d_mainregs_stocks

********************************
*ROBUSTNESS
********************************
do $code\3a_robust_rins

