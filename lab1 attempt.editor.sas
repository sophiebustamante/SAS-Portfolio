libname bios500 'S:\course\bios500\binongo\2023_lab\datasets\' ;

proc contents data=bios500.exposure;
run; 

proc print data=bios500.exposure;
run;

proc print data=bios500.exposure (obs=10);
run; 
proc contents data=bios500.healthy_doc;
run; 

proc contents data=bios500.healthy_doc;
run; 

Libname work "S:\course\BIOS500\Binongo\2023_Lab\Datasets";
run; 
libname HOMEWORK "S:\course\BIOS500\Binongo\2023_Lab\Datasets" ;
run;
Libname work "S:\course\BIOS500\Binongo\2023_Lab\Datasets\health_doc.sas7bdat";
run; 
Libname HOMEWORK "S:\course\BIOS500\Binongo\2023_Lab\Datasets\health_doc.sas7bdat";
libname work ‘S:\course\BIOS500\Binongo\2023_Lab\Datasets\health_doc.sas7bdat’;

libname work 'S:\course\bios500\binongo\2023_lab\datasets' ;
libname work 'S:\course\bios500\binongo\2023_lab\datasets\health_doc.sas7bdat' ;
libname homework 'S:\course\bios500\binongo\2023_lab\datasets';

proc contents data=homework.healthy_doc varnum;
run;

proc print data=homework.healthy_doc (obs=10);
run;
proc print data=homework.healthy_doc (firstobs=500 obs=500); var age; 
run;

proc print data= HOMEWORK.HEALTHY_DOC;
var hours_sleep -- fruitveg_perday;
run;
