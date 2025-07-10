SELECT * FROM project3.job_data;

/*
Objective: Calculate the number of jobs reviewed per hour for 
each day in November 2020.
Your Task: Write an SQL query to calculate the number of jobs reviewed 
per hour for each day in November 2020.
*/
select ds as date, round(count(job_id)/sum(time_spent)*3600) as jobs_reviewed_perhour
from job_data
where ds between '2020-11-01' and '2020-11-30'
group by ds
order by ds;

/*
Objective: Calculate the 7-day rolling average of throughput (number of events per second).
Your Task: Write an SQL query to calculate the 7-day rolling average of throughput. Additionally, 
explain whether you prefer using the daily metric or the 7-day rolling average for throughput,
and why.
*/
SELECT ds as dates, 
COUNT(event) / SUM(time_spent) AS daily_throughput,
ROUND(AVG(COUNT(event) / SUM(time_spent)) OVER (ORDER BY ds ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS 7_day_rolling_avg_throughput
FROM job_data
GROUP BY ds
ORDER BY ds;


/*
Objective: Calculate the percentage share of each language in the last 30 days.
Your Task: Write an SQL query to calculate the percentage share of each language over the last 30 days.
*/
select language, 
count(*) / 
(select count(*) from job_data) * 100 as percentage_share 
from job_data
group by language
order by language desc;

/*
Objective: Identify duplicate rows in the data.
Your Task: Write an SQL query to display duplicate rows from the job_data table.
*/
select actor_id, count(*) as duplicate_rows
from job_data
group by actor_id
having count(*) > 1;

select ds, COUNT(ds) as no_of_duplicate
from job_data
group by ds
having no_of_duplicate > 1;

