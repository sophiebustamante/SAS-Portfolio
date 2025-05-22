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
