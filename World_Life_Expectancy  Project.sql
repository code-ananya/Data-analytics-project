SELECT * 
FROM world_life_expectancy;

select Country,Year,concat(Country,Year),count(concat(Country,Year))
from world_life_expectancy
group by Country,Year,concat(Country,Year)
having count(concat(Country,Year))>1;




select*
from (
select ROW_ID,
concat(Country,Year),
row_number()over(partition by concat(Country,Year)order by concat(Country,Year)) as row_num
from world_life_expectancy) as row_table
where row_num >1;

delete from world_life_expectancy
where 
      Row_ID IN (
      select Row_ID
from (
select ROW_ID,
concat(Country,Year),
row_number()over(partition by concat(Country,Year)order by concat(Country,Year)) as row_num
from world_life_expectancy) as row_table
where row_num >1
)
;

SELECT *
FROM world_life_expectancy
	where Status = '';
    
    select distinct(Country)
    from world_life_expectancy
    where status = 'Developing';
    
    update world_life_expectancy
    set status = 'Developing'
    where country in ( select distinct(Country)
                        from world_life_expectancy
                              where status = 'Developing');


update world_life_expectancy t1
join world_life_expectancy t2
on t1.Country=t2.Country
set t1.Status = 'Developing'
where  t1.Status = ''
and t2.Status <> ''
and t2.Status ='Developing' ;

update world_life_expectancy t1
join world_life_expectancy t2
on t1.Country=t2.Country
set t1.Status = 'Developed'
where  t1.Status = ''
and t2.Status <> ''
and t2.Status ='Developed' ;

SELECT *
FROM world_life_expectancy
where `Life expectancy` = '';

SELECT t1.Country,t1.Year, t1.`Life expectancy`,t2.Country,t2.Year, t2.`Life expectancy`,t3.Country,t3.Year, t3.`Life expectancy` ,
round((t2.`Life expectancy`+t3.`Life expectancy`)/2,1)
FROM world_life_expectancy t1
join world_life_expectancy t2
on t1.Country = t2.Country
and t1.Year = t2.Year - 1
join world_life_expectancy t3
on t1.Country = t3.Country
and t1.Year = t3.Year + 1
where t1.`Life expectancy` =''
;

#where `Life expectancy` = '';

update world_life_expectancy t1 

join world_life_expectancy t2
on t1.Country = t2.Country
and t1.Year = t2.Year - 1
join world_life_expectancy t3
on t1.Country = t3.Country
and t1.Year = t3.Year + 1
set t1.`Life expectancy`= round((t2.`Life expectancy`+t3.`Life expectancy`)/2,1)
where t1.`Life expectancy` =''
;


select Country ,min(`Life expectancy`),max(`Life expectancy`),round(max(`Life expectancy`)-min(`Life expectancy`),1)as life_increase_15_Years
from world_life_expectancy
group by  Country 
having min(`Life expectancy`)<>0
and max(`Life expectancy`)<>0
order by  life_increase_15_Years asc;


select Country, round(avg(`Life expectancy`),1) as Life_exp, round(avg(GDP),1)as GDP
from world_life_expectancy
group by Country
having Life_exp>0
and GDP>0
order by GDP DESC;

select Country, round(avg(`Life expectancy`),1) as Life_exp, round(avg(GDP),1)as GDP
from world_life_expectancy
group by Country
having Life_exp>0
and GDP>0
order by GDP DESC;
 
select *
FROM world_life_expectancy
ORDER BY  GDP DESC;

select 
sum(case when GDP>=1500 then 1 else 0  end)as High_GDP_Count,
avg(case when GDP>=1500 then `Life expectancy` else null  end)as high_gdp_life,
sum(case when GDP<=1500 then 1 else 0  end)as low_GDP_count,
avg(case when GDP<=1500 then `Life expectancy` else null  end)as low_gdp_life
 From world_life_expectancy;


select *
FROM world_life_expectancy;

select status,round(avg(`Life expectancy`),1)
FROM world_life_expectancy
group by status;

select status,count(distinct country),round(avg(`Life expectancy`),1)
FROM world_life_expectancy
group by status;

select Country, round(avg(`Life expectancy`),1) as Life_exp, round(avg(BMI),1)as BMI
from world_life_expectancy
group by Country
having Life_exp>0
and BMI>0
order by BMI asc;

select Country,
Year,
`Life expectancy`,
`Adult Mortality`,
sum(`Adult Mortality`) over (partition by Country order by Year) as rolling_total
from world_life_expectancy
where country like'%united%';





