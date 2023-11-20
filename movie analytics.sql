select * from country; select * from department; select * from gender; select * from genre;
select * from keyword; select * from language; select * from language_role; select * from movie;
select * from movie_cast; select * from movie_company; select * from movie_crew;
select * from movie_genres; select * from movie_keywords; select * from movie languages;
select * from person; select * from production_company; select * from production_country;

-- QUESTIONS AND ANSWERS

-- 1. How much did movies cost per minute?;

select title, budget as "Cost of Movie", runtime as "No of Mins", 
round((budget/runtime),2) as "Average Budget Per Movie" from movie;

#2.	What is the top-5 movies in terms of budget?

select movie_id, title, budget from movie group by 3 order by 3 desc limit 5;

#3.	In terms of release date, how old is every single movie? Show the top-10 Youngest movies

select movie_id, title, release_date from movie group by 3 order by 3 desc limit 10;

#4.	In which years did the producer make a movie? regardless of the number of movies.

select distinct year(release_date) as "Release Date" from movie where year(release_date) <> 0 
order by release_date;

#5. Which movies cost less than 50,000 and what were their genres? Just top-10

select m.movie_id, m.title, m.budget, mg.genre_id, g.genre_name as "Genre" from movie m 
inner join movie_genres mg using (movie_id) left join genre
g on mg.genre_id = g.genre_id where m.budget < 50000 group by m.budget 
order by m.budget desc limit 10;

# 6. which director did make the most popular movie in English and French language?

SELECT language.language_name, person.person_name, COUNT(*) as movie_count, 
MAX(movie.popularity) as max_popularity FROM movie join movie_crew on movie.movie_id = movie_crew.movie_id
join person on movie_crew.person_id = person.person_id
join movie_languages on movie.movie_id = movie_languages.movie_id
join language on movie_languages.language_id = language.language_id
GROUP BY language.language_name, person.person_name
having language.language_name IN ('English','Latin') 
limit 1;

#7. Make a list of actors(actress) who played after the year 2010.

select m.movie_id, m.title, mc.person_id, p.person_name, year(m.release_date) as "release date" 
from movie m inner join movie_cast mc using (movie_id) inner join person p on mc.person_id = p.person_id
where year(m.release_date) > 2010 group by p.person_name order by year(m.release_date);

#8. How many horror movies did their budget exceed the average budget of all movies?

select m.movie_id, m.title, m.budget, mg.genre_id, g.genre_name as "Genre" from movie m inner join movie_genres mg 
using (movie_id) left join genre g on mg.genre_id = g.genre_id where g.genre_name = "Horror" and 
m.budget > (select avg(m.budget) from movie m) group by m.budget order by m.budget;

# 9.What is the bottom-10 popular movies, and which company made them?

select m.movie_id, m.title, m.popularity, mc.company_id, pc.company_name from movie m 
inner join movie_company mc using (movie_id) inner join production_company pc 
on mc.company_id = pc.company_id group by m.popularity order by m.popularity limit 10; 

#10. Which movie companies invested the budget between 150K to 200K and for which movie?

select  pc.company_name, m.movie_id, m.title, mc.company_id, m.budget from movie m 
inner join movie_company mc using (movie_id) inner join production_company pc 
on mc.company_id = pc.company_id where m.budget between 150000 and 200000 group by pc.company_name
order by m.budget desc;