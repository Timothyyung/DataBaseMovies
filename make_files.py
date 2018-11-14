# -*- coding: utf-8 -*-
import csv

if __name__ == "__main__":
    
    Movielist = []
    MovieGenreRelation = []
    TagList = []

    with open('tags.txt' , 'r') as t:
        tlines = t.read().splitlines()

    for line in tlines:
        tags = {}
        parsed = line.split(':')
        tags['UserId'] = parsed[0]
        tags['MovieId'] = parsed[1]
        tags['Timestamp'] = parsed[-1]
        print (parsed)
        if(len(parsed) > 4):
            del parsed[0]
            del parsed[1]
            del parsed[-1]
            tags['Tag'] = ''.join(parsed)
        else:
            tags['Tag'] = parsed[2]
        TagList.append(tags)
    


    
    with open('movies.txt', 'r') as f:
        lines = f.read().splitlines()
    
    for line in lines:
        MovieInfo = {} 
        parsed = line.split(":")
        movieid = parsed[0]
        movieday = parsed[1].split("(")
        GenreInfo = parsed[-1]
        genres = GenreInfo.split("|")
        for info in genres:
            Genre = {}
            Genre['MovieId'] = movieid
            Genre['Genre'] = info
            MovieGenreRelation.append(Genre)
        if(len(parsed) > 3):
            parsed = parsed[1:-1]
            movieinfo = ':'.join(parsed)
            parsed = movieinfo.split("(")
            movieyear = parsed[-1][:-1]          
            moviename = ','.join(parsed[:-1]) 
        elif(len(movieday) > 2):
            movieyear = movieday[-1]
            moviename = "(".join(movieday[:-1])
            movieyear = movieyear[:-1]
        else:
            movieyear = movieday[1]
            moviename = movieday[0]
            movieyear = movieyear[:-1]
        moviename = moviename.strip()
        MovieInfo['MovieId'] = movieid
        MovieInfo['Movie'] = moviename
        MovieInfo['Year'] = movieyear
        Movielist.append(MovieInfo)                 
    
    
    myFields = ["MovieId","Movie","Year"]


    movie_file = open('new_movies.csv' ,'w')
    header = False
    with movie_file:
        writer = csv.DictWriter(movie_file, fieldnames = myFields)
        if(header):
            writer.writeheader()
        for movie in Movielist:
            writer.writerow(movie)
    


    mg_relation = open('mg_relation.csv' , 'w')
    header = False

    myFields = ["MovieId","Genre"]
    
    with mg_relation:
        writer = csv.DictWriter(mg_relation,fieldnames = myFields)
        if(header):
            writer.writeheader()
        for relation in MovieGenreRelation:
            writer.writerow(relation)
    mg_relation.close()

    tags = open('tags.csv','w')
    myFields = ["UserId","MovieId","Tag","Timestamp"]

    with tags:
        writer = csv.DictWriter(tags,fieldnames = myFields)
        for tag in TagList:
            writer.writerow(tag)
    
    
    users = open('users.txt', 'w')
    for i in range(0,5711):
        users.write(str(i) + '\n')

        
