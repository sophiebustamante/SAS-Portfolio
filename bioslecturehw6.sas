data problem1e;
mu=1.8;
sigma=0.5;
z1=quantile ("norm", 0.25);
x1=mu + z1*sigma;
proc print;
run;
*x=1.46276 cm;

data problem1e;
mu=1.8;
sigma=0.5;
z1=quantile ("norm", 0.75);
x1=mu + z1*sigma;
proc print;
run;
*x=2.13724 cm;

data calc;
x=quantile ("norm", 0.8, 1.8, 0.5);
run;
proc print data=calc;
run;
*x=2.22081 cm;

data calc;
x=quantile ("norm", 0.2, 1.8, 0.5);
run;
proc print data=calc;
run;
*x= below 1.37919 cm;

*4d;
data prolem4d;
pd= cdf("norm", -0.9685) - cdf("norm", -2.8203);
run;
proc print;
run;
*p=0.16400;

title;


