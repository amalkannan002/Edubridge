data vaccination_data_latest;
infile 'vaccination_data_latest.csv' dlm=',' firstobs=2 dsd;
input State$ TotalCase Active Discharged Deaths Totalvaccinationdoses Dose1 Dose2;
run;
proc print data=vaccination_data_latest;
run;

/* To check is there any missing values present in table*/
proc means data=vaccination_data_latest nmiss;
run;

/* To check the summary  of the data*/
proc summary data=vaccination_data_latest print n mean median  mode stddev min max;
var TotalCase Active Discharged Deaths Totalvaccinationdoses Dose1 Dose2  ;
run;

/* To check the correlation between columns */
proc corr data=vaccination_data_latest;
run;

/* To find information of data */
proc contents data=vaccination_data_latest ;
run;

/* To compare the Median and Maximum values of both dose 1 and dose 2 */

proc means data=vaccination_data_latest(where=(Outcome=1)) print median  max ;
var TotalCase Active Discharged Deaths Totalvaccinationdoses Dose1 Dose2 ;
title "vaccination_data_latest";
proc means data=vaccination_data_latest(where=(Outcome=0)) print median  max;
var TotalCase Active Discharged Deaths Totalvaccinationdoses Dose1 Dose2 ;
title "vaccination_data_latest";
run;
/*.............*/ 


/* Create a sql for storing vaccination details */
proc sql;
create table vaccinationdetails as
select * from vaccination_data_latest;
quit;
proc print data= vaccinationdetails;
run;

/*Select total vaccination details of State   */
proc sql;
select State,Totalvaccinationdoses
from vaccination_data_latest
;
quit;

/* Maximum number of Totalvaccinationdoses display */
proc sql;
select State,Totalvaccinationdoses from vaccination_data_latest order by Totalvaccinationdoses desc
;
quit;

/* Maximum number of Totalvaccinationdoses display */
proc sql;
select State,Totalvaccinationdoses from vaccination_data_latest order by Totalvaccinationdoses desc
;
quit;

/* Maximum number of Totalcases display */
proc sql;
select State,TotalCase from vaccination_data_latest order by TotalCase desc
;
quit;


/* Visualization */
title "Histogram of vaccination data";
proc sgplot data=vaccination_data_latest;
histogram Totalvaccinationdoses/group=TotalCase transparency=0.5 scale=count;
density Totalvaccinationdoses /type=normal group=TotalCase;
keylegend /location=inside position =topright across=1;
run;

title "Histogram of vaccination data";
proc sgplot data=vaccination_data_latest;
histogram Dose1/group=TotalCase transparency=0.5 scale=count;
density Dose1/type=normal group=TotalCase;
keylegend /location=inside position =topright across=1;
run;

title "Histogram of vaccination data";
proc sgplot data=vaccination_data_latest;
histogram Dose2/group=TotalCase transparency=0.5 scale=count;
density Dose2/type=normal group=TotalCase;
keylegend /location=inside position =topright across=1;
run;

proc sgplot data=vaccination_data_latest;
scatter x=Totalvaccinationdoses y=TotalCase;
ellipse x = Active y = Deaths;
	title 'Scatter plot';

/* Hbar */
proc sgplot  data=vaccination_data_latest;
     hbar TotalCase/response=Dose1 stat=mean
     datalabel datalabelattrs=(weight=bold) fillattrs=(color=cadetblue);
     title 'Dose 1 vaccination';
run;

 