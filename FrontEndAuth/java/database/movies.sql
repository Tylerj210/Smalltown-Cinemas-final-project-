BEGIN TRANSACTION;

DROP TABLE IF EXISTS users                                      cascade;
DROP TABLE IF EXISTS movies                                     cascade;    
DROP TABLE IF EXISTS movie_actor                                cascade;
DROP TABLE IF EXISTS actors                                     cascade;
DROP TABLE IF EXISTS showtime                                   cascade;
DROP TABLE IF EXISTS genre_movie                                cascade;
DROP TABLE IF EXISTS genre                                      cascade;
DROP TABLE IF EXISTS tickets                                    cascade;
DROP TABLE IF EXISTS theater                                    cascade;
DROP TABLE IF EXISTS seats                                      cascade;
DROP TABLE IF EXISTS reservations                               cascade;




CREATE TABLE users (
  id serial NOT NULL,
  username varchar(255) NOT NULL UNIQUE,                -- Username
  password varchar(32) NOT NULL,                        -- Password
  salt varchar(256) NOT NULL,                           -- Password Salt
  role varchar(255) NOT NULL default('user'),
  CONSTRAINT pk_users_id PRIMARY KEY (id)
);

CREATE TABLE movies (
  movie_id serial NOT NULL,
  title varchar(100) NOT NULL,
  releaseDate DATE NOT NULL,             -- date movie was released in YYYY/DD/MM
  rating varchar(5) DEFAULT 'G',         -- rating of movie 
  runtime INTEGER NOT NULL,              -- length of movie in minutes
  director varchar(255) NOT NULL,        -- director of the movie
  synopsis varchar(600) NOT NULL,        -- short summary of the movie
  mainImage varchar NOT NULL,       -- ability to access movie poster
  trailerLink varchar NOT NULL,     -- ability to access movie trailer
  officialSite varchar NOT NULL     -- ability to access the official site for the movie
  CONSTRAINT ck_film_rating CHECK (rating IN ('G', 'PG', 'PG-13', 'R', 'NC-17', 'NR')),
  CONSTRAINT pk_movies_movie_id PRIMARY KEY (movie_id)

);

CREATE TABLE movie_actor (
     actor_id INTEGER NOT NULL,
     movie_id INTEGER NOT NULL,
     CONSTRAINT pk_movie_actor_actor_id_movie_id PRIMARY KEY (actor_id, movie_id)
);

CREATE TABLE actors(
     actor_id serial NOT NULL,
     firstName varchar(50) NOT NULL,
     lastName varchar(50) NOT NULL,
     CONSTRAINT pk_actors_actor_id PRIMARY KEY (actor_id)

);

CREATE TABLE showtime(
        showtime_id serial NOT NULL,
        movie_id INTEGER NOT NULL,
        theater_id INTEGER NOT NULL,
        dateTime TIMESTAMP NOT NULL,
        price DECIMAL,
        CONSTRAINT pk_showtime_showtime_id PRIMARY KEY (showtime_id)
);

CREATE TABLE theater(
        theater_id serial NOT NULL,
        totalSeats INTEGER NOT NULL,
        CONSTRAINT pk_theater_theater_id PRIMARY KEY (theater_id)
);

CREATE TABLE seats(
        seat_id serial NOT NULL,
        theater_id INTEGER NOT NULL,
        seatNumber INTEGER NOT NULL,
        CONSTRAINT pk_seats_seat_id PRIMARY KEY (seat_id)
);

CREATE TABLE genre_movie(
        genre_id INTEGER NOT NULL,
        movie_id INTEGER NOT NULL,
        CONSTRAINT pk_genre_movie_genre_id_movie_id PRIMARY KEY (genre_id, movie_id)
);

CREATE TABLE genre(
        genre_id serial NOT NULL,
        genre varchar(30) NOT NULL,
        CONSTRAINT pk_genre_genre_id PRIMARY KEY (genre_id)
);

CREATE TABLE tickets(
        ticket_id serial NOT NULL,
        reservation_id INTEGER NOT NULL,
        seat_id INTEGER NOT NULL,
        price decimal,
        CONSTRAINT pk_tickets_ticket_id PRIMARY KEY (ticket_id)
);

CREATE TABLE reservations(
        reservation_id serial NOT NULL,
        bookingTime TIMESTAMP NOT NULL,
        finalized BOOLEAN,
        id INTEGER NOT NULL,
        showtime_id INTEGER NOT NULL,
        confirmationNumber INTEGER,
        CONSTRAINT pk_reservations_reservation_id PRIMARY KEY (reservation_id)
);

-- INSERTIONS INTO OUR MOVIES TABLE
INSERT INTO movies(movie_id, title, releaseDate, rating, runtime, director, synopsis, mainImage, trailerLink, officialSite) VALUES (1, 'Avengers: Endgame', '04/26/2019'::DATE, 'PG-13', 182,'Anthony Russo', 'Adrift in space with no food or water, Tony Stark sends a message to Pepper Potts as his oxygen supply starts to dwindle. Meanwhile, the remaining Avengers -- Thor, Black Widow, Captain America and Bruce Banner -- must figure out a way to bring back their vanquished allies for an epic showdown with Thanos -- the evil demigod who decimated the planet and the universe.', 'https://upload.wikimedia.org/wikipedia/en/0/0d/Avengers_Endgame_poster.jpg', 'https://www.youtube.com/embed/TcMBFSGVi1c', 'https://www.marvel.com/movies/avengers-endgame');
INSERT INTO movies(movie_id, title, releaseDate, rating, runtime, director, synopsis, mainImage, trailerLink, officialSite) VALUES (2, 'Us', '03/22/2019'::DATE, 'R', 116,'Jordan Peele', 'Accompanied by her husband, son and daughter, Adelaide Wilson returns to the beachfront home where she grew up as a child. Haunted by a traumatic experience from the past, Adelaide grows increasingly concerned that something bad is going to happen. Her worst fears soon become a reality when four masked strangers descend upon the house, forcing the Wilsons into a fight for survival. When the masks come off, the family is horrified to learn that each attacker takes the appearance of one of them.', 'https://upload.wikimedia.org/wikipedia/en/0/00/Us_%282019%29_theatrical_poster.png', 'https://www.youtube.com/embed/1tzFRIQfwXg', 'https://www.usmovie.com/');
INSERT INTO movies(movie_id, title, releaseDate, rating, runtime, director, synopsis, mainImage, trailerLink, officialSite) VALUES (3, 'Shazam!', '04/15/2019'::DATE, 'PG-13', 132,'David Sandberg', 'We all have a superhero inside of us -- it just takes a bit of magic to bring it out. In 14-year-old Billy Batson''s case, all he needs to do is shout out one word to transform into the adult superhero Shazam. Still a kid at heart, Shazam revels in the new version of himself by doing what any other teen would do -- have fun while testing out his newfound powers. But he''ll need to master them quickly before the evil Dr. Thaddeus Sivana can get his hands on Shazam''s magical abilities.', 'https://assets.www.warnerbros.com/sites/default/files/movies/media/browser/Shazam_2000x3000.png', 'https://www.youtube.com/embed/go6GEIrcvFY', 'https://www.shazammovie.com/');
INSERT INTO movies(movie_id, title, releaseDate, rating, runtime, director, synopsis, mainImage, trailerLink, officialSite) VALUES (4, 'Pet Sematary', '04/05/2019'::DATE, 'R', 100,'Kevin Kolsch', 'Doctor Louis Creed (Dale Midkiff) moves his family to Maine, where he meets a friendly local named Jud Crandall (Fred Gwynne). After the Creeds'' cat is accidentally killed, Crandall advises Louis to bury it in the ground near the old pet cemetery. The cat returns to life, its personality changed for the worse. When Louis'' son, Gage (Miko Hughes), dies tragically, Louis decides to bury the boy''s body in the same ground despite the warnings of Crandall and Louis'' visions of a deceased patient.', 'https://m.media-amazon.com/images/M/MV5BMjUyNjg1ODIwMl5BMl5BanBnXkFtZTgwNjMyOTYzNzM@._V1_.jpg', 'https://www.youtube.com/embed/zK0LNzU2TQI', 'https://www.imdb.com/title/tt0837563/');
INSERT INTO movies(movie_id, title, releaseDate, rating, runtime, director, synopsis, mainImage, trailerLink, officialSite) VALUES (5, 'Dumbo', '03/29/2019'::DATE, 'PG', 112,'Tim Burton', 'A young elephant, whose oversized ears enable him to fly, helps save a struggling circus, but when the circus plans a new venture, Dumbo and his friends discover dark secrets beneath its shiny veneer. Holt was once a circus star, but he went off to war and when he returned it had terribly altered him.', 'https://pbs.twimg.com/media/DxF76amVsAUr5J-.jpg', 'https://www.youtube.com/watch?v=7NiYVoqBt-8', 'https://movies.disney.com/dumbo-2019');
INSERT INTO movies(movie_id, title, releaseDate, rating, runtime, director, synopsis, mainImage, trailerLink, officialSite) VALUES (6, 'Hellboy', '04/12/2019'::DATE, 'R', 121,'Neil Marshall', 'At the end of World War II, the Nazis attempt to open a portal to a paranormal dimension in order to defeat the Allies, but are only able to summon a baby demon who is rescued by Allied forces and dubbed "Hellboy" (Ron Perlman). Sixty years later, Hellboy serves as an agent in the Bureau of Paranormal Research and Defense, where he, aided by Abe Sapien (Doug Jones), a merman with psychic powers, and Liz Sherman (Selma Blair), a woman with pyrokinesis, protects America against dark forces.', 'data:image/jpeg;base64,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', 'https://www.youtube.com/embed/ZsBO4b3tyZg', 'https://www.hellboy.movie/');
INSERT INTO movies(movie_id, title, releaseDate, rating, runtime, director, synopsis, mainImage, trailerLink, officialSite) VALUES (7, 'Captain Marvel', '03/08/2019'::DATE, 'PG-13', 120,'Anna Boden','Captain Marvel is an extraterrestrial Kree warrior who finds herself caught in the middle of an intergalactic battle between her people and the Skrulls. Living on Earth in 1995, she keeps having recurring memories of another life as U.S. Air Force pilot Carol Danvers. With help from Nick Fury, Captain Marvel tries to uncover the secrets of her past while harnessing her special superpowers to end the war with the evil Skrulls.', 'https://upload.wikimedia.org/wikipedia/en/8/85/Captain_Marvel_poster.jpg', 'https://www.youtube.com/embed/Z1BCujX3pw8', 'https://movies.disney.com/captain-marvel');


--INSERTIONS INTO OUR ACTORS TABLE
INSERT INTO actors(actor_id, firstName, lastName) VALUES (1, 'Robert', 'Downey Jr.');
INSERT INTO actors(actor_id, firstName, lastName) VALUES (2, 'Brie', 'Larson');
INSERT INTO actors(actor_id, firstName, lastName) VALUES (3, 'Lupita', 'Nyongo''o');
INSERT INTO actors(actor_id, firstName, lastName) VALUES (4, 'Winston', 'Duke');
INSERT INTO actors(actor_id, firstName, lastName) VALUES (5, 'Zachary', 'Levi');
INSERT INTO actors(actor_id, firstName, lastName) VALUES (6, 'Mark', 'Strong');
INSERT INTO actors(actor_id, firstName, lastName) VALUES (7, 'Jason', 'Clarke');
INSERT INTO actors(actor_id, firstName, lastName) VALUES (8, 'Amy', 'Seimetz');
INSERT INTO actors(actor_id, firstName, lastName) VALUES (9, 'Eva', 'Green');
INSERT INTO actors(actor_id, firstName, lastName) VALUES (10, 'Danny', 'DeVito');
INSERT INTO actors(actor_id, firstName, lastName) VALUES (11, 'Colin', 'Farrell');
INSERT INTO actors(actor_id, firstName, lastName) VALUES (12, 'David', 'Harbour');
INSERT INTO actors(actor_id, firstName, lastName) VALUES (13, 'Milla', 'Jovovich');
INSERT INTO actors(actor_id, firstName, lastName) VALUES (14, 'Ian', 'McShane');
INSERT INTO actors(actor_id, firstName, lastName) VALUES (15, 'Samuel L.', 'Jackson');
INSERT INTO actors(actor_id, firstName, lastName) VALUES (16, 'Ben', 'Mendelsohn');



--INSERTIONS INTO OUR MOVIE_ACTOR TABLE
INSERT INTO movie_actor(actor_id, movie_id) VALUES (1,1);
INSERT INTO movie_actor(actor_id, movie_id) VALUES (2,1);
INSERT INTO movie_actor(actor_id, movie_id) VALUES (2,7);
INSERT INTO movie_actor(actor_id, movie_id) VALUES (3,2);
INSERT INTO movie_actor(actor_id, movie_id) VALUES (4,2);
INSERT INTO movie_actor(actor_id, movie_id) VALUES (5,3);
INSERT INTO movie_actor(actor_id, movie_id) VALUES (6,3);
INSERT INTO movie_actor(actor_id, movie_id) VALUES (7,4);
INSERT INTO movie_actor(actor_id, movie_id) VALUES (8,4);
INSERT INTO movie_actor(actor_id, movie_id) VALUES (9,5);
INSERT INTO movie_actor(actor_id, movie_id) VALUES (10,5);
INSERT INTO movie_actor(actor_id, movie_id) VALUES (11,5);
INSERT INTO movie_actor(actor_id, movie_id) VALUES (12,6);
INSERT INTO movie_actor(actor_id, movie_id) VALUES (13,6);
INSERT INTO movie_actor(actor_id, movie_id) VALUES (14,6);
INSERT INTO movie_actor(actor_id, movie_id) VALUES (15,7);
INSERT INTO movie_actor(actor_id, movie_id) VALUES (16,7);



-- Password for this user is 'greatwall'
INSERT INTO users ("username", "password", "salt", "role") VALUES
(
    'user',
    'FjZDm+sndmsdEDwNtfr6NA==',
    'kidcasB0te7i0jK0fmRIGHSm0mYhdLTaiGkEAiEvLp7dAEHWnuT8n/5bd2V/mqjstQ198iImm1xCmEFu+BHyOz1Mf7vm4LILcrr17y7Ws40Xyx4FOCt8jD03G+jEafpuVJnPiDmaZQXJEpEfekGOvhKGOCtBnT5uatjKEuVWuDA=',
    'user'
);


--INSERTIONS INTO OUR GENRE TABLE
INSERT INTO genre(genre_id, genre) VALUES (1, 'Action');
INSERT INTO genre(genre_id, genre) VALUES (2, 'Horror');
INSERT INTO genre(genre_id, genre) VALUES (3, 'Fantasy');
INSERT INTO genre(genre_id, genre) VALUES (4, 'Science Fiction');
INSERT INTO genre(genre_id, genre) VALUES (5, 'Thriller');
INSERT INTO genre(genre_id, genre) VALUES (6, 'Adventure');

--INSERTIONS INTO OUR GENRE_MOVIE TABLE
INSERT INTO genre_movie(genre_id, movie_id) VALUES (1,1);
INSERT INTO genre_movie(genre_id, movie_id) VALUES (2,2);
INSERT INTO genre_movie(genre_id, movie_id) VALUES (3,3);
INSERT INTO genre_movie(genre_id, movie_id) VALUES (4,3);
INSERT INTO genre_movie(genre_id, movie_id) VALUES (5,4);
INSERT INTO genre_movie(genre_id, movie_id) VALUES (2,4);
INSERT INTO genre_movie(genre_id, movie_id) VALUES (3,5);
INSERT INTO genre_movie(genre_id, movie_id) VALUES (6,5);
INSERT INTO genre_movie(genre_id, movie_id) VALUES (3,6);
INSERT INTO genre_movie(genre_id, movie_id) VALUES (4,6);
INSERT INTO genre_movie(genre_id, movie_id) VALUES (3,7);
INSERT INTO genre_movie(genre_id, movie_id) VALUES (4,7);

--INSERTIONS INTO OUR SHOWTIME TABLE
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (1, 1, 1, 'Apr 11 2019 10:00AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (2, 1, 1, 'Apr 11 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (3, 1, 1, 'Apr 11 2019 5:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (4, 1, 1, 'Apr 11 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (5, 2, 2, 'Apr 11 2019 10:45AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (6, 2, 2, 'Apr 11 2019 2:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (7, 2, 2, 'Apr 11 2019 5:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (8, 2, 2, 'Apr 11 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (9, 3, 3, 'Apr 11 2019 12:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (10, 3, 3, 'Apr 11 2019 3:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (11, 3, 3, 'Apr 11 2019 6:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (12, 4, 4, 'Apr 11 2019 12:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (13, 4, 4, 'Apr 11 2019 3:45PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (14, 4, 4, 'Apr 11 2019 6:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (15, 5, 5, 'Apr 11 2019 1:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (16, 5, 5, 'Apr 11 2019 4:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (17, 5, 5, 'Apr 11 2019 7:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (18, 6, 6, 'Apr 11 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (19, 6, 6, 'Apr 11 2019 4:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (20, 6, 6, 'Apr 11 2019 6:45PM');

INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (21, 1, 1, 'Apr 12 2019 10:00AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (22, 1, 1, 'Apr 12 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (23, 1, 1, 'Apr 12 2019 5:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (24, 1, 1, 'Apr 12 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (25, 2, 2, 'Apr 12 2019 10:45AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (26, 2, 2, 'Apr 12 2019 2:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (27, 2, 2, 'Apr 12 2019 5:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (28, 2, 2, 'Apr 12 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (29, 3, 3, 'Apr 12 2019 12:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (30, 3, 3, 'Apr 12 2019 3:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (31, 3, 3, 'Apr 12 2019 6:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (32, 4, 4, 'Apr 12 2019 12:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (33, 4, 4, 'Apr 12 2019 3:45PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (34, 4, 4, 'Apr 12 2019 6:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (35, 5, 5, 'Apr 12 2019 1:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (36, 5, 5, 'Apr 12 2019 4:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (37, 5, 5, 'Apr 12 2019 7:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (38, 6, 6, 'Apr 12 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (39, 6, 6, 'Apr 12 2019 4:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (40, 6, 6, 'Apr 12 2019 6:45PM');

INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (41, 1, 1, 'Apr 13 2019 10:00AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (42, 1, 1, 'Apr 13 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (43, 1, 1, 'Apr 13 2019 5:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (44, 1, 1, 'Apr 13 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (45, 2, 2, 'Apr 13 2019 10:45AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (46, 2, 2, 'Apr 13 2019 2:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (47, 2, 2, 'Apr 13 2019 5:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (48, 2, 2, 'Apr 13 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (49, 3, 3, 'Apr 13 2019 12:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (50, 3, 3, 'Apr 13 2019 3:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (51, 3, 3, 'Apr 13 2019 6:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (52, 4, 4, 'Apr 13 2019 12:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (53, 4, 4, 'Apr 13 2019 3:45PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (54, 4, 4, 'Apr 13 2019 6:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (55, 5, 5, 'Apr 13 2019 1:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (56, 5, 5, 'Apr 13 2019 4:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (57, 5, 5, 'Apr 13 2019 7:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (58, 6, 6, 'Apr 13 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (59, 6, 6, 'Apr 13 2019 4:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (60, 6, 6, 'Apr 13 2019 6:45PM');

INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (61, 1, 1, 'Apr 14 2019 10:00AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (62, 1, 1, 'Apr 14 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (63, 1, 1, 'Apr 14 2019 5:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (64, 1, 1, 'Apr 14 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (65, 2, 2, 'Apr 14 2019 10:45AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (66, 2, 2, 'Apr 14 2019 2:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (67, 2, 2, 'Apr 14 2019 5:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (68, 2, 2, 'Apr 14 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (69, 3, 3, 'Apr 14 2019 12:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (70, 3, 3, 'Apr 14 2019 3:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (71, 3, 3, 'Apr 14 2019 6:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (72, 4, 4, 'Apr 14 2019 12:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (73, 4, 4, 'Apr 14 2019 3:45PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (74, 4, 4, 'Apr 14 2019 6:41PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (75, 5, 5, 'Apr 14 2019 1:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (76, 5, 5, 'Apr 14 2019 4:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (77, 5, 5, 'Apr 14 2019 7:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (78, 6, 6, 'Apr 14 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (79, 6, 6, 'Apr 14 2019 4:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (80, 6, 6, 'Apr 14 2019 6:45PM');

INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (81, 1, 1, 'Apr 15 2019 10:00AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (82, 1, 1, 'Apr 15 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (83, 1, 1, 'Apr 15 2019 5:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (84, 1, 1, 'Apr 15 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (85, 2, 2, 'Apr 15 2019 10:45AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (86, 2, 2, 'Apr 15 2019 2:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (87, 2, 2, 'Apr 15 2019 5:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (88, 2, 2, 'Apr 15 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (89, 3, 3, 'Apr 15 2019 12:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (90, 3, 3, 'Apr 15 2019 3:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (91, 3, 3, 'Apr 15 2019 6:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (92, 4, 4, 'Apr 15 2019 12:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (93, 4, 4, 'Apr 15 2019 3:45PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (94, 4, 4, 'Apr 15 2019 6:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (95, 5, 5, 'Apr 15 2019 1:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (96, 5, 5, 'Apr 15 2019 4:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (97, 5, 5, 'Apr 15 2019 7:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (98, 6, 6, 'Apr 15 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (99, 6, 6, 'Apr 15 2019 4:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (100, 6, 6, 'Apr 15 2019 6:45PM');

INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (101, 1, 1, 'Apr 16 2019 10:00AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (102, 1, 1, 'Apr 16 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (103, 1, 1, 'Apr 16 2019 5:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (104, 1, 1, 'Apr 16 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (105, 2, 2, 'Apr 16 2019 10:45AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (106, 2, 2, 'Apr 16 2019 2:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (107, 2, 2, 'Apr 16 2019 5:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (108, 2, 2, 'Apr 16 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (109, 3, 3, 'Apr 16 2019 12:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (110, 3, 3, 'Apr 16 2019 3:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (111, 3, 3, 'Apr 16 2019 6:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (112, 4, 4, 'Apr 16 2019 12:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (113, 4, 4, 'Apr 16 2019 3:45PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (114, 4, 4, 'Apr 16 2019 6:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (115, 5, 5, 'Apr 16 2019 1:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (116, 5, 5, 'Apr 16 2019 4:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (117, 5, 5, 'Apr 16 2019 7:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (118, 6, 6, 'Apr 16 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (119, 6, 6, 'Apr 16 2019 4:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (120, 6, 6, 'Apr 16 2019 6:45PM');

INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (121, 1, 1, 'Apr 17 2019 10:00AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (122, 1, 1, 'Apr 17 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (123, 1, 1, 'Apr 17 2019 5:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (124, 1, 1, 'Apr 17 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (125, 2, 2, 'Apr 17 2019 10:45AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (126, 2, 2, 'Apr 17 2019 2:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (127, 2, 2, 'Apr 17 2019 5:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (128, 2, 2, 'Apr 17 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (129, 3, 3, 'Apr 17 2019 12:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (130, 3, 3, 'Apr 17 2019 3:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (131, 3, 3, 'Apr 17 2019 6:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (132, 4, 4, 'Apr 17 2019 12:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (133, 4, 4, 'Apr 17 2019 3:45PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (134, 4, 4, 'Apr 17 2019 6:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (135, 5, 5, 'Apr 17 2019 1:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (136, 5, 5, 'Apr 17 2019 4:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (137, 5, 5, 'Apr 17 2019 7:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (138, 6, 6, 'Apr 17 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (139, 6, 6, 'Apr 17 2019 4:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (140, 6, 6, 'Apr 17 2019 6:45PM');

INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (141, 1, 1, 'Apr 18 2019 10:00AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (142, 1, 1, 'Apr 18 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (143, 1, 1, 'Apr 18 2019 5:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (144, 1, 1, 'Apr 18 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (145, 2, 2, 'Apr 18 2019 10:45AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (146, 2, 2, 'Apr 18 2019 2:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (147, 2, 2, 'Apr 18 2019 5:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (148, 2, 2, 'Apr 18 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (149, 3, 3, 'Apr 18 2019 12:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (150, 3, 3, 'Apr 18 2019 3:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (151, 3, 3, 'Apr 18 2019 6:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (152, 4, 4, 'Apr 18 2019 12:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (153, 4, 4, 'Apr 18 2019 3:45PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (154, 4, 4, 'Apr 18 2019 6:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (155, 5, 5, 'Apr 18 2019 1:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (156, 5, 5, 'Apr 18 2019 4:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (157, 5, 5, 'Apr 18 2019 7:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (158, 6, 6, 'Apr 18 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (159, 6, 6, 'Apr 18 2019 4:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (160, 6, 6, 'Apr 18 2019 6:45PM');

INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (161, 1, 1, 'Apr 19 2019 10:00AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (162, 1, 1, 'Apr 19 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (163, 1, 1, 'Apr 19 2019 5:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (164, 1, 1, 'Apr 19 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (165, 2, 2, 'Apr 19 2019 10:45AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (166, 2, 2, 'Apr 19 2019 2:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (167, 2, 2, 'Apr 19 2019 5:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (168, 2, 2, 'Apr 19 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (169, 3, 3, 'Apr 19 2019 12:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (170, 3, 3, 'Apr 19 2019 3:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (171, 3, 3, 'Apr 19 2019 6:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (172, 4, 4, 'Apr 19 2019 12:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (173, 4, 4, 'Apr 19 2019 3:45PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (174, 4, 4, 'Apr 19 2019 6:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (175, 5, 5, 'Apr 19 2019 1:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (176, 5, 5, 'Apr 19 2019 4:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (177, 5, 5, 'Apr 19 2019 7:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (178, 6, 6, 'Apr 19 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (179, 6, 6, 'Apr 19 2019 4:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (180, 6, 6, 'Apr 19 2019 6:45PM');

INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (181, 1, 1, 'Apr 20 2019 10:00AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (182, 1, 1, 'Apr 20 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (183, 1, 1, 'Apr 20 2019 5:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (184, 1, 1, 'Apr 20 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (185, 2, 2, 'Apr 20 2019 10:45AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (186, 2, 2, 'Apr 20 2019 2:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (187, 2, 2, 'Apr 20 2019 5:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (188, 2, 2, 'Apr 20 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (189, 3, 3, 'Apr 20 2019 12:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (190, 3, 3, 'Apr 20 2019 3:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (191, 3, 3, 'Apr 20 2019 6:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (192, 4, 4, 'Apr 20 2019 12:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (193, 4, 4, 'Apr 20 2019 3:45PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (194, 4, 4, 'Apr 20 2019 6:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (195, 5, 5, 'Apr 20 2019 1:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (196, 5, 5, 'Apr 20 2019 4:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (197, 5, 5, 'Apr 20 2019 7:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (198, 6, 6, 'Apr 20 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (199, 6, 6, 'Apr 20 2019 4:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (200, 6, 6, 'Apr 20 2019 6:45PM');

INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (201, 1, 1, 'Apr 21 2019 10:00AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (202, 1, 1, 'Apr 21 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (203, 1, 1, 'Apr 21 2019 5:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (204, 1, 1, 'Apr 21 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (205, 2, 2, 'Apr 21 2019 10:45AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (206, 2, 2, 'Apr 21 2019 2:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (207, 2, 2, 'Apr 21 2019 5:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (208, 2, 2, 'Apr 21 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (209, 3, 3, 'Apr 21 2019 12:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (210, 3, 3, 'Apr 21 2019 3:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (211, 3, 3, 'Apr 21 2019 6:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (212, 4, 4, 'Apr 21 2019 12:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (213, 4, 4, 'Apr 21 2019 3:45PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (214, 4, 4, 'Apr 21 2019 6:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (215, 5, 5, 'Apr 21 2019 1:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (216, 5, 5, 'Apr 21 2019 4:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (217, 5, 5, 'Apr 21 2019 7:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (218, 6, 6, 'Apr 21 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (219, 6, 6, 'Apr 21 2019 4:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (220, 6, 6, 'Apr 21 2019 6:45PM');

INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (221, 1, 1, 'Apr 22 2019 10:00AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (222, 1, 1, 'Apr 22 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (223, 1, 1, 'Apr 22 2019 5:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (224, 1, 1, 'Apr 22 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (225, 2, 2, 'Apr 22 2019 10:45AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (226, 2, 2, 'Apr 22 2019 2:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (227, 2, 2, 'Apr 22 2019 5:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (228, 2, 2, 'Apr 22 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (229, 3, 3, 'Apr 22 2019 12:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (230, 3, 3, 'Apr 22 2019 3:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (231, 3, 3, 'Apr 22 2019 6:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (232, 4, 4, 'Apr 22 2019 12:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (233, 4, 4, 'Apr 22 2019 3:45PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (234, 4, 4, 'Apr 22 2019 6:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (235, 5, 5, 'Apr 22 2019 1:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (236, 5, 5, 'Apr 22 2019 4:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (237, 5, 5, 'Apr 22 2019 7:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (238, 6, 6, 'Apr 22 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (239, 6, 6, 'Apr 22 2019 4:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (240, 6, 6, 'Apr 22 2019 6:45PM');

INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (241, 1, 1, 'Apr 23 2019 10:00AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (242, 1, 1, 'Apr 23 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (243, 1, 1, 'Apr 23 2019 5:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (244, 1, 1, 'Apr 23 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (245, 2, 2, 'Apr 23 2019 10:45AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (246, 2, 2, 'Apr 23 2019 2:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (247, 2, 2, 'Apr 23 2019 5:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (248, 2, 2, 'Apr 23 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (249, 3, 3, 'Apr 23 2019 12:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (250, 3, 3, 'Apr 23 2019 3:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (251, 3, 3, 'Apr 23 2019 6:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (252, 4, 4, 'Apr 23 2019 12:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (253, 4, 4, 'Apr 23 2019 3:45PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (254, 4, 4, 'Apr 23 2019 6:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (255, 5, 5, 'Apr 23 2019 1:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (256, 5, 5, 'Apr 23 2019 4:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (257, 5, 5, 'Apr 23 2019 7:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (258, 6, 6, 'Apr 23 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (259, 6, 6, 'Apr 23 2019 4:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (260, 6, 6, 'Apr 23 2019 6:45PM');

INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (261, 1, 1, 'Apr 24 2019 10:00AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (262, 1, 1, 'Apr 24 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (263, 1, 1, 'Apr 24 2019 5:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (264, 1, 1, 'Apr 24 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (265, 2, 2, 'Apr 24 2019 10:45AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (266, 2, 2, 'Apr 24 2019 2:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (267, 2, 2, 'Apr 24 2019 5:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (268, 2, 2, 'Apr 24 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (269, 3, 3, 'Apr 24 2019 12:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (270, 3, 3, 'Apr 24 2019 3:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (271, 3, 3, 'Apr 24 2019 6:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (272, 4, 4, 'Apr 24 2019 12:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (273, 4, 4, 'Apr 24 2019 3:45PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (274, 4, 4, 'Apr 24 2019 6:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (275, 5, 5, 'Apr 24 2019 1:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (276, 5, 5, 'Apr 24 2019 4:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (277, 5, 5, 'Apr 24 2019 7:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (278, 6, 6, 'Apr 24 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (279, 6, 6, 'Apr 24 2019 4:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (280, 6, 6, 'Apr 24 2019 6:45PM');

INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (281, 1, 1, 'Apr 25 2019 10:00AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (282, 1, 1, 'Apr 25 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (283, 1, 1, 'Apr 25 2019 5:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (284, 1, 1, 'Apr 25 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (285, 2, 2, 'Apr 25 2019 10:45AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (286, 2, 2, 'Apr 25 2019 2:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (287, 2, 2, 'Apr 25 2019 5:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (288, 2, 2, 'Apr 25 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (289, 3, 3, 'Apr 25 2019 12:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (290, 3, 3, 'Apr 25 2019 3:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (291, 3, 3, 'Apr 25 2019 6:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (292, 4, 4, 'Apr 25 2019 12:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (293, 4, 4, 'Apr 25 2019 3:45PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (294, 4, 4, 'Apr 25 2019 6:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (295, 5, 5, 'Apr 25 2019 1:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (296, 5, 5, 'Apr 25 2019 4:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (297, 5, 5, 'Apr 25 2019 7:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (298, 6, 6, 'Apr 25 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (299, 6, 6, 'Apr 25 2019 4:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (300, 6, 6, 'Apr 25 2019 6:45PM');

INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (301, 1, 1, 'Apr 26 2019 10:00AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (302, 1, 1, 'Apr 26 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (303, 1, 1, 'Apr 26 2019 5:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (304, 1, 1, 'Apr 26 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (305, 2, 2, 'Apr 26 2019 10:45AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (306, 2, 2, 'Apr 26 2019 2:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (307, 2, 2, 'Apr 26 2019 5:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (308, 2, 2, 'Apr 26 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (309, 3, 3, 'Apr 26 2019 12:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (310, 3, 3, 'Apr 26 2019 3:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (311, 3, 3, 'Apr 26 2019 6:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (312, 4, 4, 'Apr 26 2019 12:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (313, 4, 4, 'Apr 26 2019 3:45PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (314, 4, 4, 'Apr 26 2019 6:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (315, 5, 5, 'Apr 26 2019 1:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (316, 5, 5, 'Apr 26 2019 4:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (317, 5, 5, 'Apr 26 2019 7:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (318, 6, 6, 'Apr 26 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (319, 6, 6, 'Apr 26 2019 4:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (320, 6, 6, 'Apr 26 2019 6:45PM');

INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (321, 1, 1, 'Apr 27 2019 10:00AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (322, 1, 1, 'Apr 27 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (323, 1, 1, 'Apr 27 2019 5:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (324, 1, 1, 'Apr 27 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (325, 2, 2, 'Apr 27 2019 10:45AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (326, 2, 2, 'Apr 27 2019 2:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (327, 2, 2, 'Apr 27 2019 5:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (328, 2, 2, 'Apr 27 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (329, 3, 3, 'Apr 27 2019 12:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (330, 3, 3, 'Apr 27 2019 3:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (331, 3, 3, 'Apr 27 2019 6:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (332, 4, 4, 'Apr 27 2019 12:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (333, 4, 4, 'Apr 27 2019 3:45PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (334, 4, 4, 'Apr 27 2019 6:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (335, 5, 5, 'Apr 27 2019 1:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (336, 5, 5, 'Apr 27 2019 4:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (337, 5, 5, 'Apr 27 2019 7:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (338, 6, 6, 'Apr 27 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (339, 6, 6, 'Apr 27 2019 4:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (340, 6, 6, 'Apr 27 2019 6:45PM');

INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (341, 1, 1, 'Apr 28 2019 10:00AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (342, 1, 1, 'Apr 28 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (343, 1, 1, 'Apr 28 2019 5:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (344, 1, 1, 'Apr 28 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (345, 2, 2, 'Apr 28 2019 10:45AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (346, 2, 2, 'Apr 28 2019 2:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (347, 2, 2, 'Apr 28 2019 5:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (348, 2, 2, 'Apr 28 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (349, 3, 3, 'Apr 28 2019 12:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (350, 3, 3, 'Apr 28 2019 3:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (351, 3, 3, 'Apr 28 2019 6:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (352, 4, 4, 'Apr 28 2019 12:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (353, 4, 4, 'Apr 28 2019 3:45PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (354, 4, 4, 'Apr 28 2019 6:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (355, 5, 5, 'Apr 28 2019 1:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (356, 5, 5, 'Apr 28 2019 4:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (357, 5, 5, 'Apr 28 2019 7:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (358, 6, 6, 'Apr 28 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (359, 6, 6, 'Apr 28 2019 4:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (360, 6, 6, 'Apr 28 2019 6:45PM');

INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (361, 1, 1, 'Apr 29 2019 10:00AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (362, 1, 1, 'Apr 29 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (363, 1, 1, 'Apr 29 2019 5:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (364, 1, 1, 'Apr 29 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (365, 2, 2, 'Apr 29 2019 10:45AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (366, 2, 2, 'Apr 29 2019 2:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (367, 2, 2, 'Apr 29 2019 5:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (368, 2, 2, 'Apr 29 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (369, 3, 3, 'Apr 29 2019 12:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (370, 3, 3, 'Apr 29 2019 3:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (371, 3, 3, 'Apr 29 2019 6:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (372, 4, 4, 'Apr 29 2019 12:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (373, 4, 4, 'Apr 29 2019 3:45PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (374, 4, 4, 'Apr 29 2019 6:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (375, 5, 5, 'Apr 29 2019 1:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (376, 5, 5, 'Apr 29 2019 4:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (377, 5, 5, 'Apr 29 2019 7:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (378, 6, 6, 'Apr 29 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (379, 6, 6, 'Apr 29 2019 4:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (380, 6, 6, 'Apr 29 2019 6:45PM');

INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (381, 1, 1, 'Apr 30 2019 10:00AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (382, 1, 1, 'Apr 30 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (383, 1, 1, 'Apr 30 2019 5:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (384, 1, 1, 'Apr 30 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (385, 2, 2, 'Apr 30 2019 10:45AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (386, 2, 2, 'Apr 30 2019 2:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (387, 2, 2, 'Apr 30 2019 5:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (388, 2, 2, 'Apr 30 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (389, 3, 3, 'Apr 30 2019 12:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (390, 3, 3, 'Apr 30 2019 3:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (391, 3, 3, 'Apr 30 2019 6:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (392, 4, 4, 'Apr 30 2019 12:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (393, 4, 4, 'Apr 30 2019 3:45PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (394, 4, 4, 'Apr 30 2019 6:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (395, 5, 5, 'Apr 30 2019 1:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (396, 5, 5, 'Apr 30 2019 4:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (397, 5, 5, 'Apr 30 2019 7:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (398, 6, 6, 'Apr 30 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (399, 6, 6, 'Apr 30 2019 4:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (400, 6, 6, 'Apr 30 2019 6:45PM');

INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (401, 1, 1, 'May 01 2019 10:00AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (402, 1, 1, 'May 01 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (403, 1, 1, 'May 01 2019 5:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (404, 1, 1, 'May 01 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (405, 2, 2, 'May 01 2019 10:45AM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (406, 2, 2, 'May 01 2019 2:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (407, 2, 2, 'May 01 2019 5:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (408, 2, 2, 'May 01 2019 9:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (409, 3, 3, 'May 01 2019 12:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (410, 3, 3, 'May 01 2019 3:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (411, 3, 3, 'May 01 2019 6:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (412, 4, 4, 'May 01 2019 12:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (413, 4, 4, 'May 01 2019 3:45PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (414, 4, 4, 'May 01 2019 6:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (415, 5, 5, 'May 01 2019 1:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (416, 5, 5, 'May 01 2019 4:15PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (417, 5, 5, 'May 01 2019 7:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (418, 6, 6, 'May 01 2019 1:30PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (419, 6, 6, 'May 01 2019 4:00PM');
INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (420, 6, 6, 'May 01 2019 6:45PM');
--INSERTIONS INTO OUR THEATER TABLE 
INSERT INTO theater(theater_id, totalSeats) VALUES (1, 160);
INSERT INTO theater(theater_id, totalSeats) VALUES (2, 120);
INSERT INTO theater(theater_id, totalSeats) VALUES (3, 120);
INSERT INTO theater(theater_id, totalSeats) VALUES (4, 120);
INSERT INTO theater(theater_id, totalSeats) VALUES (5, 120);
INSERT INTO theater(theater_id, totalSeats) VALUES (6, 120);

--INSERTIONS INTO OUR SEATS TABLE seats 1
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (1, 1 ,1);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (2, 1 ,2);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (3, 1 ,3);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (4, 1 ,4);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (5, 1 ,5);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (6, 1 ,6);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (7, 1 ,7);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (8, 1 ,8);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (9, 1 ,9);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (10, 1 ,10);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (11, 1 ,11);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (12, 1 ,12);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (13, 1 ,13);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (14, 1 ,14);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (15, 1 ,15);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (16, 1 ,16);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (17, 1 ,17);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (18, 1 ,18);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (19, 1 ,19);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (20, 1 ,20);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (21, 1 ,21);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (22, 1 ,22);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (23, 1 ,23);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (24, 1 ,24);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (25, 1 ,25);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (26, 1 ,26);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (27, 1 ,27);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (28, 1 ,28);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (29, 1 ,29);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (30, 1 ,30);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (31, 1 ,31);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (32, 1 ,32);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (33, 1 ,33);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (34, 1 ,34);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (35, 1 ,35);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (36, 1 ,36);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (37, 1 ,37);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (38, 1 ,38);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (39, 1 ,39);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (40, 1 ,40);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (41, 1 ,41);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (42, 1 ,42);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (43, 1 ,43);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (44, 1 ,44);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (45, 1 ,45);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (46, 1 ,46);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (47, 1 ,47);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (48, 1 ,48);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (49, 1 ,49);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (50, 1 ,50);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (51, 1 ,51);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (52, 1 ,52);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (53, 1 ,53);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (54, 1 ,54);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (55, 1 ,55);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (56, 1 ,56);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (57, 1 ,57);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (58, 1 ,58);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (59, 1 ,59);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (60, 1 ,60);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (61, 1 ,61);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (62, 1 ,62);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (63, 1 ,63);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (64, 1 ,64);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (65, 1 ,65);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (66, 1 ,66);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (67, 1 ,67);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (68, 1 ,68);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (69, 1 ,69);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (70, 1 ,70);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (71, 1 ,71);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (72, 1 ,72);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (73, 1 ,73);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (74, 1 ,74);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (75, 1 ,75);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (76, 1 ,76);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (77, 1 ,77);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (78, 1 ,78);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (79, 1 ,79);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (80, 1 ,80);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (81, 1 ,81);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (82, 1 ,82);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (83, 1 ,83);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (84, 1 ,84);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (85, 1 ,85);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (86, 1 ,86);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (87, 1 ,87);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (88, 1 ,88);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (89, 1 ,89);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (90, 1 ,90);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (91, 1 ,91);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (92, 1 ,92);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (93, 1 ,93);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (94, 1 ,94);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (95, 1 ,95);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (96, 1 ,96);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (97, 1 ,97);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (98, 1 ,98);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (99, 1 ,99);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (100, 1 ,100);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (101, 1 ,101);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (102, 1 ,102);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (103, 1 ,103);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (104, 1 ,104);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (105, 1 ,105);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (106, 1 ,106);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (107, 1 ,107);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (108, 1 ,108);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (109, 1 ,109);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (110, 1 ,110);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (111, 1 ,111);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (112, 1 ,112);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (113, 1 ,113);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (114, 1 ,114);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (115, 1 ,115);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (116, 1 ,116);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (117, 1 ,117);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (118, 1 ,118);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (119, 1 ,119);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (120, 1 ,120);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (121, 1 ,121);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (122, 1 ,122);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (123, 1 ,123);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (124, 1 ,124);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (125, 1 ,125);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (126, 1 ,126);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (127, 1 ,127);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (128, 1 ,128);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (129, 1 ,129);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (130, 1 ,130);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (131, 1 ,131);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (132, 1 ,132);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (133, 1 ,133);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (134, 1 ,134);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (135, 1 ,135);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (136, 1 ,136);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (137, 1 ,137);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (138, 1 ,138);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (139, 1 ,139);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (140, 1 ,140);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (141, 1 ,141);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (142, 1 ,142);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (143, 1 ,143);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (144, 1 ,144);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (145, 1 ,145);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (146, 1 ,146);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (147, 1 ,147);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (148, 1 ,148);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (149, 1 ,149);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (150, 1 ,150);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (151, 1 ,151);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (152, 1 ,152);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (153, 1 ,153);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (154, 1 ,154);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (155, 1 ,155);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (156, 1 ,156);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (157, 1 ,157);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (158, 1 ,158);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (159, 1 ,159);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (160, 1 ,160);

--INSERTIONS INTO OUR SEATS TABLE seats 2
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (161, 2 ,1);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (162, 2 ,2);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (163, 2 ,3);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (164, 2 ,4);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (165, 2 ,5);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (166, 2 ,6);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (167, 2 ,7);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (168, 2 ,8);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (169, 2 ,9);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (170, 2 ,10);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (171, 2 ,11);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (172, 2 ,12);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (173, 2 ,13);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (174, 2 ,14);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (175, 2 ,15);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (176, 2 ,16);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (177, 2 ,17);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (178, 2 ,18);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (179, 2 ,19);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (180, 2 ,20);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (181, 2 ,21);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (182, 2 ,22);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (183, 2 ,23);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (184, 2 ,24);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (185, 2 ,25);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (186, 2 ,26);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (187, 2 ,27);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (188, 2 ,28);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (189, 2 ,29);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (190, 2 ,30);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (191, 2 ,31);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (192, 2 ,32);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (193, 2 ,33);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (194, 2 ,34);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (195, 2 ,35);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (196, 2 ,36);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (197, 2 ,37);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (198, 2 ,38);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (199, 2 ,39);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (200, 2 ,40);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (201, 2 ,41);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (202, 2 ,42);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (203, 2 ,43);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (204, 2 ,44);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (205, 2 ,45);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (206, 2 ,46);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (207, 2 ,47);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (208, 2 ,48);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (209, 2 ,49);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (210, 2 ,50);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (211, 2 ,51);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (212, 2 ,52);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (213, 2 ,53);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (214, 2 ,54);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (215, 2 ,55);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (216, 2 ,56);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (217, 2 ,57);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (218, 2 ,58);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (219, 2 ,59);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (220, 2 ,60);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (221, 2 ,61);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (222, 2 ,62);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (223, 2 ,63);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (224, 2 ,64);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (225, 2 ,65);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (226, 2 ,66);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (227, 2 ,67);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (228, 2 ,68);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (229, 2 ,69);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (230, 2 ,70);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (231, 2 ,71);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (232, 2 ,72);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (233, 2 ,73);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (234, 2 ,74);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (235, 2 ,75);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (236, 2 ,76);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (237, 2 ,77);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (238, 2 ,78);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (239, 2 ,79);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (240, 2 ,80);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (241, 2 ,81);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (242, 2 ,82);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (243, 2 ,83);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (244, 2 ,84);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (245, 2 ,85);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (246, 2 ,86);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (247, 2 ,87);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (248, 2 ,88);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (249, 2 ,89);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (250, 2 ,90);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (251, 2 ,91);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (252, 2 ,92);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (253, 2 ,93);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (254, 2 ,94);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (255, 2 ,95);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (256, 2 ,96);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (257, 2 ,97);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (258, 2 ,98);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (259, 2 ,99);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (260, 2 ,100);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (261, 2 ,101);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (262, 2 ,102);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (263, 2 ,103);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (264, 2 ,104);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (265, 2 ,105);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (266, 2 ,106);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (267, 2 ,107);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (268, 2 ,108);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (269, 2 ,109);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (270, 2 ,110);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (271, 2 ,111);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (272, 2 ,112);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (273, 2 ,113);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (274, 2 ,114);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (275, 2 ,115);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (276, 2 ,116);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (277, 2 ,117);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (278, 2 ,118);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (279, 2 ,119);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (280, 2 ,120);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (281, 2 ,121);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (282, 2 ,122);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (283, 2 ,123);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (284, 2 ,124);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (285, 2 ,125);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (286, 2 ,126);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (287, 2 ,127);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (288, 2 ,128);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (289, 2 ,129);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (290, 2 ,130);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (291, 2 ,131);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (292, 2 ,132);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (293, 2 ,133);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (294, 2 ,134);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (295, 2 ,135);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (296, 2 ,136);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (297, 2 ,137);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (298, 2 ,138);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (299, 2 ,139);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (300, 2 ,140);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (301, 2 ,141);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (302, 2 ,142);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (303, 2 ,143);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (304, 2 ,144);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (305, 2 ,145);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (306, 2 ,146);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (307, 2 ,147);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (308, 2 ,148);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (309, 2 ,149);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (310, 2 ,150);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (311, 2 ,151);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (312, 2 ,152);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (313, 2 ,153);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (314, 2 ,154);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (315, 2 ,155);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (316, 2 ,156);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (317, 2 ,157);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (318, 2 ,158);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (319, 2 ,159);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (320, 2 ,160);

--INSERTIONS INTO OUR SEATS TABLE seats 3
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (321, 3 ,1);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (322, 3 ,2);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (323, 3 ,3);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (324, 3 ,4);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (325, 3 ,5);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (326, 3 ,6);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (327, 3 ,7);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (328, 3 ,8);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (329, 3 ,9);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (330, 3 ,10);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (331, 3 ,11);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (332, 3 ,12);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (333, 3 ,13);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (334, 3 ,14);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (335, 3 ,15);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (336, 3 ,16);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (337, 3 ,17);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (338, 3 ,18);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (339, 3 ,19);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (340, 3 ,20);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (341, 3 ,21);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (342, 3 ,22);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (343, 3 ,23);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (344, 3 ,24);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (345, 3 ,25);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (346, 3 ,26);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (347, 3 ,27);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (348, 3 ,28);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (349, 3 ,29);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (350, 3 ,30);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (351, 3 ,31);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (352, 3 ,32);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (353, 3 ,33);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (354, 3 ,34);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (355, 3 ,35);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (356, 3 ,36);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (357, 3 ,37);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (358, 3 ,38);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (359, 3 ,39);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (360, 3 ,40);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (361, 3 ,41);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (362, 3 ,42);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (363, 3 ,43);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (364, 3 ,44);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (365, 3 ,45);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (366, 3 ,46);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (367, 3 ,47);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (368, 3 ,48);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (369, 3 ,49);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (370, 3 ,50);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (371, 3 ,51);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (372, 3 ,52);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (373, 3 ,53);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (374, 3 ,54);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (375, 3 ,55);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (376, 3 ,56);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (377, 3 ,57);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (378, 3 ,58);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (379, 3 ,59);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (380, 3 ,60);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (381, 3 ,61);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (382, 3 ,62);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (383, 3 ,63);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (384, 3 ,64);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (385, 3 ,65);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (386, 3 ,66);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (387, 3 ,67);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (388, 3 ,68);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (389, 3 ,69);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (390, 3 ,70);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (391, 3 ,71);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (392, 3 ,72);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (393, 3 ,73);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (394, 3 ,74);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (395, 3 ,75);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (396, 3 ,76);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (397, 3 ,77);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (398, 3 ,78);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (399, 3 ,79);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (400, 3 ,80);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (401, 3 ,81);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (402, 3 ,82);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (403, 3 ,83);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (404, 3 ,84);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (405, 3 ,85);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (406, 3 ,86);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (407, 3 ,87);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (408, 3 ,88);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (409, 3 ,89);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (410, 3 ,90);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (411, 3 ,91);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (412, 3 ,92);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (413, 3 ,93);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (414, 3 ,94);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (415, 3 ,95);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (416, 3 ,96);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (417, 3 ,97);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (418, 3 ,98);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (419, 3 ,99);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (420, 3 ,100);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (421, 3 ,101);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (422, 3 ,102);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (423, 3 ,103);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (424, 3 ,104);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (425, 3 ,105);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (426, 3 ,106);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (427, 3 ,107);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (428, 3 ,108);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (429, 3 ,109);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (430, 3 ,110);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (431, 3 ,111);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (432, 3 ,112);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (433, 3 ,113);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (434, 3 ,114);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (435, 3 ,115);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (436, 3 ,116);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (437, 3 ,117);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (438, 3 ,118);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (439, 3 ,119);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (440, 3 ,120);

--INSERTIONS INTO OUR SEATS TABLE seats 4
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (441, 4 ,1);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (442, 4 ,2);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (443, 4 ,3);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (444, 4 ,4);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (445, 4 ,5);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (446, 4 ,6);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (447, 4 ,7);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (448, 4 ,8);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (449, 4 ,9);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (450, 4 ,10);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (451, 4 ,11);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (452, 4 ,12);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (453, 4 ,13);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (454, 4 ,14);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (455, 4 ,15);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (456, 4 ,16);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (457, 4 ,17);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (458, 4 ,18);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (459, 4 ,19);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (460, 4 ,20);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (461, 4 ,21);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (462, 4 ,22);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (463, 4 ,23);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (464, 4 ,24);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (465, 4 ,25);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (466, 4 ,26);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (467, 4 ,27);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (468, 4 ,28);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (469, 4 ,29);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (470, 4 ,30);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (471, 4 ,31);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (472, 4 ,32);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (473, 4 ,33);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (474, 4 ,34);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (475, 4 ,35);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (476, 4 ,36);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (477, 4 ,37);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (478, 4 ,38);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (479, 4 ,39);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (480, 4 ,40);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (481, 4 ,41);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (482, 4 ,42);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (483, 4 ,43);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (484, 4 ,44);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (485, 4 ,45);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (486, 4 ,46);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (487, 4 ,47);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (488, 4 ,48);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (489, 4 ,49);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (490, 4 ,50);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (491, 4 ,51);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (492, 4 ,52);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (493, 4 ,53);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (494, 4 ,54);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (495, 4 ,55);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (496, 4 ,56);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (497, 4 ,57);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (498, 4 ,58);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (499, 4 ,59);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (500, 4 ,60);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (501, 4 ,61);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (502, 4 ,62);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (503, 4 ,63);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (504, 4 ,64);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (505, 4 ,65);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (506, 4 ,66);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (507, 4 ,67);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (508, 4 ,68);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (509, 4 ,69);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (510, 4 ,70);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (511, 4 ,71);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (512, 4 ,72);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (513, 4 ,73);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (514, 4 ,74);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (515, 4 ,75);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (516, 4 ,76);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (517, 4 ,77);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (518, 4 ,78);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (519, 4 ,79);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (520, 4 ,80);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (521, 4 ,81);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (522, 4 ,82);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (523, 4 ,83);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (524, 4 ,84);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (525, 4 ,85);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (526, 4 ,86);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (527, 4 ,87);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (528, 4 ,88);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (529, 4 ,89);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (530, 4 ,90);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (531, 4 ,91);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (532, 4 ,92);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (533, 4 ,93);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (534, 4 ,94);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (535, 4 ,95);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (536, 4 ,96);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (537, 4 ,97);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (538, 4 ,98);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (539, 4 ,99);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (540, 4 ,100);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (541, 4 ,101);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (542, 4 ,102);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (543, 4 ,103);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (544, 4 ,104);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (545, 4 ,105);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (546, 4 ,106);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (547, 4 ,107);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (548, 4 ,108);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (549, 4 ,109);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (550, 4 ,110);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (551, 4 ,111);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (552, 4 ,112);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (553, 4 ,113);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (554, 4 ,114);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (555, 4 ,115);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (556, 4 ,116);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (557, 4 ,117);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (558, 4 ,118);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (559, 4 ,119);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (560, 4 ,120);


--INSERTIONS INTO OUR SEATS TABLE seats 5
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (561, 5 ,1);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (562, 5 ,2);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (563, 5 ,3);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (564, 5 ,4);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (565, 5 ,5);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (566, 5 ,6);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (567, 5 ,7);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (568, 5 ,8);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (569, 5 ,9);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (570, 5 ,10);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (571, 5 ,11);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (572, 5 ,12);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (573, 5 ,13);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (574, 5 ,14);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (575, 5 ,15);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (576, 5 ,16);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (577, 5 ,17);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (578, 5 ,18);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (579, 5 ,19);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (580, 5 ,20);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (581, 5 ,21);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (582, 5 ,22);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (583, 5 ,23);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (584, 5 ,24);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (585, 5 ,25);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (586, 5 ,26);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (587, 5 ,27);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (588, 5 ,28);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (589, 5 ,29);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (590, 5 ,30);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (591, 5 ,31);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (592, 5 ,32);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (593, 5 ,33);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (594, 5 ,34);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (595, 5 ,35);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (596, 5 ,36);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (597, 5 ,37);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (598, 5 ,38);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (599, 5 ,39);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (600, 5 ,40);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (601, 5 ,41);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (602, 5 ,42);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (603, 5 ,43);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (604, 5 ,44);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (605, 5 ,45);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (606, 5 ,46);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (607, 5 ,47);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (608, 5 ,48);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (609, 5 ,49);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (610, 5 ,50);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (611, 5 ,51);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (612, 5 ,52);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (613, 5 ,53);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (614, 5 ,54);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (615, 5 ,55);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (616, 5 ,56);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (617, 5 ,57);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (618, 5 ,58);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (619, 5 ,59);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (620, 5 ,60);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (621, 5 ,61);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (622, 5 ,62);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (623, 5 ,63);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (624, 5 ,64);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (625, 5 ,65);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (626, 5 ,66);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (627, 5 ,67);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (628, 5 ,68);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (629, 5 ,69);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (630, 5 ,70);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (631, 5 ,71);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (632, 5 ,72);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (633, 5 ,73);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (634, 5 ,74);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (635, 5 ,75);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (636, 5 ,76);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (637, 5 ,77);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (638, 5 ,78);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (639, 5 ,79);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (640, 5 ,80);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (641, 5 ,81);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (642, 5 ,82);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (643, 5 ,83);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (644, 5 ,84);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (645, 5 ,85);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (646, 5 ,86);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (647, 5 ,87);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (648, 5 ,88);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (649, 5 ,89);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (650, 5 ,90);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (651, 5 ,91);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (652, 5 ,92);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (653, 5 ,93);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (654, 5 ,94);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (655, 5 ,95);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (656, 5 ,96);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (657, 5 ,97);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (658, 5 ,98);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (659, 5 ,99);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (660, 5 ,100);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (661, 5 ,101);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (662, 5 ,102);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (663, 5 ,103);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (664, 5 ,104);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (665, 5 ,105);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (666, 5 ,106);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (667, 5 ,107);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (668, 5 ,108);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (669, 5 ,109);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (670, 5 ,110);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (671, 5 ,111);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (672, 5 ,112);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (673, 5 ,113);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (674, 5 ,114);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (675, 5 ,115);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (676, 5 ,116);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (677, 5 ,117);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (678, 5 ,118);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (679, 5 ,119);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (680, 5 ,120);



--INSERTIONS INTO OUR SEATS TABLE seats 5
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (681, 6 ,1);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (682, 6 ,2);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (683, 6 ,3);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (684, 6 ,4);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (685, 6 ,5);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (686, 6 ,6);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (687, 6 ,7);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (688, 6 ,8);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (689, 6 ,9);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (690, 6 ,10);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (691, 6 ,11);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (692, 6 ,12);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (693, 6 ,13);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (694, 6 ,14);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (695, 6 ,15);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (696, 6 ,16);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (697, 6 ,17);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (698, 6 ,18);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (699, 6 ,19);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (700, 6 ,20);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (701, 6 ,21);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (702, 6 ,22);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (703, 6 ,23);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (704, 6 ,24);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (705, 6 ,25);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (706, 6 ,26);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (707, 6 ,27);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (708, 6 ,28);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (709, 6 ,29);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (710, 6 ,30);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (711, 6 ,31);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (712, 6 ,32);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (713, 6 ,33);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (714, 6 ,34);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (715, 6 ,35);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (716, 6 ,36);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (717, 6 ,37);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (718, 6 ,38);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (719, 6 ,39);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (720, 6 ,40);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (721, 6 ,41);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (722, 6 ,42);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (723, 6 ,43);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (724, 6 ,44);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (725, 6 ,45);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (726, 6 ,46);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (727, 6 ,47);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (728, 6 ,48);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (729, 6 ,49);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (730, 6 ,50);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (731, 6 ,51);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (732, 6 ,52);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (733, 6 ,53);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (734, 6 ,54);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (735, 6 ,55);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (736, 6 ,56);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (737, 6 ,57);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (738, 6 ,58);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (739, 6 ,59);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (740, 6 ,60);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (741, 6 ,61);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (742, 6 ,62);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (743, 6 ,63);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (744, 6 ,64);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (745, 6 ,65);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (746, 6 ,66);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (747, 6 ,67);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (748, 6 ,68);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (749, 6 ,69);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (750, 6 ,70);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (751, 6 ,71);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (752, 6 ,72);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (753, 6 ,73);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (754, 6 ,74);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (755, 6 ,75);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (756, 6 ,76);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (757, 6 ,77);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (758, 6 ,78);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (759, 6 ,79);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (760, 6 ,80);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (761, 6 ,81);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (762, 6 ,82);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (763, 6 ,83);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (764, 6 ,84);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (765, 6 ,85);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (766, 6 ,86);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (767, 6 ,87);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (768, 6 ,88);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (769, 6 ,89);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (770, 6 ,90);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (771, 6 ,91);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (772, 6 ,92);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (773, 6 ,93);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (774, 6 ,94);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (775, 6 ,95);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (776, 6 ,96);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (777, 6 ,97);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (778, 6 ,98);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (779, 6 ,99);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (780, 6 ,100);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (781, 6 ,101);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (782, 6 ,102);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (783, 6 ,103);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (784, 6 ,104);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (785, 6 ,105);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (786, 6 ,106);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (787, 6 ,107);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (788, 6 ,108);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (789, 6 ,109);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (790, 6 ,110);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (791, 6 ,111);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (792, 6 ,112);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (793, 6 ,113);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (794, 6 ,114);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (795, 6 ,115);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (796, 6 ,116);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (797, 6 ,117);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (798, 6 ,118);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (799, 6 ,119);
INSERT INTO seats(seat_id, theater_id, seatNumber) VALUES (800, 6 ,120);

--INSERTIONS INTO RESERVATIONS/TICKETS
INSERT INTO reservations(reservation_id, bookingTime, finalized, id, showtime_id, confirmationNumber) VALUES (1, 'Apr 15 2019 10:00AM', TRUE, 1, 82, 600678);
INSERT INTO tickets(ticket_id, reservation_id, seat_id) VALUES (1, 1, 1);


-- PROVIDES OUR TABLE LINKS FOR ACTORS AND MOVIES
ALTER TABLE movie_actor
ADD FOREIGN KEY(movie_id)
REFERENCES movies(movie_id);

ALTER TABLE movie_actor
ADD FOREIGN KEY(actor_id)
REFERENCES actors(actor_id);

-- PROVIDES OUR TABLE LINKS FOR GENRES AND MOVIES
ALTER TABLE genre_movie
ADD FOREIGN KEY(movie_id)
REFERENCES movies(movie_id);

ALTER TABLE genre_movie
ADD FOREIGN KEY(genre_id)
REFERENCES genre(genre_id);

ALTER TABLE showtime
ADD FOREIGN KEY(movie_id)
REFERENCES movies(movie_id);

ALTER TABLE showtime
ADD FOREIGN KEY(theater_id)
REFERENCES theater(theater_id);

ALTER TABLE seats
ADD FOREIGN KEY(theater_id)
REFERENCES theater(theater_id);

ALTER TABLE tickets
ADD FOREIGN KEY(seat_id)
REFERENCES seats(seat_id);

ALTER TABLE tickets
ADD FOREIGN KEY(reservation_id)
REFERENCES reservations(reservation_id);

ALTER TABLE reservations
ADD FOREIGN KEY(id)
REFERENCES users(id);

ALTER TABLE reservations
ADD FOREIGN KEY(showtime_id)
REFERENCES showtime(showtime_id);

SELECT actors.firstName, actors.lastName 
FROM actors 
JOIN movie_actor ON actors.actor_id = movie_actor.actor_id 
JOIN movies ON movies.movie_id = movie_actor.movie_id
WHERE movies.title = 'Us';

SELECT genre.genre
FROM genre 
JOIN genre_movie ON genre.genre_id = genre_movie.genre_id 
JOIN movies ON genre_movie.movie_id = movies.movie_id
WHERE movies.title = 'Us';

SELECT * FROM movies;

UPDATE showtime 
SET price = 10.00 
WHERE CAST(dateTime AS time) >= '12:00PM';

UPDATE showtime 
SET price = 8.00
WHERE CAST(dateTime AS time) <= '12:00PM';

COMMIT TRANSACTION;