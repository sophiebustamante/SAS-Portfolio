*1;
data example10_146;
input subject before after;
diff=before-after;
datalines;
1 8.6 33.8
2 32.3 137.0
3 60.7 110.6
4 20.4 52.7
5 39.4 110.5
6 15.7 39.1
7 58.3 124.1
8 3.9 75.0
9 1.5 83.3
10 18.1 71.5
11 100.9 142.0
12 84.3 171.4
13 32.3 52.1
14 41.7 112.9
;
run;
proc ttest data=example10_146 alpha=0.01;
var diff;
run;
proc means data=example10_146;
var before;
run;
proc means data=example10_146;
var after;
run;
*2;
data water;
input location bottom surface;
diff=bottom-surface;
datalines;
1 .430 .415
2 .266 .238
3 .567 .390
4 .531 .410
5 .707 .605
6 .716 .609
7 .651 .632
8 .589 .523
9 .469 .411
10 .723 .612
;
run;
proc ttest data=water alpha=0.05;
var diff;
run;
proc means data=water;
var bottom;
run;
proc means data=water;
var surface;
run;

*3;
data mcnemar;
input before after count;
datalines;
0 0 4
0 1 56
1 0 4
1 1 56
;
run;
proc freq data=mcnemar order=data;
weight count;
tables before*after/agree;
run;

data q3;
q3=1-cdf("norm",6.713);
run;
proc print data=q3;
run;


data indiv;
set mcnemar;
retain id 0;
do id=id+1 to id+count;
member=1; response=before; output;
member=2; response=after; output;
end;
keep id member response;
run;
proc print data=indiv ;
run;

Margins (data = indiv,
class = id member,
response = response,
roptions = event=’0’,
dist = binomial,
model = member,
geesubject = id,
margins = member,
options = diff cl);

*4;
data mcnemar;
input xcured ycured count;
datalines;
1 1 12
1 0 8
0 1 40
0 0 20
;
run;
proc freq data=mcnemar order=data;
weight count;
tables xcured*ycured/agree;
run;
data q4;
q4=2*cdf("norm",-4.619);
run;
proc print data=q4;
run;

data qnotes;
qnotes=2*(1-cdf("norm", 2.40));	*since did times 2 here dont need to multiply the p-value you get by 2;
run;
proc print data=qnotes;
run;

*5;
libname bios500 "H:\BIOS500";
proc contents data=bios500.fev1;
run;
proc means data=bios500.fev1;
var fev;
where smoke=0;
run;
proc means data=bios500.fev1;
var fev;
where smoke=1;
run;
proc freq data=bios500.fev1;
tables fev*smoke;
where smoke=0;
run;
proc freq data=bios500.fev1;
tables fev*smoke;
where smoke=1;
run;
proc sgplot data=bios500.fev1;
vbox fev/category=smoke;
run;
data q5;
q5=2*(1-cdf("t",6.4616,652));
run;
proc print data=q5;
run;
data q6;
q5=2*cdf("t",-6.4616,652);
run;
proc print data=q6;
run;
data lecture;		*example from lecture notes;
lecture=2*cdf("t",-1.554,63);
run;
proc print data=lecture;
run;
data ci;
ci=quantile ("t",0.975,652);
proc print;
run;

*6;
data helicopter;
input group $ dead $ count;
datalines;
road yes 260
road no 840
helicopter yes 64
helicopter no 136
;
run;
proc freq data=helicopter;
weight count;
tables group*dead/expected chisq;
run;
data q6;
q6=1-cdf("chisq", 6.32, 1);
run;
proc print data=q6;
run;
proc freq data=helicopter;
weight count;
tables group*dead/ relrisk ;
run;
