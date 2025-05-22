libname epi550 "H:\EPI550";

*1;
proc lifetest data=epi550.vets;
time survt*status (0);
strata tx;
run;
*2;
proc means data=epi550.vets;
var age priortx;
run;
*age 58.3065693 
priortx 0.2919708 ;
data means;
input age priortx;
datalines;
58.3065693 
0.2919708 
;
run;
proc phreg data=epi550.vets plots (overlay=row)=survival;
model survt*status(0)= age priortx;
strata tx;
baseline covariates=means;
run;
*3a;
proc phreg data=epi550.vets;
model survt*status(0)=tx age priortx tx_gt;
gt=0;
if survt ge 180 then gt=1;
tx_gt=tx*gt;
contrast "HR < 180 days" tx 1 / estimate=exp;
contrast "HR >= 180 days" tx 1 tx_gt 1 / estimate=exp;
run;
*3b;
proc phreg data=epi550.vets;
model survt*status(0)=age priortx tx_gt1 tx_gt2;
gt1=0;
gt2=0;
if survt ge 0 and survt lt 180 then gt1=1;
if survt ge 180 then gt2=1;
tx_gt1=tx*gt1;
tx_gt2=tx*gt2;
contrast "HR < 180 days" tx_gt1 1 / estimate=exp;
contrast "HR >= 180 days" tx_gt2 1 / estimate=exp;
run;
