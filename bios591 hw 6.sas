*problem set 6;
*import and view dataset;
proc import datafile="H:\BIOS591\Titanic Spring 2024.csv"
out=titanic 
dbms=csv
replace;
run;
proc contents data=work.titanic;
run;
*descriptive statistics;
proc freq data=work.titanic;
tables survived;
run;
proc freq data=work.titanic;
tables sex;
run;	*1=male 0=female;
data work.titanic2;
set work.titanic;
if age=. then age2=.;
else if age >= 15 then age2=1;
else age2=0;
run;
proc freq data=work.titanic2;
tables age2;
run;
proc freq data=work.titanic2;
tables ticketclass;
run;
*bivariate analysis;
proc freq data=work.titanic2;
tables (sex age2 ticketclass)*survived/chisq
oddsratio(cl=wald);
run;
*logistic regression;
proc logistic data=work.titanic2;
class ticketclass (param=ref ref='3'); *producing dummy variables for ticketclass;
model survived(event='1')=sex age2 ticketclass;
oddsratio ticketclass / diff=all;
run;
*model fit;
proc logistic data=work.titanic2 plots=roc;
class ticketclass (param=ref ref='3'); 
model survived(event='1')=sex age2 ticketclass;
oddsratio ticketclass / diff=all;
run;
*logistic regression of different model for comparison;
proc logistic data=work.titanic2 plots=roc;
model survived(event='1')=sex age2;
run;
