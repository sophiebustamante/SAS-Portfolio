libname bios500 "S:\course\BIOS500\Binongo\2023_lab\Datasets";
proc freq data=bios500.titanic;
run;
proc freq data=bios500.titanic;
tables survived*sex;
run;
proc freq data=bios500.titanic;
tables survived*age;
run;
proc freq data=bios500.titanic;
tables survived*class;
run;
proc freq data=bios500.titanic;
tables survived*class*sex;
run;
proc freq data=bios500.titanic;
tables survived*age*sex*class;
run;
data probability;
input x f;
datalines;
0 6
1 10
2 8
3 6
4 4
5 2
;
run;
proc print data=probability;
run;
proc sgplot data=probability;
histogram x / freq=f scale=count binwidth=1;
title "Probability Histogram";
run;
proc means data=probability;
run;
