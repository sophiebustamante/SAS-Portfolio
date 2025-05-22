/*=========================*/
/*  Bios 500 Lab 8         */
/*  Chi square test        */
/*=========================*/

LIBNAME bios500 'S:\course\BIOS500\Binongo\2023_Lab\Datasets\';

PROC CONTENTS DATA=bios500.allergy;
RUN;

/* Chi-square test for proportions */		*uses independent samples;
/*---------------------------------*/
PROC FREQ DATA=bios500.allergy;
TABLES aller_seas * home_location / EXPECTED CHISQ norow;
RUN;

proc contents data=bios500.heart_disease varnum; run;

/* Chi-square test of association  */		*uses independent samples;
/*---------------------------------*/
PROC FREQ DATA=bios500.heart_disease;
TABLES fbs * heart_disease  / EXPECTED CHISQ;
RUN;

/* Measures of association (RELRISK option) */
/*------------------------------------------*/
PROC FREQ DATA=bios500.heart_disease;
TABLES fbs * heart_disease  / EXPECTED CHISQ RELRISK;
RUN;
*SAS computes the Relative Risk as (risk in row 1)/(risk in row 2)
it does not know if column 1 is disease or column 2 is disease;


/* Sorting data in descending order */
/*----------------------------------*/
data work.heart_disease;
set bios500.heart_disease;
run;

proc sort data=heart_disease;
  by descending fbs descending heart_disease ;
run;

* or use out= in proc sort;

* Measures of association (RELRISK option) ;
PROC FREQ DATA=heart_disease order=data;
TABLES fbs * heart_disease / CHISQ RELRISK;
RUN;

 
/* Note: Cell (1,1) =
number of patients WITH heart disease WITH increased fsb */


/*------------------*/
/*  McNemar's test  */		*like paired t test. for dependent categorical data.dichotomous outcome 
								measured twice in same people;
/*------------------*/
DATA work.test;
  INPUT Q1 Q2 count;
  DATALINES;
  1  1  72
  0  1   6
  1  0   7
  0  0  15
  ; 
RUN;

PROC FREQ DATA=work.test;
	WEIGHT count;
  	TABLES Q1 * Q2 / NOROW NOCOL;
  	EXACT MCNEM;
RUN;


/*  WITH USING FORMATS */
/*---------------------*/
PROC FORMAT;
VALUE yesnof 0="No" 1="Yes";
RUN;

*Chi-square test for proportions;
PROC FREQ DATA=bios500.allergy;
FORMAT aller_seas yesnof. ;
TABLES aller_seas*home_location / EXPECTED CHISQ;
RUN;

*Chi-square test of association;
PROC FREQ DATA=bios500.heart_disease;
FORMAT fbs heart_disease yesnof. ;
TABLES fbs * heart_disease  / EXPECTED CHISQ;
RUN;

*Measures of association (RELRISK option);
PROC FREQ DATA=bios500.heart_disease;
FORMAT fbs heart_disease yesnof. ;
TABLES fbs * heart_disease  / EXPECTED CHISQ RELRISK;
RUN;


/*--------------------------------*/
/*  USING SUMMARIZED FREQUENCIES  */
/*--------------------------------*/

* Manually input frequencies in a new dataset;
DATA work.allergy_counts;
INPUT allergy $ location $ cellcount;
DATALINES;
No Rural 462
No City 1076
Yes Rural 135
Yes City 251
;
RUN;

* Run Chi-Square test;
PROC FREQ DATA=work.allergy_counts;
WEIGHT cellcount;
TABLES allergy*location / nopercent norow chisq expected;
RUN;


/*-------------------------------------*/
/* CHI-SQUARE TEST FOR GOODNESS OF FIT */
/*-------------------------------------*/

* Manually input observed M&M frequencies;
DATA work.mm;
INPUT color$ count;
DATALINES;
green 402
red 267
blue 394
brown 252
yellow 298
orange 429
;
RUN;

* Chi-square goodness of fit test;
PROC FREQ DATA=work.mm;
WEIGHT count;
TABLES color / NOCUM TESTP=(24 14 16 20 13 13); 
RUN;

* Using alternative ordering;
PROC FREQ DATA=work.mm order=data;
WEIGHT count;
TABLES color / NOCUM TESTP=(16 13 24 14 13 20); 
RUN;


/*=========================*/
/*  Bios 500 Lab 8         */
/*  Practice Exercise      */
/*=========================*/

/** Problem 1 **/
* enter soda data;
DATA soda;
INPUT gender$ drink$ count;
DATALINES;
F No 52
F Yes 37
M No 9
M Yes 7
;
RUN;

*Chi-square test;
PROC FREQ DATA=soda;
WEIGHT count;
TABLES gender*drink / nopercent nocol chisq expected relrisk;
RUN;

/** Problem 2 **/
LIBNAME bios500 'S:\course\BIOS500\Binongo\2023_Lab\Datasets\';

proc contents data=bios500.personality;
run;

*Chi-square test;
proc freq data=bios500.personality;
tables personality_type*CHD / nopercent nocol chisq expected relrisk;
run;


*HW
2;
proc contents data=bios500.exposure;
run;
proc freq data=bios500.exposure;
tables sex*smoke;
run;	*men:224/1090=.2055	women:164/833=0.19687;
PROC FREQ DATA=bios500.exposure;
TABLES sex * smoke  / EXPECTED CHISQ;
RUN;
PROC FREQ DATA=bios500.exposure;
TABLES sex * smoke  / relrisk;
RUN;

data q2;
q2=1-cdf("chisq", 0.2089, 1);
proc print;
run;		*p-value=0.64763>0,05-->fail to reject null ;

data qlecture;
qlecture=1-cdf("chisq", 25.01, 1);
proc print;
run;

*6;
proc freq data=bios500.exposure;
tables marital_status*smoke;
run;
*7;
PROC FREQ DATA=bios500.exposure;
TABLES marital_status * smoke  / EXPECTED CHISQ RELRISK;
RUN;	


data work.heart_disease;
set bios500.heart_disease;
run;

proc sort data=heart_disease;
  by descending fbs descending heart_disease ;
run;

* or use out= in proc sort;

* Measures of association (RELRISK option) ;
PROC FREQ DATA=heart_disease order=data;
TABLES fbs * heart_disease / CHISQ RELRISK;
RUN;
