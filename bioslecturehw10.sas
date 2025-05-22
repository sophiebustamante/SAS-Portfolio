*2;
data fitness;
do i=1 to 14;
do j=i+1 to 14;
do k=j+1 to 14;
do m=k+1 to 14;
do n=m+1 to 14;
sum = i+j+k+m+n;
output;
end;
end;
end;
end;
end;
proc freq; 
tables sum;
run;

data fitness;
input location rank;	*1=farm, 2=town;
cards;
1 12.9
1 10.6
1 12.5
1 11.4
1 6.3
2 16
2 15.3
2 16.9
2 5.9
2 14.8
2 9.1
2 10.6
2 7.9
2 5.6
;
proc npar1way wilcoxon;
class location;
var rank;
exact;
run;

proc univariate data=fitness;
var rank;
where location=1;
run;
proc univariate data=fitness;
var rank;
where location=2;
run;

data fitness;	*this way has ranks instead of actual values;
input location rank;	*1=farm, 2=town;
cards;
1 10
1 6.5
1 9
1 8
1 3
2 13
2 12
2 14
2 2
2 11
2 5
2 6.5
2 4
2 1
;
proc npar1way wilcoxon;
class location;
var rank;
exact;
run;

*d;
proc npar1way HL data=fitness;
class location;
var rank;
exact HL;
run;

*5;
DATA BP;
INPUT PATIENT BEFORE AFTER;
DIFF=BEFORE-AFTER;
ABS=ABS(DIFF);
DATALINES;
1 125 118
2 132 134
3 138 130
4 120 124
5 125 105
6 127 130
7 136 130
8 139 132
9 131 123
10 132 128
11 135 126
12 136 140
13 128 135
14 127 126
15 130 132
;
RUN;

proc means data=BP median q1 q3;
var before after diff;
run;
proc univariate data=BP cipctldf;
var diff;
run;

*4;
data q4;
q4=2*(1-cdf("bino",74,0.5 ,9));
proc print;
run;
data pvalue;
pvalue=2*cdf("bino",75,0.5,9);
proc print;
run;
