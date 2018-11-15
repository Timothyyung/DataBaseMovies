CREATE TABLE movies(
	movieid integer PRIMARY KEY,
	moviename text,
	year integer
);

CREATE TABLE tags(
	userid integer,
	movieid integer,
	tags text,
	timestamp integer
);

CREATE TABLE genre(
	genre text PRIMARY KEY
);

CREATE TABLE has_genre(
	movieid integer,
	genre text,
	PRIMARY KEY(movieid, genre)
);

CREATE TABLE ratings(
	userid integer,
	movieid integer,
	rating float,
	timestamp integer,
	PRIMARY KEY(userid,movieid)
);

CREATE TABLE users(
	userid integer PRIMARY KEY
);

\COPY ratings FROM '/home/scott/Documents/DataBaseMovies/ratings.txt' with delimiter ':';

\COPY has_genre FROM '/home/scott/Documents/DataBaseMovies/mg_relation.csv' DELIMITERS ',' csv;

\COPY movies FROM '/home/scott/Documents/DataBaseMovies/new_movies.csv' DELIMITERS ',' csv;

\COPY tags FROM '/home/scott/Documents/DataBaseMovies/tags.csv' with delimiter ',';
\COPY genre FROM '/home/scott/Documents/DataBaseMovies/genres.txt';
\COPY users FROM '/home/scott/Documents/DataBaseMovies/users.txt';







