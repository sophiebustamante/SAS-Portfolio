*EPI 534 SAS Final
Sophie Bustamante;
libname nicole "H:\EPI534\SAS";
*1;
proc contents data=nicole.pt_demo;
run;
proc contents data=nicole.pt_clin;
run;
proc sort data=nicole.pt_demo;
by ID;
run;
proc sort data=nicole.pt_clin;
by ID;
run;
data alldata;
merge nicole.pt_demo nicole.pt_clin;
by ID;
run;
proc print data=alldata;
run;
*2;
proc contents data=alldata;
run;
proc freq data=alldata;
tables dislevel famhx hasdis status txgroup;
run;
proc univariate data=alldata;
var dob events visdate heightcm prod_1 prod_2 prod_3 prod_4 prod_5 prod_6 prod_7
	prod_8 prod_9 prod_10 prod_11 prod_12 prod_13 prod_14 prod_15 prod_16 prod_17
	prod_18 prod_19 prod_20 prod_21 prod_22 prod_23 prod_24 prod_25 prod_26 prod_27
	prod_28 prod_29 prod_30 weightkg ;
run;
proc freq data=alldata;;
tables events;
run;
*A. 834;
proc freq data=alldata;
tables txgroup;
run;
*B. 19.86%;
proc freq data=alldata;
tables dislevel;
run;
*C. 10/01/2022;
proc print data=alldata;
var visdate;
format visdate MMDDYY10.;
run;
proc sort data=alldata out=visdatesorted;
by visdate;
format visdate MMDDYY10.;
run;
proc print data=visdatesorted;
var visdate;
run;
*d. 10/10/1924;
proc print data=alldata;
var dob;
format dob MMDDYY10. ;
run;
proc sort data=alldata out=dobsorted;
by dob;
format dob MMDDYY10.;
run;
proc print data=dobsorted;
var dob;
run;
*e. 62;
proc freq data=alldata;
tables txgroup*dislevel;
run;
*A-E answers again for clarity:
A. 834
B. 19.86%
C. 10/01/2022
D. 10/10/1924
E. 62 ;
*3;
data temp1;
set alldata;
*a;
calc_age= (visdate - dob) / 365.25;
age= INT (calc_age);
*b;
enddt= MDY (10, 02, 2022);
ftime= (enddt - visdate) / 365.25;		
*c;
if weightkg < 14.5 then weightkg=.;		
if weightkg > 131 then weightkg=.;
*d;
if visdate=21550 then weightkg=weightkg-3;	
*e;
bmi= weightkg/heightcm**2 *10000;
run;
proc freq data=temp1;
tables bmi*weightkg*heightcm / list;
run;
proc print data=temp1;
var id visdate dob calc_age age ftime enddt weightkg;
format visdate dob  enddt MMDDYY10.;
run;
*4;
data temp2;
set temp1;
if status="Established" or status="Established Patient" then statusn=0;
if status="New" or status= "New Patient" then statusn=1;
if status="Transfer Pat" or status="Transfer Patient" then statusn=2;
if hasdis="Y" then hasdisn=1;
if hasdis="N" then hasdisn=0;
if txgroup="Treatment A" then txgroupn=0;
if txgroup="Treatment B" then txgroupn=1;
if dislevel="Mild" then disleveln=0;
if dislevel="Moderate" then disleveln=1;
if dislevel="Severe" then disleveln=2;
if famhx="Y" then famhxn=1;
if famhx="N" then famhxn=0;
run;					
proc compare data=temp2 compare=temp1 listvar;
id id;
run;
proc freq data=temp2;
tables status*statusn hasdis*hasdisn txgroup*txgroupn dislevel*disleveln famhx*famhxn;
run;
*5;
data temp3;
set temp2;
rename hasdisn=casectrl;
label statusn="Status"
		famhxn="Family History"
		disleveln="Severity of condition";
run;
proc freq data=temp3;
tables (statusn famhxn disleveln) *casectrl;
run;
*6;
proc univariate data=temp3;
var events;
output out=cutpts pctlpts=33.33 66.67 pctlpre=p_;
run;
proc print data=cutpts;
run;
data temp4;
set temp3;
if events GE 0 and events LT 2 then eventlev=0;
if events GE 2 and events LT 5 then eventlev=1;
if events GE 5 then eventlev=2;
run;
proc freq data=temp4;
tables eventlev;
where casectrl=1;
run;
*7;
data temp5;
set temp4;
used=0;
array medsused {9} prod_1 prod_3 prod_10 prod_12 
					prod_14 prod_19 prod_25 prod_28 prod_30;
do i=1 to 9;
if medsused{i}=1 then used=1;
end;
run;
*7a;
proc freq data=temp5;
tables used;
run;
*25.55%;
*8;
data milddis (drop = dob visdate);
set temp5;
if age LT 40 and disleveln=0;
run;
proc print data=milddis;
run;
*9;
proc format;
value wtfmt
	10-29.9="<30"
	30-49.9="30-49"
	50-69.9="50-69"
	70-89.9="70-89"
	90-109.9="90-109"
	110-high="110+" ;
run;
proc freq data=temp5;
tables weightkg*casectrl;
format weightkg wtfmt.;
run;
*10;
libname library "H:\EPI534\SAS";
proc format library=library;
value casefmt
	1="Case"
	0="Control" ;
value sevfmt
	0="Mild"
	1="Moderate"
	2="Severe" ;
run;
data nicole.dcfinal;
set temp5;
format dob visdate MMDDYY10. casectrl casefmt. disleveln sevfmt.;
run;
proc freq data=nicole.dcfinal;
tables casectrl*disleveln;
run;
*11;
proc contents data=alldata;
run;
proc contents data=nicole.dcfinal;
run;
proc compare data=alldata compare=nicole.dcfinal listvar;
id id;
run;
*11a:
new variables: 12 (calc_age, age, enddt, ftime, bmi, statusn, casectrl,
					txgroupn, disleveln, famhxn, eventlev, used, and excluding i)
# subjects whose variable value changed: 20
Bonus: options nofmterr;

