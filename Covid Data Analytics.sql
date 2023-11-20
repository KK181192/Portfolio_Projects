SELECT * FROM `sql covid data 2`;

-- Shows likelihood of a person would be died in case of she has been infected?

select location, sum(dead) as "Total Deaths", sum(infected) as "Total Infections",
round(concat(sum(dead)*100/sum(infected),"%"),2) as "Death Per Infection Percentage" from `sql covid data 2` 
group by location;

-- Shows likelihood of a person would be died in case of she has been vaccinated?

select location, sum(dead) as "Total Deaths", sum(vaccinated) as "Total Vaccinations",
round(concat(sum(dead)*100/sum(vaccinated),"%"),2) as "Death Per Vaccination Percentage" from `sql covid data 2` 
group by location;

-- Shows likelihood of a person would be infected in case of she has been vaccinated?

select location, sum(infected) as "Total Infections", sum(vaccinated) as "Total Vaccinations",
round(concat(sum(infected)*100/sum(vaccinated),"%"),2) as "Infection Per Vaccination Percentage" from `sql covid data 2` 
group by location;

-- Which country does have the highest death rate compare to population?

select location, sum(dead) as "Total Deaths", max(population) as "Population",
round(concat(sum(dead)*100/max(population),"%"),2) as "Death Per Population Percentage" from `sql covid data 2` 
group by location;