# Movie Database Project
Timothy yung</br>
CS333 Introduction to Databases

___________________________________________

## Project Goal
Databases are important to the functionality of everyday life. We use databases everyday whether it be shopping online or simply registering for a class. The goal of this project will be to go through the life cycle of designing a database (from an existing data set) to actually loading and implementing queries to run against it. In addition to creating queries we will also be optimizing them for their performance. In the design we will be creating an ER diagram and also generating schemas for them. For the testing phase, the data needs to be cleaned up since while the formatting is pretty consistent there are inconsistent delimiters used.

## The Data

|Entity|Description|Size|Data type|
|-----|----------------|---|---|
|Movies|List of movies inside the database|321.9 kb| .txt|
|Users| UserID of the database,We do not has access to user data in this particular set | N/A | .txt|
|Genres| All the genres that a movie can have | N/A | .txt|
|Tags| Tags are generated by users and contains data about movies |3.3 MB | .txt|
|Ratings | Ratings made by the user |235.1 MB | .txt|

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


### Find the distribution of the values for attribute "year" of table "movies".

>select year, count(*)</br> 
from movies</br>
group by year;

![Year Table (Click Me)](https://github.com/Timothyyung/DataBaseMovies/blob/master/images/yearcount.csv 'Year Table')

![Alt_Text](https://github.com/Timothyyung/DataBaseMovies/blob/master/images/Histogram%20of%20Count.png 'Year Distribution')

### Find the distribution of the movies across different decades.

>select (year%100)/10, count(*)</br> 
from movies</br> 
group by (year%100)/10;

![Alt_text](https://github.com/Timothyyung/DataBaseMovies/blob/master/images/Count%20vs.%20Decade.png 'Decade Distribution')

### Find the distribution of the genres across the movies.

>select genre, count (*)</br>
from has_genre</br>
group by genre;

![Alt_text](https://github.com/Timothyyung/DataBaseMovies/blob/master/images/Count%20vs.%20Genre.png 'Genre Distribution')


### Find the distribution of the ratings

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

There are no instances of both no tags and no reviews ( we summed up the values in the table and got 10681 )
 

