/*=========================*/
/*  Bios 500 Lab 7         */
/*  t-tests                */
/*=========================*/

/* Step 1: create a library that will tell SAS where the dataset is located */
libname lab7 'S:\course\BIOS500\Binongo\2023_Lab\Datasets';

PROC CONTENTS DATA=lab7.fev_data;
RUN;
proc print data=lab7.fev_data (obs=20);
run;


/* Step 2: get the descriptive statistics for the variables of interest */
PROC MEANS DATA=lab7.fev_data maxdec=2 n mean std;
	VAR fev fev_6months age height;
RUN;
*could add 95% CI from last week, up to you;


PROC FREQ DATA=lab7.fev_data;
	TABLES sex / norow nocol;
RUN;

PROC MEANS DATA=lab7.fev_data;
	VAR fev;
	CLASS sex;
RUN;

/*----------------------------------------*/
/* Research Question 1: one-sample t-test */
/*----------------------------------------*/
*PHANTOM;
*test the normality assumption;
****** better yet are the assumptions reasonable;

PROC UNIVARIATE DATA=lab7.fev_data;
	VAR fev;
	HISTOGRAM fev / NORMAL;
	PROBPLOT fev;
RUN;

*Research Question 1: complete a two-sided one sample t-test; 
*easy way-via 95% CI from above. does CI include 3.25? if does include 3.25, p>0.05. 
if doesnt include 3.25--> p<0.05;
PROC TTEST DATA=lab7.fev_data H0=3.25 ALPHA=0.05;
	VAR FEV;
RUN;

PROC TTEST DATA=lab7.fev_data H0=3.25 ALPHA=0.05;
	VAR FEV_6months;
RUN;

proc means data=lab7.fev_data n mean std clm;
var fev fev_6months;
run;						*no graphs;

*other valid option:;
data work.fev;
set lab7.fev_data;
fev325=fev-3.25;
fev6325=fev_6months-3.25;
run;			*now mu=0 is what we're testing;
PROC means DATA=work.fev n mean std clm t prt;	*t gives test statistic and prt gives p-value;
	VAR FEV325 fev6325;
RUN;


/*----------------------------------------*/
/* Research Question 2: two sample t-test */
/*----------------------------------------*/
PROC TTEST DATA=lab7.fev_data ALPHA=0.05;
	VAR FEV;
	CLASS sex;
RUN;
PROC TTEST DATA=lab7.fev_data ALPHA=0.05;
	VAR FEV age height fev_6months;
	CLASS sex;
RUN;
*could do proc means;

/*-------------------------------------*/
/* Research Question 3: paired t-test  */
/*-------------------------------------*/
DATA work.new_fev;
	SET lab7.fev_data;
	difference = fev_6months-fev;  *positive values mean improved breathing;
RUN;

PROC UNIVARIATE DATA=work.new_fev;
	VAR difference;
	HISTOGRAM difference / NORMAL;
	PROBPLOT difference;
RUN;

PROC TTEST DATA=lab7.fev_data ALPHA=0.05;
	PAIRED fev_6months*fev;		*positive values for differences means improved breathing;
RUN;
PROC TTEST DATA=lab7.fev_data ALPHA=0.05;
	PAIRED fev*fev_6months;		*negative values for differences means improved breathing. same #s just negative;
RUN;
proc means data=new_fev n mean std clm t prt;
var fev fev_6months difference;
label difference="FEV 6 mo-baseline";
where difference ne .; *display only for those with both time points;
run;


/*-------------------------------------------------------------*/

* Perform the same t-test with an alpha of 0.1 instead of 0.05;

* Perform two sample t-tests on height by sex and age by sex;

/*-------------------------------------------------------------*/

/** Lab exercise  **/

PROC CONTENTS DATA=lab7.commute; 
RUN;
PROC PRINT DATA=lab7.commute (obs=20); 
RUN;
*unit of measurements is students--> 2 separate groups-->2 sample test;
*Question 1;
PROC TTEST DATA=lab7.commute ALPHA=0.05;
VAR commute_to_school_minutes;
CLASS commute_how;
WHERE commute_how IN ('Car','Public transportation (bus/MARTA/etc)'); *need this bc more than 2 class levels and t test does 2;
RUN;

*Question 2;
PROC TTEST DATA=lab7.commute H0=23 ALPHA=0.05;	*one sample test;
VAR commute_to_school_minutes;
RUN;

*Question 3;
PROC TTEST DATA=lab7.commute ALPHA=0.05;		*paired t test bc measure same student twice;
PAIRED commute_to_school_minutes*commute_from_school_minutes; *subtract to minus from;
RUN;


*HW;
libname lab7 'S:\course\BIOS500\Binongo\2023_Lab\Datasets';
proc contents data=lab7.exposure;
run;
proc means data=lab7.exposure;
var chol;
run;
*3;
PROC TTEST DATA=lab7.exposure H0=180 ALPHA=0.05;
	VAR chol;
RUN;
*5;
proc print data=lab7.exposure;
var sex;
run;
proc means data=lab7.exposure;
var bmi;
where sex="M";
run;
proc means data=lab7.exposure;
var bmi;
where sex="F";
run;
PROC TTEST DATA=lab7.exposure ALPHA=0.05;
	VAR bmi;
	CLASS sex;
RUN;
*Pr > |t| = <.0001-->reject H0 (reject that there is no difference-->there is a stat sig diference);
*8;
PROC TTEST DATA=lab7.exposure ALPHA=0.05;
	PAIRED fev_6months*fev;	 
RUN;
