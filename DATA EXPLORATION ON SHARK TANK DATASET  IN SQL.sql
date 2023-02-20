                           #### DATA EXPLORATION ON SHARK TANK DATASET USING SQL ##### 

select*from Project.dbo.data

---Total Episodes 
select max(Ep_no) as max_episode from Project.dbo.data
select count(distinct ep_no) as total_episode from Project.dbo.data

--Pitches
select count(distinct brand) from Project.dbo.data

--Pitches Converted
select sum(a.converted_not_converted) as funding_received,count(*)total_pitches from(
select amount_invested_lakhs,case when amount_invested_lakhs>0 then 1 else 0 end as converted_not_converted from project..data)a

select  cast(sum(a.converted_not_converted) as float )/cast(count(*) as float ) from(
select amount_invested_lakhs, case when amount_invested_lakhs>0 then 1 else 0 end as converted_not_converted from Project.dbo.data )a

-- Total Male 
select sum(male)from Project.dbo.data

--Total Female 
select sum(female) from Project.dbo.data

--Gender Ratio 
select sum(female)/sum(male) from Project.dbo.data

--Total Amount Invested 
select sum(amount_invested_lakhs) from  Project.dbo.data

--Average equity taken
select avg(a.equity_taken) from 
(select*from  Project.dbo.data where equity_taken>0) a 

--Highest Deal Taken 
select max(amount_invested_lakhs) from  Project.dbo.data

--Highest Equity Taken 
select max(equity_taken) from  Project.dbo.data

--Startups Having At Least 1 Women 
select sum(a.female_count) as startups_having_at_least_1_women from(
select female ,case when female >0 then 1 else 0 end as female_count from  Project.dbo.data) a

---- Pitches Converted Having At least 1 women 
select * from  Project.dbo.data

select sum(b.female_count) from(
select case when female>0 then 1 else 0 end as female_count ,a.*from(
select * from  Project.dbo.data where deal!='no deal ')a)b

---Average Team Member 
select avg(team_members) from  Project.dbo.data

--Amount Invested Per Deal 
select avg(a.amount_invested_lakhs) as amount_invested_per_deal from
(select * from  Project.dbo.data where deal!='no deal')a

--Average Age Group Of Contestants 
select avg_age ,count(avg_age) as age_count from  Project.dbo.data group by avg_age order by age_count desc 

--Location Group Of Contestants
select location,count(location) as location_count from  Project.dbo.data group by location order by location_count desc

--Sector Group Of Contestants 
select sector ,count(sector) as sector_count from  Project.dbo.data group by sector order by sector_count desc 

--Partner Deals
select partners,count(partners) as partner_count from  Project.dbo.data where partners !='-' group by partners order by partner_count desc 

---- Which is the startup in which the highest amount has been invested in each domain/sector.

select c.* from 
(select brand,sector,amount_invested_lakhs, rank() over(partition by sector order by amount_invested_lakhs desc) rnk
from  Project.dbo.data ) c 
where c.rnk = 1 

--Making The Matrix 

select * from  Project.dbo.data

select 'ashneer' as keyy,count(ashneer_amount_invested) from  Project.dbo.data where ashneer_amount_invested is not null AND ashneer_amount_invested!=0 

select 'ashneer' as keyy ,sum(c.ashneer_amount_invested),avg(c.ashneer_equity_taken) from 
(select * from  Project.dbo.data where ashneer_equity_taken!=0 and ashneer_equity_taken is not null )c

select m.keyy ,m.total_deals_present,m.total_deals,n.total_amount_invested,n.avg_equity_taken from 

(select a.keyy,a.total_deals_present ,b.total_deals from(
select 'ashneer' as keyy ,count(ashneer_amount_invested) total_deals_present from  Project.dbo.data where 
ashneer_amount_invested is not null) a

inner join (
select 'ashneer' as keyy ,count(ashneer_amount_invested) total_deals from  Project.dbo.data
where ashneer_amount_invested is not null and ashneer_amount_invested != 0)b 
on a.keyy=b.keyy)m
inner join 

( select 'ashneer' as keyy ,sum(ashneer_amount_invested) total_amount_invested,
avg(c.ashneer_equity_taken) avg_equity_taken 
from (select*from  Project.dbo.data where ashneer_equity_taken is not null )c) n 
on m.keyy=n.keyy










