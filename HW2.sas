libname epi550 "H:\EPI550";
*3;
proc logistic data=epi550.dhs_water2;
model breastfeeding (event="1")= WaterDistance WaterSource ChildAge WaterDistance*ChildAge;
run;
*5a 0 months;
proc logistic data=epi550.dhs_water2;
model breastfeeding (event="1")= WaterDistance WaterSource ChildAge WaterDistance*ChildAge;
contrast "OR - WaterDistance - ChildAge = 0" WaterDistance 1 / est=exp;
run;
*5b 6 months;
proc logistic data=epi550.dhs_water2;
model breastfeeding (event="1")= WaterDistance WaterSource ChildAge WaterDistance*ChildAge;
contrast "OR - WaterDistance - ChildAge = 6" WaterDistance 1 WaterDistance*ChildAge 6 / est=exp;
run;
*5c 12 months;
proc logistic data=epi550.dhs_water2;
model breastfeeding (event="1")= WaterDistance WaterSource ChildAge WaterDistance*ChildAge;
contrast "OR - WaterDistance - ChildAge = 12" WaterDistance 1 WaterDistance*ChildAge 12 / est=exp;
run;
*6c;
*full model;
proc logistic data=epi550.dhs_water2;
model breastfeeding (event="1")= WaterDistance WaterSource ChildAge WaterDistance*ChildAge;
run;
*reduced model;
proc logistic data=epi550.dhs_water2;
model breastfeeding (event="1")= WaterDistance WaterSource ChildAge;
run;
*pvalue (df=1 bc only took one product term out);
data pvalue;
p_value= 1-probchi(0.281, 1);
run; 
proc print data=pvalue;
run;



