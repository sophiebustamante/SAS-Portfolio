libname bios500 'S:\course\BIOS500\Binongo\2022_Lab\Datasets';
proc print data=bios500.exposure;
var bmi;
run;
data work.exposure;
set bios500.exposure;
if 0< bmi < 18.5 then bmi2='underweight';
if 18.5 <= bmi < 25 then bmi2='normal';
if 25 <= bmi < 30 then bmi2='overweight';
if bmi >= 30 then bmi2='obese';
run;
proc print data=work.exposure;
var bmi bmi2;
run;
proc freq data=work.exposure;
tables bmi2 /missing;
run;
proc format;
value fluf 0="No"
			1="Yes";
value cancerf 0="No"
				1="Yes";
run;
proc freq data=work.exposure;
   FORMAT flu fluf. cancer cancerf. ;		*names end in a . ;
TABLES flu*cancer;
RUN;
