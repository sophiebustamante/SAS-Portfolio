*import and view dataset;
proc import datafile="H:\BIOS591\Titanic Spring 2024.csv"
out=titanic 
dbms=csv
replace;
run;
proc contents data=work.titanic;
run;
*descriptive statistics;
proc univariate data=work.titanic;
var age;
run;
proc freq data=work.titanic;
tables ticketclass;
run;
proc univariate data=work.titanic;
var age;
class ticketclass;
run;
*ANOVA with Tukey adjustment;
proc glm data=work.titanic;
class ticketclass;
model age=ticketclass;
lsmeans ticketclass/adjust=tukey cl;
run;
