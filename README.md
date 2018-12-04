# Movie Database Project
 Timothy yung</br>
CS333 Introduction to Databases

___________________________________________

## Project Goal
Databases are important to the functionality of everyday life. We use databases everyday whether it be shopping online or simply registering for a class. The goal of this project will be to go through the life cycle of designing a database (from an existing data set) to actually loading and implementing queries to run against it. In addition to creating queries we will also be optimizing them for their performance. In the design we will be creating an ER diagram and also generating schemas for them. For the testing phase, the data needs to be cleaned up since while the formatting is pretty consistent there are inconsistent delimiters used.

## The Data

|Entity|Description|Size|Data type|Number of Entries
|-----|----------------|---|---|---|
|Movies|List of movies inside the database from the year 1916 to 2010|21.9 kb| .txt|10681|
|Users| UserID of the database,We do not has access to user data in this particular set | N/A | .txt|5711|
|Genres| All the genres that a movie can have | N/A | .txt|19|
|Tags| Tags are generated by users and contains data about movies |3.3 MB | .txt|95580|
|Ratings | Ratings made by the user |235.1 MB | .txt|10000054|

## Entity Relationship Diagram
![Alt_text](https://github.com/Timothyyung/DataBaseMovies/blob/master/images/Movies.jpg 'Movies')

## DataBase Schema

|Entities|Schema|
|-----|----------|
|Movies|MovieId,Title,Year|
|Genre|Genre|
|User|UserId|

|Relationship|Schema|
|-----|----------|
|Ratings|UserId, MoviedId, Rating, Timestamp|
|Tags|UserId, MovieId, Tags, Timestamp|
|Has_Genre| MovieID, Genre|

_____________
# Loading the Database

>Instructions to run my queries:</br>
1) Generate the new files by running the make_files.py script in the old data folder (These files are already in the Data folder)</br>
2) Unzip the ratings file ( the file is too large to import into github normally )
3) Rename the paths in the copy command located in tyung-init.sql to the paths of the files on local computer. tyung-init.sql generates the tables and populates them
4) Run tyung-query.sql to run all the set up queries.

## What is in this github?
### Data Folder:
|File|Description|
|----|-------------|
|Genres.txt| Has the list of all the 19 genres to be loaded into the database|
|mg_relation.csv| Has the list of the movie to genre relation, Contains MovieId and related Genre|
|new_movies.csv| Movies after they have been changed to create a more consistent delimeter ( we used the csv format )|
|ratings.7z| zipped form of ratings so it can be uploaded to github. (unzip before use)|
|tags.csv| Tags after they have been changed to csv format for more a more consistent delimeter|
|users.txt| List all the user IDs|

### Sql Folder:
|File|Description|
|----|-------------|
|tyung-init.sql|Sql code for created and loading the database|
|tyung-query.sql|All of the sql code for testing the database|

### OldText:
|File|Description|
|----|-------------|
|movies.txt|Old movie file with conflicting delimeters|
|tags.txt|Old tags file with conflicting delimeters|
|make_files.py|Script to split and transform the old files into files with csv format|

## List all the tables:
 Schema |   Name    | Type  | Owner |    Size    | Description 
--------|-----------|-------|-------|----------- |--------------
 public | genre     | table | scott | 8192 bytes | 
 public | has_genre | table | scott | 952 kB     | 
 public | movies    | table | scott | 664 kB     | 
 public | ratings   | table | scott | 910 MB     | 
 public | tags      | table | scott | 5296 kB    | 
 public | users     | table | scott | 232 kB     | 
 
 ## Data types of my tables

### Movies
  Column   |  Type   | Collation | Nullable | Default 
-----------|---------|-----------|----------|---------
 movieid   | integer |           | not null | 
 moviename | text    |           |          | 
 year      | integer |           |          | 

Indexes:
    "movies_pkey" PRIMARY KEY, btree (movieid)

### Genres
|Column | Type | Collation | Nullable | Default |
|--------|------|-----------|----------|---------|
| genre  | text |           | not null |         |
 
### Has_Genre
 Column  |         Type          | Collation | Nullable | Default 
---------|-----------------------|-----------|----------|---------
 movieid | integer               |           | not null | 
 genre   | character varying(40) |           | not null | 

Indexes:
    "has_genre_pkey" PRIMARY KEY, btree (movieid, genre)

 ### Tags
   Column   |          Type          | Collation | Nullable | Default 
-----------|------------------------|-----------|----------|---------
 userid    | integer                |           |          | 
 movieid   | integer                |           |          | 
 tags      | character varying(300) |           |          | 
 timestamp | integer                |           |          | 
 
### Ratings
  Column   |       Type       | Collation | Nullable | Default 
-----------|------------------|-----------|----------|---------
 userid    | integer          |           | not null | 
 movieid   | integer          |           | not null | 
 rating    | double precision |           |          | 
 timestamp | integer          |           |          | 

Indexes:
    "ratings_pkey" PRIMARY KEY, btree (userid, movieid)

### User
 Column |  Type   | Collation | Nullable | Default 
--------|---------|-----------|----------|---------
 userid | integer |           | not null | 
 
Indexes:
    "users_pkey" PRIMARY KEY, btree (userid)
    
_________


## Value Counting
| Table | Count | 
|-------|-------|
| Genre | 18 |
| Movies| 10681|
| Ratings| 10000054|
| Tags | 95580|
| Users| 5711|
| Has_Genre| 21564|

______

## Basic query tests:

### Get Ten Movies (select * from movies limit 10)

 |movieid |          moviename          | year| 
|---------|-----------------------------|------|
|       1 | Toy Story                   | 1995|
|       2 | Jumanji                     | 1995|
|       3 | Grumpier Old Men            | 1995|
|       4 | Waiting to Exhale           | 1995|
|       5 | Father of the Bride Part II | 1995|
|       6 | Heat                        | 1995|
|       7 | Sabrina                     | 1995|
|       8 | Tom and Huck                | 1995|
|       9 | Sudden Death                | 1995|
|      10 | GoldenEye                   | 1995|

### Get count of non null values (select count(moviename) from movies)

|count| 
|-------|
 |10681|
 
 _____
## Questions of about the data

### Find any null or invalid values in the dataset

In the script that generated the input for the database I exclude all invalid data types and null values so there would be no null or invalid data points inside my data base. After running the test this is shown to be true.

#### Sample Query:

 >select count(*) </br>
 from ratings </br>
 where movieid IS NULL or userid IS NULL or rating IS NULL or timestamp IS NULL;


### Find the distribution of the values for attribute "year" of table "movies".</br> ![Year Distribution Query Result (Click Me)](https://github.com/Timothyyung/DataBaseMovies/blob/master/images/yearcount.csv 'Year Table')

>select year, count(*)</br> 
from movies</br>
group by year;



![Alt_Text](https://github.com/Timothyyung/DataBaseMovies/blob/master/images/Histogram%20of%20Count.png 'Year Distribution')

### Find the distribution of the movies across different decades.</br> ![Decade Distribution Query Results (Click Me)](https://github.com/Timothyyung/DataBaseMovies/blob/master/images/Decade.csv 'Decade Table')

>select (year%100)/10, count(*)</br> 
from movies</br> 
group by (year%100)/10;

![Alt_text](https://github.com/Timothyyung/DataBaseMovies/blob/master/images/Count%20vs.%20Decade.png 'Decade Distribution')

### Find the distribution of the genres across the movies.</br> ![Genres Query Results (Click Me)](https://github.com/Timothyyung/DataBaseMovies/blob/master/images/genre_distribution.csv 'Genres Query Results' )

>select genre, count (*)</br>
from has_genre</br>
group by genre;

![Alt_text](https://github.com/Timothyyung/DataBaseMovies/blob/master/images/Count%20vs.%20Genre.png 'Genre Distribution')


### Find the distribution of the ratings </br> ![Ratings Query Result (Click Me)](https://github.com/Timothyyung/DataBaseMovies/blob/master/images/rating_dist.csv 'Ratings Table')

>select count(distinct movieid)</br> 
from movies</br> 
where exists (select movieid from ratings group by ratings.movieid having ratings.movieid = movies.movieid) and exists ( select movieid from tags group by tags.movieid having tags.movieid = movies.movieid);

![Alt_text](https://github.com/Timothyyung/DataBaseMovies/blob/master/images/Count%20vs.%20Rating.png 'Rating Distribution')


### Null ratings

|Critria|Number of Rows|Sql code|
|------|--------|-------|
|Ratings no Tags|3080|select count(distinct movieid) from movies natural join ratings where not exists (select movieid from tags group by tags.movieid having tags.movieid = movies.movieid)|
|Tags no Ratings|4 |select count(distinct movieid) from movies natural join tags where not exists (select movieid from ratings group by ratings.movieid having ratings.movieid = movies.movieid)|
|Ratings and Tags| 7597 |select count(distinct movieid)from movies where exists (select movieid from ratings group by ratings.movieid having ratings.movieid = movies.movieid) and exists ( select movieid from tags group by tags.movieid having tags.movieid = movies.movieid);|
|No Ratings or Tags| 0 |select count(distinct movieid)from movies where not exists (select movieid from ratings group by ratings.movieid having ratings.movieid = movies.movieid) and not exists ( select movieid from tags group by tags.movieid having tags.movieid = movies.movieid);|


_________
## Using the Data Base
_______
## General Queries

### Find the most reviewed movie (that is, the movie with the highest number of reviews). Show the movie id, movie title and the number of reviews.
>select movieid, moviename, count(rating)<br>
>from ratings natural join movies<br>
>group by movieid, moviename<br>
>order by count(rating) DESC<br>
>limit 1;<br>

| movieid |  moviename   | count| 
|---------|--------------|-------|
|    296 | Pulp Fiction | 34864 |

### Without Index Plan and Execution time
Planning time: 163.591 ms<br>
Execution time: 28186.149 ms

### With Index on Movieid

Planning time: 0.318 ms<br>
Execution time: 13466.288 ms

Seems like the Index on movieid increased the performance by alot, This is becasue we are grouping by movieid and having a faster search for the movieid would allow us to do the aggrate functions faster.

### Find the highest reviewed movie (movie with the most 5-star reviews). Show the movie id, movie title and the number of reviews.

>select movieid, moviename,count(CASE WHEN rating = 5 THEN 1 END) as fcount<br>
>from ratings natural join movies<br>
>group by movieid, moviename<br>
>order by fcount  DESC<br>
>limit 1;<br>

| movieid |         moviename         | fcount| 
|---------|---------------------------|--------|
|     318 | Shawshank Redemption, The |  16460 |

### Without Index Plan and Execution time
Planning time: 0.552 ms<br>
Execution time: 12586.902 ms

### With Index on Movieid in both ratings and movies tables
Planning time: 1.371 ms<br>
Execution time: 4019.965 ms


### Find the number of movies that are associated with at least 4 different genres.

>select count(*)<br>
>from has_genre natural join movies<br>
>having count(genre) > 4;<br>

| count |
|-------|
| 21564 |


### Find the most popular genre across all movies.

>select genre, count(genre)<br>
>from has_genre natural join movies<br>
>group by genre<br>
>order by count(genre) desc<br>
>limit 1;<br>

| genre | count |
|-------|-------|
| Drama |  5339 |

### Find the genres that are associated with the best reviews (genres of movies that have more high ratings than low ratings). Display the genre, the number of high ratings (>=4.0) and the number of low ratings (< 4.0).
>select genre,highrating,lowrating,(highrating/lowrating) as ratingratio<br>
>from(<br>
>select genre, count(CASE WHEN rating > 4 THEN 1 END) as highrating, count(CASE WHEN rating < 4 THEN 1 END) as lowrating<br>
>from movies natural join has_genre natural join ratings<br>
>group by genre<br>
>) as t1<br>
>order by ratingratio desc;<br>
>limit 1 <br>


 |        genre          | highrating | lowrating | ratingratio| 
 |-----------------------|------------|-----------|------------|
 |Film-Noir              |      49741 |     36917 |           1|

### Without Index Plan and Execution time
Planning time: 0.841 ms<br>
Execution time: 8209.304 ms


### With Index on Movieid in both ratings and movies tables
Planning time: 2.766 ms<br>
Execution time: 7692.015 ms



### Find the genres that are associated with the most recent movies (genres that have more recent movies than old movies). Display the genre, the number of recent movies (>=2000) and the number of old movies (< 2000).

>select genre,recent,old,(recent/old) as rratio<br>
>from( select genre, count(CASE WHEN year >= 2000 THEN 1 END) as recent, count(CASE WHEN year < 2000 THEN 1 END) as old<br>
>  from movies natural join has_genre<br>
>  group by genre)<br>
>order by rratio desc<br>
>limit 1; <br>

|    genre    | recent | old | rratio |
|-------------|--------|-----|--------|
| Documentary |    252 | 230 |      1 |

### Without Index Plan and Execution time
Planning time: 0.664 ms<br>
Execution time: 24.738 ms


### With Index on Movieid in both ratings and movies tables
Planning time: 0.603 ms<br>
Execution time: 24.012 ms


________
## DeBiasing

### Find the difference between a user's rating and the average rating of the movie he has rated.

create table ratings_with_diff as (select ratings.movieid,ratings.userid,ratings.rating,ratings.timestamp,avg.avgrating, (ratings.rating - avg.avgrating) as difrating<br>
from ratings,<br>
(select movieid, (sum(rating)/count(rating)) as avgrating<br>
from ratings group by movieid) as avg<br>
where avg.movieid = ratings.movieid<br>
order by ratings.movieid);<br>

### Update the rating of users and find new difference 

update ratings_with_diff <br>
set rating = ratings_with_diff.avgrating<br>
where abs(difrating) > 3;

### Create New Ratings table

create table ratings_with_diff_2 as (select ratings.movieid,ratings.userid,ratings.rating,ratings.time,avg.avgrating, (ratings.rating - avg.avgrating) as difrating <br>
from ratings_with_diff as ratings,<br>
(select movieid, (sum(rating)/count(rating)) as avgrating<br>
from ratings_with_diff group by movieid) as avg<br>
where avg.movieid = ratings.movieid<br>
order by ratings.movieid);


### Repeat the Update

Repeat the above steps for x iterations 

### Find the average rating for each movie before the de-biasing

select moviename, r1.movieid, r1.avgrating, r2.avgrating, abs(r1.avgrating - r2.avgrating) as brating<br>
from ( select movieid, avg(rating) as avgrating from ratings_with_diff group by movieid) as r1,<br>
(select movieid, avg(rating) as avgrating from ratings_with_diff_2 group by movieid) as r2,<br>
movies<br>
where r1.movieid = r2.movieid and r1.movieid = movies.movieid<br>
order by brating desc<br>
limit 10;<br>


|             title                                     | movieid |    avgrating     |    avgrating     |    bias|         
|-------------------------------------------------------|---------|------------------|------------------|--------|
| Human Condition I  The (Ningen no joken I)            |    8484 |          3.59375 |      4.173828125 | 0.580078125|
| Time Changer                      |    5793 | 1.92857142857143 | 1.48979591836735 | 0.438775510204082|
|Bizarre  Bizarre (Drôle de drame ou L'étrange aventure de Docteur Molyneux)  |    6397|3.5625|3.9453125 | 0.3828125|
| Kid Brother  The                        |    8423 | 3.55882352941176 | 3.91868512110727 | 0.359861591695502|
|Samurai Rebellion (Jôi-uchi: Hairyô tsuma shimatsu)   |   41627 |             4.05 |            4.405 |       0.355|
|Holy Mountain  The (Montaña sagrada  La)       |   26326 |             4.05 |            4.405 |           0.355|
|Cruel Romance  A (Zhestokij Romans)            |    5889 | 3.55555555555556 | 3.89506172839506 | 0.339506172839506|
|Accattone                   |    6599 | 3.64285714285714 | 3.97959183673469 | 0.336734693877551|
|Crowd  The                          |   25766 | 3.71666666666667 | 4.03833333333333 | 0.321666666666666|
|Odd Man Out                            |   25930 | 3.88636363636364 | 4.19421487603306 | 0.307851239669422|



 

