libname homework "S:\course\BIOS500\Binongo\2023_lab\Datasets";

proc contents data=homework.bodytemp;
run;
proc sgplot data=homework.bodytemp ;
vbox temperature/ category=sex;
run;
proc sgplot data=homework.bodytemp ;
vbox heartrate/ category=sex;
run;
proc univariate data=homework.bodytemp;
var heartrate temperature;
class sex;
run;
proc univariate data=homework.bodytemp;
var heartrate temperature;
run;

proc sgplot data=homework.bodytemp ;
vbox heartrate;
run;
proc sgplot data=homework.bodytemp ;
vbox temperature;
run;
proc univariate data=homework.bodytemp;
var heartrate temperature;
run;
