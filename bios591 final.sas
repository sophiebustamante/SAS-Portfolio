libname bios "H:\BIOS591";
proc contents data=bios.final_exam_2024;
run;
*descriptive analyses;
proc freq data=bios.final_exam_2024;
tables y_stenosis;
run;
proc freq data=bios.final_exam_2024;
tables x1_sex;
run;
proc univariate data=bios.final_exam_2024;
var x2_chol;
run;
proc univariate data=bios.final_exam_2024;
var x3_age;
run;
*bivaraite analysis for the data analyst knowledge, not to go in report;
proc freq data=bios.final_exam_2024;
tables x1_sex*y_stenosis/chisq oddsratio (CL=wald);
run;
proc ttest data=bios.final_exam_2024;
class y_stenosis;
var x2_chol;
run;
proc ttest data=bios.final_exam_2024;
class y_stenosis;
var x3_age;
run;
*logistic analysis;
proc logistic data=bios.final_exam_2024 plots=ROC; *roc produes ROC curve;
model y_stenosis(event='1')= x1_sex x2_chol x3_age;
run;







