/*This SQl project encompasses the Olympic dataset with Summer Olympics. The dataset consists of three tables which include 
summer_olympics, winter_olympics, and country_dictionary. This analysis just includes summer olympics but I plan to expand it
to include winter olympics as well. 
*/

-- Select all and return count of all the records
SELECT * FROM sql_test.summer_olympics;
select count(*) 
from summer_olympics;


-- Joins the summer_olympics and the country_dictionary table on country and code 
SELECT summer_olympics.*, country_dictionary.country
FROM summer_olympics
inner join country_dictionary ON summer_olympics.country=country_dictionary.code;

-- Number of nations that participated in each of the summer games
Select Year, count(distinct(country)) as country_count
from summer_olympics
group by Year
order by 1; 

-- Returns the count of the number of summer olympic games
select count(*) as tot_games from (
select distinct Year
from summer_olympics) as a;

-- Gives an overall breakdown of the countries gold, silver, and bronze medals of all the summer games
with gold as (
                  select Country, count(Medal) as gold_medal_cnt
                  from summer_olympics where Medal = 'Gold'
                  group by Country ),

silver as (
               select Country,  count(Medal) as silver_medal_cnt from summer_olympics
               where Medal = 'Silver'
               group by Country),

bronze as (
              select Country,  count(Medal) as bronze_medal_cnt from summer_olympics
              where Medal = 'Bronze'
              group by Country)
select a.Country, a.gold_medal_cnt as gold_count, b.silver_medal_cnt as silver_cnt, c.bronze_medal_cnt as bronze_cnt
from gold as a
inner join silver as b
on a.Country = b.Country 
join bronze as c
on a.Country = c.Country
order by 2 desc;


-- Retrieves the sports with the most male participants in the 2012 summer games
select Sport, count(*) as male_pop_sports
from summer_olympics
where Gender = "Men" and Year = "2012"
group by Sport
order by 2 desc
limit 4;

-- Retrieves the sports with the most female participants in the 2012 summer games
select Sport, count(*) as female_pop_sports
from summer_olympics
where Gender = "Women" and Year = "2012"
group by Sport
order by 2 desc
limit 4;

-- Retrieve the top 3 athletes with the most gold medals in the 2012 summer games
select Year, Athlete, count(Medal) as gold_medal_count
from summer_olympics
where Medal = "Gold" and Year = "2012"
group by Athlete
Order by 3 desc
limit 3;

-- The below query determines the year in which India had the highest number of medals
select Year, Country, MAX(total_medal_count) as max_medal_count
from (
select Year, Country, count(Medal) as total_medal_count
from summer_olympics
where Country = "Ind" 
group by Year, Country
) as medal_counts group by Year, Country
order by max_medal_count DESC
limit 1;
 
--  Sorts the number of gold medals won by India descending order 
select Year, Country, count(Medal) as gold_medal_count
from summer_olympics
where Country = "Ind" and Medal = "Gold"
Group by Year
order by gold_medal_count desc;


-- Determines the Sports India won the most medals in descending order
select  distinct Sport, count(Medal) as tot_medal_cnt 
from summer_olympics
where Country = 'Ind' 
group by Sport
order by tot_medal_cnt desc
limit 3;

-- Determines the Sports India won the most gold medals in descending order
select distinct Sport, count(Medal) as tot_gold_cnt 
from summer_olympics
where Country = 'Ind' and Medal = "Gold"
group by Sport, Medal
order by tot_gold_cnt desc;

 