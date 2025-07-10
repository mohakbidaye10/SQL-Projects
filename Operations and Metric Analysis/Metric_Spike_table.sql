#case study 2
#Investigating Metric Spike

#creating table 1 - users
create table users(
	user_id int,
    created_at	varchar(100),
    company_id	int,
    language varchar(50),
    activated_at varchar(100),
    state varchar (50)
);

show variables like 'secure_file_priv';

#importing data from users.csv
load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/users.csv"
into table users
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

select * from users;

#altering table users
alter table users add column temp_created_at datetime;

update users set temp_created_at = STR_TO_DATE(created_at, '%d-%m-%Y %H:%i');

alter table users drop column created_at;

alter table users change column temp_created_at created_at datetime;

#creating table 2 - events
create table events(
	user_id	int,
    occurred_at	varchar(100),
    event_type	varchar(50),
    event_name	varchar(100),
    location varchar(50),
    device varchar(50),
    user_type int
);

#importing data from events.csv
load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/events.csv"
into table events
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

select * from events;
#altering table events
alter table events add column temp_occured_at datetime;

update events set temp_occured_at = STR_TO_DATE(occurred_at, '%d-%m-%Y %H:%i');

alter table events drop column occurred_at;

alter table events change column temp_occured_at occurred_at datetime;

# creating table 3 - email-events
create table email_events(
	user_id	int,
    occurred_at	varchar(100),
    action varchar(100),	
    user_type int
);

#importing data from email_events.csv
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/email_events.csv'
into table email_events
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

select * from email_events;
#altering table email_events
alter table email_events add column temp_occured_at datetime;

update email_events set temp_occured_at = STR_TO_DATE(occurred_at, '%d-%m-%Y %H:%i');

alter table email_events drop column occurred_at;

alter table email_events change column temp_occured_at occurred_at datetime;