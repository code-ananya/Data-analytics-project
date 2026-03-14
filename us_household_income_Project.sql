SELECT * FROM us_project.us_household_income;

SELECT * FROM us_project.us_household_income_statistics;

alter table us_project.us_household_income_statistics rename column `ï»¿id` to `id`;

select id ,count(id)
from us_household_income
group by (id)
having count(id)>1;


select *
from (
select row_id,
id,
row_number() over(partition by id order by id) as row_num
from us_household_income
) duplicates
where row_num >1;





select row_id
from (
select row_id,
id,
row_number() over(partition by id order by id) as row_num
from us_household_income
) duplicates
where row_num >1;



delete from us_household_income
where row_id in (

select row_id
from (
select row_id,
id,
row_number() over(partition by id order by id) as row_num
from us_household_income
) duplicates
where row_num >1)
;



select id ,count(id)
from us_household_income_statistics
group by (id)
having count(id)>1;

select State_Name , count(State_Name)
from us_household_income
group by State_Name
;

select State_name 
from us_household_income
where State_Name = 'georia';

update us_household_income 
set State_name  = 'Georgia'
where State_name = 'georia'
; 


update us_household_income 
set State_name  = 'Alabama'
where State_name = 'alabama'
; 

SELECT * FROM us_project.us_household_income;

select distinct State_ab
from us_household_income
order by 1;

select * 
from us_household_income
where Place = ''
order by 1;

select * 
from us_household_income
where County = 'Autauga County'
order by 1;

update us_household_income
set Place = 'Autaugaville'
where County ='Autauga County'
and City = 'Vinemont';

select Type , count(Type)
from us_household_income
group by Type;




update us_household_income
set Type = 'Borough'
where Type ='Boroughs'
;



select ALand,AWater
from us_household_income
where ALand = 0 OR ALand = '' OR ALand is null
and  AWater = 0 OR AWater = '' OR AWater is null;

select State_name,sum(ALand),sum(AWater)
from us_household_income
group by State_name
order by 3 desc;

select State_name,sum(ALand),sum(AWater)
from us_household_income
group by State_name
order by 2 desc
limit 10;

select *
from us_household_income u
join us_household_income_statistics us
on u.id = us.id
where Mean<>0;



select *
from us_household_income u
right join us_household_income_statistics us
on u.id = us.id
where u.id is null;



select u.State_Name,round(avg(Mean),1),round(avg(Median),1)
from us_household_income u
join us_household_income_statistics us
on u.id = us.id
where Mean<>0
group by u.State_Name
order by 3
limit 5;

select u.State_Name,round(avg(Mean),1),round(avg(Median),1)
from us_household_income u
join us_household_income_statistics us
on u.id = us.id
where Mean<>0
group by u.State_Name
order by 3 desc
limit 10;


