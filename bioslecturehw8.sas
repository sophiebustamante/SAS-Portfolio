data abi;
mu=0.64; std=0.15; n=187;
run;
data abi;
p= cdf ("norm", -23.70);
run;
proc print data=abi;
run;
data abi;
p=cdf("t", -23.70, 186);
run;
proc print data=abi;
run;

data recover;
mu=341; n=609;
run;
proc ttest data=recover h0=341 plots(showh0) alpha=0.01;
run;

data coverage;
seed=6041935; alpha=0.01; z=quantile("norm",1-alpha/2);
p=0.001; n=609;
do i = 1 to 10000;
x = ranbin(seed,n,p);
p_hat=x/n; n_tilde = n+4; p_tilde=(x+2)/n_tilde;
lower_w = p_hat - z*sqrt(p_hat*(1-p_hat)/n);
upper_w = p_hat + z*sqrt(p_hat*(1-p_hat)/n);
lower_a = p_tilde - z*sqrt(p_tilde*(1-p_tilde)/n_tilde);
upper_a = p_tilde + z*sqrt(p_tilde*(1-p_tilde)/n_tilde);
lower_s = p_hat*n/(n+z**2)+0.5*z**2/(n+z**2)-
z*sqrt(1/(n+z**2)*(p_hat*(1-p_hat)*n/(n+z**2)+.25*z**2/(n+z**2)));
upper_s = p_hat*n/(n+z**2)+0.5*z**2/(n+z**2)+
z*sqrt(1/(n+z**2)*(p_hat*(1-p_hat)*n/(n+z**2)+.25*z**2/(n+z**2)));
if lower_w <= p <= upper_w then captured_w = "yes";
else captured_w = "no";
if lower_a <= p <= upper_a then captured_a = "yes";
else captured_a = "no";
if lower_s <= p <= upper_s then captured_s = "yes";
else captured_s = "no";
output;
end;
keep lower_w upper_w lower_a upper_a lower_s upper_s captured_w captured_a captured_s;
run;
proc print data=coverage (obs=10);
run;
proc freq data=coverage;
tables captured_w captured_a captured_s;
run;


*9;
diff=2*cdf("t",0.1887,65);
run;

proc print data=exam;
run;
proc means data=exam;
run;


*10;
data A;
input id score;
datalines;
101	26
102	18
103	22
104	27
105	21
106	19
107	24
108	26
109	27
110	24
111	16
112	11
113	30
114	19
115	16
116	29
117	28
118	24
119	27
120	25
121	21
122	20
123	28
124	30
125	28
126	20
127	28
128	25
129	23
130	16
131	29
132	30
133	26
134	23
135	29
136	23
137	24
138	27
139	30
140	25
141	20
142	14
143	29
144	24
145	24
146	26
147	30
148	10
149	28
150	28
151	25
152	23
153	27
154	21
155	26
156	29
157	25
158	19
159	28
160	25
161	28
162	19
163	19
164	21
165	24
166	25
167	26
168	27
169	27
170	25
171	23
172	27
173	29
174	26
175	15
176	27
;
run;

data B;
input id score;
datalines;
177	17
178	28
179	23
180	29
181	27
182	28
183	27
184	23
185	23
186	27
187	25
188	28
189	12
190	29
191	30
192	18
193	17
194	27
195	27
196	26
197	29
198	25
199	30
200	29
201	18
202	24
203	21
204	25
205	21
206	26
207	28
208	21
209	28
210	28
211	30
212	27
213	24
214	28
215	18
216	23
217	24
218	29
219	24
220	28
221	21
222	23
223	26
224	15
225	15
226	18
227	27
228	17
229	20
230	29
231	28
232	19
233	27
234	29
235	26
236	20
237	29
238	28
239	26
240	29
241	23
242	28
243	29
244	22
245	26
246	23
247	26
248	28
249	22
250	30
251	20
252	22
253	23
;
run;
proc univariate data=A;
var score;
run;
proc univariate data=B;
var score;
run;
*variance of 20.8791228 and 18.2723855 --> pooled;
p=2*cdf("t",-0.1451,151);
run;
data t;
tvalue=quantile("t",0.975,151);
proc print;
run;
data concatenate;
set A B;
run;
proc print data=concatenate;
run;
proc ttest data=concatenate h0=0 alpha=0.05;
var score;
run;

*11;
libname bios500 "H:\BIOS500";
proc print data=bios500.seatbelt1;
run;
proc freq data=bios500.seatbelt1;
tables seatbelt*injury /expected chisq alpha=0.01;
run;
proc contents data=bios500.seatbelt1;
run;
proc freq data=bios500.seatbelt1;
tables seatbelt*injury/relrisk alpha=0.01;
run;




proc print data=exam;
run;
proc univariate data=exam;
run;
data compare;
set exam;
if ID GE 101 or ID LE 176 then group=1;
if ID GE 177 or ID LE 253 then group=2;
run;
PROC TTEST DATA=compare ALPHA=0.05;
	VAR Score_on_Form_A;
	CLASS group;
RUN;

*10;
proc print data=exam;
run;
proc means data=exam;
run;
data exam1;
set exam;
score=score_on_form_A;
if id < 177 then form=0;
if id ge 177 then form=1;
run;
proc ttest data=exam1 alpha=0.05;
var score;
class form;
run;
