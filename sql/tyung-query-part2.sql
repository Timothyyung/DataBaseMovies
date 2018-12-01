select * from movies limit 5;
select count(title) from movies;
select * from movies order by year desc limit 5;
select * from movies order by year limit 5;
select count(year) from movies;
select count(year) from movies where year = 0;
select count(year) from movies where year > 1500;
select year, count(*) from movies group by year;
select (year%100)/10, count(*) from movies group by (year%100)/10;
select genre, count (*) from has_genre group by genre;
select rating, count(*) from ratings group by rating;
select count(distinct movieid) from movies where not exists (select movieid from tags group by tags.movieid having tags.movieid = movies.movieid);
select count(distinct movieid) from movies natural join tags where not exists (select movieid from ratings group by ratings.movieid having ratings.movieid = movies.movieid
);
select count(distinct movieid) from movies where exists (select movieid from ratings group by ratings.movieid having ratings.movieid = movies.movieid
) and exists ( select movieid from tags group by tags.movieid having tags.movieid = movies.movieid);
select count(distinct movieid) from movies where not exists (select movieid from ratings group by ratings.movieid having ratings.movieid = movies.movieid
) and not exists ( select movieid from tags group by tags.movieid having tags.movieid = movies.movieid);

