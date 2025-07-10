SELECT * FROM project3.events;

/*
Objective: Measure the activeness of users on a weekly basis.
Your Task: Write an SQL query to calculate the weekly user engagement.
*/
select extract(week from occurred_at) as week_number,
count(distinct user_id) as number_of_users
from events
where event_type = 'engagement'
group by week_number;

/*
Objective: Analyze the growth of users over time for a product.
Your Task: Write an SQL query to calculate the user growth for the product.
*/
select months, new_users, ((new_users / lag(new_users,1), over(order by months) - 1) * 100) as growth
from
(
select month(created_at) as months,
count(distinct user_id) as new_users
from users
where users.activated_at is not null
group by months
order by months
) as sub_query;


/*
Objective: Analyze the retention of users on a weekly basis after signing up for a product.
Your Task: Write an SQL query to calculate the weekly retention of users based on 
their sign-up cohort.
*/
select first as Week_numbers,
sum(case when week_number = 0 then 1 else 0 end) as "Week 0",
sum(case when week_number = 1 then 1 else 0 end) as "Week 1",
sum(case when week_number = 2 then 1 else 0 end) as "Week 2",
sum(case when week_number = 3 then 1 else 0 end) as "Week 3",
sum(case when week_number = 4 then 1 else 0 end) as "Week 4",
sum(case when week_number = 5 then 1 else 0 end) as "Week 5",
sum(case when week_number = 6 then 1 else 0 end) as "Week 6",
sum(case when week_number = 7 then 1 else 0 end) as "Week 7",
sum(case when week_number = 8 then 1 else 0 end) as "Week 8",
sum(case when week_number = 9 then 1 else 0 end) as "Week 9",
sum(case when week_number = 10 then 1 else 0 end) as "Week 10",
sum(case when week_number = 11 then 1 else 0 end) as "Week 11",
sum(case when week_number = 12 then 1 else 0 end) as "Week 12",
sum(case when week_number = 13 then 1 else 0 end) as "Week 13",
sum(case when week_number = 14 then 1 else 0 end) as "Week 14",
sum(case when week_number = 15 then 1 else 0 end) as "Week 15",
sum(case when week_number = 16 then 1 else 0 end) as "Week 16",
sum(case when week_number = 17 then 1 else 0 end) as "Week 17",
sum(case when week_number = 18 then 1 else 0 end) as "Week 18"
from
(
select m.user_id, m.login_week, n.first, m.login_week - first as week_number
from
(select user_id, extract(week from occurred_at) as login_week from events
group by 1,2) m,
(select user_id, min(extract(week from occurred_at)) as first from events
group by 1) n
where m.user_id = n.user_id
) sub
group by first
order by first;

/*
Objective: Measure the activeness of users on a weekly basis per device.
Your Task: Write an SQL query to calculate the weekly engagement per device.
*/
select week(occurred_at) as week, device, count(distinct user_id) as user_engagement
from events
group by week, device;


/*
Objective: Analyze how users are engaging with the email service.
Your Task: Write an SQL query to calculate the email engagement metrics.
*/

select distinct week(occurred_at) as week_num,
count(distinct case when action = 'sent_weekly_digest' then user_id end) as email_digest,
count(distinct case when action='sent_reengagement_email' then user_id end) as reengagement_emails,
count(distinct case when action = 'email_clickthrough' THEN user_id end) as click_through,
count(distinct case when action ='email_open' then user_id end) as email_open
from email_events
group by week(occurred_at);
