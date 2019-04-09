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
  synopsis varchar(255) NOT NULL,        -- short summary of the movie
  mainImage varchar(100) NOT NULL,       -- ability to access movie poster
  trailerLink varchar(100) NOT NULL,     -- ability to access movie trailer
  officialSite varchar(100) NOT NULL     -- ability to access the official site for the movie
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
        CONSTRAINT pk_tickets_ticket_id PRIMARY KEY (ticket_id)
);

CREATE TABLE reservations(
        reservation_id serial NOT NULL,
        bookingTime TIMESTAMP NOT NULL,
        finalized BOOLEAN NOT NULL,
        id INTEGER NOT NULL,
        showtime_id INTEGER NOT NULL,
        CONSTRAINT pk_reservations_reservation_id PRIMARY KEY (reservation_id)
);

-- INSERTIONS INTO OUR MOVIES TABLE
INSERT INTO movies(movie_id, title, releaseDate, rating, runtime, director, synopsis, mainImage, trailerLink, officialSite) VALUES (1, 'Avengers: Endgame', '04/26/2019'::DATE, 'PG-13', 182,'Anthony Russo', 'Great movie much respek', 'https://upload.wikimedia.org/wikipedia/en/0/0d/Avengers_Endgame_poster.jpg', 'https://www.imdb.com/title/tt4154796/videoplayer/vi3703880217', 'https://www.marvel.com/movies/avengers-endgame');
INSERT INTO movies(movie_id, title, releaseDate, rating, runtime, director, synopsis, mainImage, trailerLink, officialSite) VALUES (2, 'Us', '03/22/2019'::DATE, 'R', 116,'Jordan Peele', 'Loved it!', 'https://upload.wikimedia.org/wikipedia/en/0/00/Us_%282019%29_theatrical_poster.png', 'https://youtu.be/1tzFRIQfwXg', 'https://www.usmovie.com/');


--INSERTIONS INTO OUR ACTORS TABLE
INSERT INTO actors(actor_id, firstName, lastName) VALUES (1, 'Robert', 'Downey Jr.');
INSERT INTO actors(actor_id, firstName, lastName) VALUES (2, 'Brie', 'Larson');
INSERT INTO actors(actor_id, firstName, lastName) VALUES (3, 'Lupita', 'Nyongo''o');
INSERT INTO actors(actor_id, firstName, lastName) VALUES (4, 'Winston', 'Duke');

--INSERTIONS INTO OUR MOVIE_ACTOR TABLE
INSERT INTO movie_actor(actor_id, movie_id) VALUES (1,1);
INSERT INTO movie_actor(actor_id, movie_id) VALUES (2,1);
INSERT INTO movie_actor(actor_id, movie_id) VALUES (3,2);
INSERT INTO movie_actor(actor_id, movie_id) VALUES (4,2);


--INSERTIONS INTO OUR GENRE TABLE
INSERT INTO genre(genre_id, genre) VALUES (1, 'Action');
INSERT INTO genre(genre_id, genre) VALUES (2, 'Horror');

--INSERTIONS INTO OUR GENRE_MOVIE TABLE
INSERT INTO genre_movie(genre_id, movie_id) VALUES (2,2);

-- PROVIDES OUR TABLE LINKS FOR SHOWTIMES AND MOVIES
ALTER TABLE showtime_movie
ADD FOREIGN KEY(movie_id)
REFERENCES movies(movie_id);

ALTER TABLE showtime_movie
ADD FOREIGN KEY(showtime_id)
REFERENCES showtime(showtime_id);

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

COMMIT TRANSACTION;