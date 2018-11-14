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
                       List of relations
 Schema |   Name    | Type  | Owner |    Size    | Description 
--------+-----------+-------+-------+------------+-------------
 public | genre     | table | scott | 8192 bytes | 
 public | has_genre | table | scott | 952 kB     | 
 public | movies    | table | scott | 664 kB     | 
 public | ratings   | table | scott | 910 MB     | 
 public | tags      | table | scott | 5296 kB    | 
 public | users     | table | scott | 232 kB     | 


