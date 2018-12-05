select movieid, title, count(rating) 
from ratings natural join movies 
group by movieid, title 
order by count(rating) DESC 
limit 1;

select movieid, title,count(CASE WHEN rating = 5 THEN 1 END) as fcount
from ratings natural join movies
group by movieid, title
order by fcount  DESC
limit 1;


select count(*)
from (select movieid 
from has_genre natural join movies
group by movieid
having count(genre) >= 4) as t1;


select genre, count(genre)
from has_genre natural join movies
group by genre
order by count(genre) desc
limit 1;


select genre,highrating,lowrating,(highrating/lowrating) as ratingratio
from(
select genre, count(CASE WHEN rating >= 4 THEN 1 END) as highrating, count(CASE WHEN rating < 4 THEN 1 END) as lowrating                             
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
) as t1
order by rratio desc
limit 1;


create table ratings_with_diff as (select ratings.movieid,ratings.userid,ratings.rating,ratings.time,avg.avgrating, (ratings.rating - avg.avgrating) as difrating
from ratings,
(select movieid, (sum(rating)/count(rating)) as avgrating
from ratings group by movieid) as avg
where avg.movieid = ratings.movieid
order by ratings.movieid);


select userid, count(userid)
from ratings_with_diff
where abs(difrating) > 3
group by userid
order by count(userid) desc
limit 10;

update ratings_with_diff 
set rating = ratings_with_diff.avgrating
where abs(difrating) > 3;

create table ratings_with_diff_2 as (select ratings.movieid,ratings.userid,ratings.rating,ratings.time,avg.avgrating, (ratings.rating - avg.avgrating) as difrating
from ratings_with_diff as ratings,
(select movieid, (sum(rating)/count(rating)) as avgrating
from ratings_with_diff group by movieid) as avg
where avg.movieid = ratings.movieid
order by ratings.movieid);

update ratings_with_diff_2 
set rating = ratings_with_diff_2.avgrating
where abs(difrating) > 3;

create table ratings_with_diff_3 as (select ratings.movieid,ratings.userid,ratings.rating,ratings.time,avg.avgrating, (ratings.rating - avg.avgrating) as difrating
from ratings_with_diff_2 as ratings,
(select movieid, (sum(rating)/count(rating)) as avgrating
from ratings_with_diff_2 group by movieid) as avg
where avg.movieid = ratings.movieid
order by ratings.movieid);

select title, r1.movieid, r1.avgrating, r2.avgrating, abs(r1.avgrating - r2.avgrating) as bias
from ( select movieid, avg(rating) as avgrating from ratings group by movieid) as r1,
(select movieid, avg(rating) as avgrating from ratings_with_diff_3 group by movieid) as r2,
movies
where r1.movieid = r2.movieid and r1.movieid = movies.movieid
order by bias desc
limit 10;



