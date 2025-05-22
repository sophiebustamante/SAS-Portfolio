/*=========================*/
/*  Bios 500 Lab 6         */
/*  Probability Practice   */
/*=========================*/

/*----------------------------*/
/* Problem 1                  */
/* Hypergeometic Distribution */
*bc finite, yes or no outcome;
/*----------------------------*/

/* c) - g) */
libname bios500 "S:\course\BIOS500\Binongo\2023_lab\Datasets";
data bronchitics;
pr_eq3_a=comb(1000,3)*comb(19000,47)/comb(20000,50); 
run;
proc print data=bronchitics;
run;* 'by hand', using  binomial coefficients. 1000 choose 3;
data bronchitics;
pr_eq13=pdf('hyper',3,20000,1000,50);
run;
proc print data=bronchitics;		*gives same answer as above;
run;
data x1d;
pr_lt6=cdf('hyper',5,20000,1000,50);	*cdf caluclates 0,1,2..5. x N   M n;
run;
proc print data=x1d;
run;		*question 1D;	*can round by hand or tell SAS: format pr_lt6 5.3 semicolon ;
data x1e;
*since p(<6)=.96 then prob (x>=8) is less than 1-.96 or 4%. could also actually calculate;
pr_ge8=1-cdf('hyper',7,20000,1000,50); *anytime you have to do > you know to subtract from 1;
run;
proc print data=x1e;
run;
*p=.003 so very rare;
data bronchitics;
pr_eq3_a=comb(1000,3)*comb(19000,47)/comb(20000,50); 
pr_eq13=pdf('hyper',3,20000,1000,50);
pr_lt6=cdf('hyper',5,20000,1000,50);
pr_ge8=1-cdf('hyper',7,20000,1000,50);

*expected value =np;
*n*M/N;
*n*P;
data x1f;
E_X=50*1000/20000;									  * Expectation;
Std_X=sqrt((20000-50)/(20000-1)*E_X*(1-1000/20000));  * Standard Deviation ; 
run;						*make sure to have all parantheses;
proc print data=x1f; 
run;

/* Simulate data from hypergeometric distribution */
data sim_hyper;
CALL streaminit (458712);	*sets a seed for generating random numbers to get same answer if ran again and again. wont be exactly same number but basically;
do i=1 to 1000000;
  x=rand('hyper',20000,1000,50);		*rand generates random numbers;
		*distribution N, M, n;	
  output;						*output saves this record into a sas dataset;	
  							*ends the i=1 to 1000000 do loop ;
  end;
  run;

 /* Calculate mean and standard deviation */
proc means data=sim_hyper mean std;
  var x;
run;

/* h) - j) */
/* Median and IQR */

data bronchitics2;		*p	  N	    M   n;
median=quantile('hyper',0.5,20000,1000,50);
run;
proc print; 
run;
/*median=2*/
*OR:;
proc univariate data=sim_hyper;
var x;
run;

data bronchitics2;
pr_le2=cdf('hyper',2,20000,1000,50);	*p=0,1,2;
*					p=.25;
Q1=quantile('hyper',0.25,20000,1000,50);
Q3=quantile('hyper',0.75,20000,1000,50);
*					p=.25;
IQR=Q3-Q1;
run;

proc print data=bronchitics2;
run;


/* Draw and describe the shape of distribution */
data hypergraph;
  do x=0 to 50;
    y=100* pdf('hyper',x,20000,1000,50);
	*x=0, y=prob (x=0)
	x=1 y=prob (x=1)
	.....50;
    output;
  end;
run;

proc print data=hypergraph;
run;

/* plot histogram */
proc sgplot data=hypergraph;
title " X ~ Hyp(n=50, M=1000, N=20000)";
xaxis label="X" min=0 max=10;
yaxis label="P[X=x] (%)";
histogram x / freq=y binwidth=1;	*bindwidth means do 1 value of x at a time;
run;


/*----------------------------*/
/* Problem 2                  */
/* Binomial Distribution      */
/*----------------------------*/
*a) possibilities are 0 to 35;
*b) binomial n=35, p=0.70;
/* c) - j) */
/* Draw and describe the shape of distribution */
data binograph;
  do x=0 to 35;			 *P, n);
    y=100* pdf('bino',x,0.7,35);		*percent not prob so multiply by 100;
    output;
  end;
run;

proc print data=binograph;
run;

/* Plot histogram */
proc sgplot data=binograph;
title " X ~ Bin(n=35, p=0.7)";
xaxis label="X" min=0 max=35;
yaxis label="P[X=x] (%)";
histogram x / freq=y binwidth=1;
run;

data antibiotic;	*  k   p   n;
pr_eq20=pdf('binomial',20,0.7,35);
run;

data antibiotic;
pr_eq20=pdf('binomial',20,0.7,35);
pr_eq0a=pdf('bino',0,0.7,35);	*2 diff ways: pdf or not;
pr_eq0b=0.3**35;
pr_ge1=1-pr_eq0a;	*or 1 -pr_eq0;
pr_le25=cdf('bino',25,0.7,35);	*asked for at most 25, inclusive--> cdf;
pr_ge20=1-cdf('bino',19,0.7,35);	*includes 20--> 1-19, 18,17,...0 is 20,21,22,...35;
pr_ge20_le25=cdf('bino',25,0.7,35)-cdf('bino',19,0.7,35);	*range, makee sure whats included;
run;

proc print data=antibiotic;
run;

/* Simulate data from binomial distribution */
data sim_bin;
do i=1 to 1000000;
*simulate from bin p n;
  x=rand('bino',0.7,35);
  output;
  end;
run;

proc print data=sim_bin (obs=30); run;

  /* Calculate mean and standard deviatiion */
proc means data=sim_bin mean std;
  var x;
run;

/* part k) */
/* Quantiles */

data antibiotic2;	*median quantile=.5; *IQR=q3-q1;
  median=quantile('bino',0.5,0.7,35); 
  /* median=25 */	*.25 for q1;
  Q1=quantile('bino',0.25,0.7,35);
  					*.75 for q3;
  Q3=quantile('bino',0.75,0.7,35);
  IQR=Q3-Q1; 
run;

proc print data=antibiotic2;
run;

/*----------------------------*/
/* Problem 3                  */
/* Poisson Distribution       */
/*----------------------------*/
*a)e^-2.7 *2.7^x all over x! 		x=0,1,2.... ;
/* b) Draw and describe the shape of distribution */
data poigraph;
  do x=0 to 15;		*    lambda;
    y=100* pdf('pois',x,2.7);	*percent so 100;
    output;
  end;
run;

proc print data=poigraph;
run;

/* plot histogram */
proc sgplot data=poigraph;
title " X ~ Poi(lambda=2.7)";
xaxis label="X" min=0 max=10;
yaxis label="P[X=x] (%)";
histogram x / freq=y binwidth=1;
run;

/* b) Simulate data from Poisson distribution */
data sim_pois;
do i=1 to 1000000;
  x=rand('pois',2.7);
  output;
  end;
  run;

proc means data=sim_Pois mean std median q3 q1;
  var x;
run;

/* parts d) - g) */

data wasp;
pr_eq2=pdf('pois',2,2.7);
*exactly 2;
pr_ge3=1-cdf('pois',2,2.7);
*greater or equal 3. at least 3--> subtract from 1: 1-0,1,2...= 3,4,5...;
pr_ge2_le7=cdf('pois',7,2.7)-cdf('pois',1,2.7);
pr_ge1=1-cdf('pois',0,2.7);

cond_pr=pr_eq2/pr_ge1;
run;

proc print data=wasp;
run;


/*----------------------------*/
/* Problem 4                  */
/* Normal Distribution        */
/*----------------------------*/

/* a) Draw the distribution */

data knee;
mu=1.3; sigma=0.4;
do acid=mu-sigma*3 to mu+sigma*3 by 0.01;	*from mu-3sigma to m+3sigma by .01;
  y=pdf('normal',acid,mu,sigma); 
  output;
  end;
run;

proc print data=knee (obs=10);run;

/* plot */
proc sgplot data=knee noautolegend;
  title "X ~ N(mu=1.3, sigma=0.4)";
  pbspline x=acid y=y / nomarkers;	*draws a smooth curve with no symbols;
  xaxis label = 'Concentration of Hyaluronic acid (mg/mL) ';
  run;

  /*  parts c) -h)  */
data knee2;				*p  mu sigma;
Q3=quantile('normal', 0.75,1.3,0.4);
Q1=quantile('norm', 0.25,1.3,0.4);
IQR=Q3-Q1;

pr_lt14a=cdf('norm', 1.4,1.3,0.4);
	*raw data;
pr_lt14b=cdf('norm', 0.25);
	*uses z score;
pr_lt2_gt1=cdf('norm', 2,1.3,0.4)-cdf('norm',1,1.3,0.4);
*p(<2) - prob(>1)=prob btw 1 and 2;
pr_gt21=1-cdf('norm',2.1,1.3,0.4);
*greater than-->subtract from 1 and flip sign; * >2.1 is 1-<2.1;
tenth_perc=probit(0.9)*0.4+1.3;
			       *z * sd + mu;
run;

proc print data=knee2;
run;


*HW/lab6
1 & 2;
data jury;
do i=1 to 1000000;
x= rand ("hyper", 30, 20, 12); 
output;
end;
run;
proc means data=jury mean std;
var x;
run;
data jury;
E_X=12*20/30;									  * Expectation;
Std_X=sqrt((30-12)/(30-1)*E_X*(1-20/30));  * Standard Deviation ; 
run;						*make sure to have all parantheses;
proc print data=jury; 
run;
*4;
data jury;
pequal8= pdf ("hyper", 8, 30, 20, 12);
proc print;
run;
*5;
data poisson;
peq1= pdf ("pois", 1, 1.7);
proc print;
run;
*6;
data poisson;
pge2= 1-cdf("pois", 1, 1.7);
proc print;
run;
*8;
data mm;
pge244=1-cdf('bino', 243, 1/3, 684 );
proc print; 
run;

*9;
data height;		*p  mu sigma;
Q3=quantile('norm', 0.75,61.9,2.5);
Q1=quantile('norm', 0.25,61.9,2.5);
IQR=Q3-Q1;
run;
proc print data=height;
run;
*10;
data hemo;
pr_lt153_gt148=cdf('norm', 15.3,15.1,0.2846)-cdf('norm',14.8,15.1,0.2846);
run;
proc print data=hemo;
run;

*11;
data hemo;
pgt151=1-cdf('norm',15.1,15.1,0.2846); 	*sample pop-->SE not SD--> SD/sqaure root n;
proc print;
run;
