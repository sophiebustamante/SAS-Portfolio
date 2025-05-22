libname bios500 'S:\course\BIOS500\Binongo\2023_Lab\DATASETS';
proc freq data=bios500.heart;
run;
proc freq data=bios500.heart;
tables systolic / plots=freqplot;
run;
proc freq data=bios500.heart;
tables smoking;
run;
proc freq data=bios500.heart;
tables smoking_status*weight_status/missing;
run;
proc freq data=bios500.heart;
tables smoking_status*weight_status;
run;
proc freq data=bios500.heart;
tables bp_status*status;
run;
proc sgplot data=bios500.heart;
vbox mrw / category=smoking_status;
yaxis label="MRW (%)";
xaxis label="Smoking Status";
title ;
run; 	*works;

proc sgplot data=bios500.heart;
vbox mrw / category=smoking_status;
run; *works but wrong y axis label;


proc sgplot data=bios500.heart;
vbox mrw ;
yaxis label="MRW (%)";
xaxis label="Smoking Status";
title ;
run; 		*doesnt have separate smoking status;
