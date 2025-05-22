libname bios500 "S:\course\BIOS500\Binongo\2023_lab\Datasets\";
*q1-q6;
proc contents data=bios500.weight_gain;
run;
proc univariate data=bios500.weight_gain;
var weight weight_emprec;
where 1<= time_emp <= 5;
run;
proc ttest data=bios500.weight_gain alpha=0.05;
paired weight*weight_emprec;
where 1<= time_emp <= 5;
run;	*t value=12.97;

*q7-q10;
proc contents data=bios500.pa_survey;
run;
proc freq data=bios500.pa_survey;
tables cdc_vigorous;
run;
data temp;
set bios500.pa_survey;
if gender="Female" then gender="female";
if cdc_vigorous > 75 then cdc_vigorous1=1;
if 0< cdc_vigorous <= 75 then cdc_vigorous1=0;		*1=overestimate, 0=underestimate;
run;
proc freq data=temp;
tables cdc_vigorous1;
run;
proc freq data=temp;
tables gender*cdc_vigorous1/expected chisq relrisk;
where international="no";
run;

*q11-q12;
data q11;
input classification$ medcount;
datalines;
underweight 5
normal 95
overweight 32
obese 6
;
run;
proc freq data=q11;
weight medcount;
tables classification/nocum testp=(23.3, 42.0, 33.0, 1.7);
run;

*q15-q18;
proc contents data=bios500.arf;
run;
proc univariate data=bios500.arf;
var sc;
run;
proc ttest data=bios500.arf alpha=0.05;
var sc;
class drug;
run;

*q20;
proc contents data=bios500.diabetics;
run;
*one sample of a continous variable;
proc univariate data=bios500.diabetics;
var bmi;
run;
*mean=27.6;
proc ttest data=bios500.diabetics H0=26.5 alpha=0.05;
var bmi;
run;

*q21-q25;
proc contents data=bios500.bp;
run;
proc ttest data=bios500.bp alpha=0.05;
paired baseline*month6;
where trt=1; 
run;
proc ttest data=bios500.bp alpha=0.05;
paired baseline*month6;
where trt=2; 
run;
data q23;
set bios500.bp;
diff=baseline-month6;
run;
proc ttest data=q23;
var diff;
class trt;
run;
proc ttest data=q23;
paired baseline*month6;
run;

data q24;
set bios500.bp;
if baseline>140 then baseline1=1;
if baseline <= 140 then baseline1=0;
if month6>140 then month61=1;
if month6 <= 140 then month61=0;
run;
proc freq data=q24;
tables month61*baseline1;
where trt=1;
run;
proc freq data=q24;
tables month61*baseline1;
where trt=2;
run;


