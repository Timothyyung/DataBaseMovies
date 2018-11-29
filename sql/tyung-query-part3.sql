select movieid, moviename, count(rating) 
from ratings natural join movies 
group by movieid, moviename 
order by count(rating) DESC 
limit 1;

select movieid, moviename,count(rating), (sum(rating)/count(rating)) as avgrating
from ratings natural join movies
group by movieid, moviename
order by avgrating  DESC
limit 1;

select movieid, moviename,count(CASE WHEN rating = 5 THEN 1 END) as fcount
from ratings natural join movies
group by movieid, moviename
order by fcount  DESC
limit 1;


select count(*)
from has_genre natural join movies
having count(genre) > 4;

select genre, count(genre)
from has_genre natural join movies
group by genre
order by count(genre) desc
limit 1;


select genre,highrating,lowrating,(highrating/lowrating) as ratingratio
from(
select genre, count(CASE WHEN rating > 4 THEN 1 END) as highrating, count(CASE WHEN rating < 4 THEN 1 END) as lowrating                             
from movies natural join has_genre natural join ratings
group by genre
) as t1
order by ratingratio desc
limit 1;

select genre,recent,old,(recent/old) as rratio
from(
select genre, count(CASE WHEN year >= 2000 THEN 1 END) as recent, count(CASE WHEN year < 2000 THEN 1 END) as old
from movies natural join has_genre
group by genre
)
order by rratio desc
limit 1;


create table ratings_with_diff as (select ratings.movieid,ratings.userid,ratings.rating,ratings.timestamp,avg.avgrating, (ratings.rating - avg.avgrating) as difrating
from ratings,
(select movieid, (sum(rating)/count(rating)) as avgrating
from ratings group by movieid) as avg
where avg.movieid = ratings.movieid
order by ratings.movieid);

create table ratings_with_diff_2 as (select ratings.movieid,ratings.userid,ratings.rating,ratings.timestamp,avg.avgrating, (ratings.rating - avg.avgrating) as difrating
from ratings_with_diff as ratings,
(select movieid, (sum(rating)/count(rating)) as avgrating
from ratings group by movieid) as avg
where avg.movieid = ratings.movieid and (difrating < 3 and difrating > -3)
order by ratings.movieid);

create table ratings_with_diff_3 as (select ratings.movieid,ratings.userid,ratings.rating,ratings.timestamp,avg.avgrating, (ratings.rating - avg.avgrating) as difrating
from ratings_with_diff_2 as ratings,
(select movieid, (sum(rating)/count(rating)) as avgrating
from ratings group by movieid) as avg
where avg.movieid = ratings.movieid and (difrating < 3 and difrating > -3)
order by ratings.movieid);

select moviename, r1.movieid, r1.avgrating, r2.avgrating, abs(r1.avgrating - r2.avgrating) as brating
from ( select movieid, avg(rating) as avgrating from ratings_with_diff group by movieid) as r1,
(select movieid, avg(rating) as avgrating from ratings_with_diff_2 group by movieid) as r2,
movies
where r1.movieid = r2.movieid and r1.movieid = movies.movieid
order by brating desc
limit 10;




