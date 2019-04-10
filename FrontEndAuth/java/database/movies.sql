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
INSERT INTO movies(movie_id, title, releaseDate, rating, runtime, director, synopsis, mainImage, trailerLink, officialSite) VALUES (1, 'Avengers: Endgame', '04/26/2019'::DATE, 'PG-13', 182,'Anthony Russo', 'Adrift in space with no food or water, Tony Stark sends a message to Pepper Potts as his oxygen supply starts to dwindle. Meanwhile, the remaining Avengers -- Thor, Black Widow, Captain America and Bruce Banner -- must figure out a way to bring back their vanquished allies for an epic showdown with Thanos -- the evil demigod who decimated the planet and the universe.', 'https://upload.wikimedia.org/wikipedia/en/0/0d/Avengers_Endgame_poster.jpg', 'https://www.imdb.com/title/tt4154796/videoplayer/vi3703880217', 'https://www.marvel.com/movies/avengers-endgame');
INSERT INTO movies(movie_id, title, releaseDate, rating, runtime, director, synopsis, mainImage, trailerLink, officialSite) VALUES (2, 'Us', '03/22/2019'::DATE, 'R', 116,'Jordan Peele', 'Accompanied by her husband, son and daughter, Adelaide Wilson returns to the beachfront home where she grew up as a child. Haunted by a traumatic experience from the past, Adelaide grows increasingly concerned that something bad is going to happen. Her worst fears soon become a reality when four masked strangers descend upon the house, forcing the Wilsons into a fight for survival. When the masks come off, the family is horrified to learn that each attacker takes the appearance of one of them.', 'https://upload.wikimedia.org/wikipedia/en/0/00/Us_%282019%29_theatrical_poster.png', 'https://youtu.be/1tzFRIQfwXg', 'https://www.usmovie.com/');
INSERT INTO movies(movie_id, title, releaseDate, rating, runtime, director, synopsis, mainImage, trailerLink, officialSite) VALUES (3, 'Shazam!', '04/15/2019'::DATE, 'PG-13', 132,'David Sandberg', 'We all have a superhero inside of us -- it just takes a bit of magic to bring it out. In 14-year-old Billy Batson''s case, all he needs to do is shout out one word to transform into the adult superhero Shazam. Still a kid at heart, Shazam revels in the new version of himself by doing what any other teen would do -- have fun while testing out his newfound powers. But he''ll need to master them quickly before the evil Dr. Thaddeus Sivana can get his hands on Shazam''s magical abilities.', 'https://assets.www.warnerbros.com/sites/default/files/movies/media/browser/Shazam_2000x3000.png', 'https://youtu.be/go6GEIrcvFY', 'https://www.shazammovie.com/');
INSERT INTO movies(movie_id, title, releaseDate, rating, runtime, director, synopsis, mainImage, trailerLink, officialSite) VALUES (4, 'Pet Sematary', '04/05/2019'::DATE, 'R', 100,'Kevin Kolsch', 'Doctor Louis Creed (Dale Midkiff) moves his family to Maine, where he meets a friendly local named Jud Crandall (Fred Gwynne). After the Creeds'' cat is accidentally killed, Crandall advises Louis to bury it in the ground near the old pet cemetery. The cat returns to life, its personality changed for the worse. When Louis'' son, Gage (Miko Hughes), dies tragically, Louis decides to bury the boy''s body in the same ground despite the warnings of Crandall and Louis'' visions of a deceased patient.', 'https://m.media-amazon.com/images/M/MV5BMjUyNjg1ODIwMl5BMl5BanBnXkFtZTgwNjMyOTYzNzM@._V1_.jpg', 'https://youtu.be/VllcgXSIJkE', 'https://www.imdb.com/title/tt0837563/');
INSERT INTO movies(movie_id, title, releaseDate, rating, runtime, director, synopsis, mainImage, trailerLink, officialSite) VALUES (5, 'Dumbo', '03/29/2019'::DATE, 'PG', 112,'Tim Burton', 'A young elephant, whose oversized ears enable him to fly, helps save a struggling circus, but when the circus plans a new venture, Dumbo and his friends discover dark secrets beneath its shiny veneer. Holt was once a circus star, but he went off to war and when he returned it had terribly altered him.', 'https://pbs.twimg.com/media/DxF76amVsAUr5J-.jpg', 'https://www.youtube.com/watch?v=7NiYVoqBt-8', 'https://movies.disney.com/dumbo-2019');
INSERT INTO movies(movie_id, title, releaseDate, rating, runtime, director, synopsis, mainImage, trailerLink, officialSite) VALUES (6, 'Hellboy', '04/12/2019'::DATE, 'R', 121,'Neil Marshall', 'At the end of World War II, the Nazis attempt to open a portal to a paranormal dimension in order to defeat the Allies, but are only able to summon a baby demon who is rescued by Allied forces and dubbed "Hellboy" (Ron Perlman). Sixty years later, Hellboy serves as an agent in the Bureau of Paranormal Research and Defense, where he, aided by Abe Sapien (Doug Jones), a merman with psychic powers, and Liz Sherman (Selma Blair), a woman with pyrokinesis, protects America against dark forces.', 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMTEhUTExMWFRUXGBgXGBgYFxgaHRoaGhoaGhcYGhcYHSggGB0lGxcXITEhJSkrLi4uHR8zODMtNygtLisBCgoKDg0OGxAQGy0mICYvLS0tLS0tLS0tLS8tLS0vLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLf/AABEIARUAtgMBEQACEQEDEQH/xAAcAAABBQEBAQAAAAAAAAAAAAAGAQIDBAUHAAj/xABGEAABAgQDBQYEAwUGBQQDAAABAhEAAwQhEjFBBQZRYXETIoGRobEywdHwB0JSFHKCkuEjYqKywvEkJTNj0hVDc7MWU2T/xAAbAQACAwEBAQAAAAAAAAAAAAADBAECBQAGB//EADsRAAEEAQMBBQcDBAEDBAMAAAEAAgMRIQQSMUETUWFx8AUigZGhsdEyweEUI0LxJDNSYhWCsuI0ctL/2gAMAwEAAhEDEQA/AOcIVIKZYklaVYD2zkd5QUfgLWTha3u189wdZLh5LejfyGn5dQi/eLZqKmkQtHxJlpR3lFSgE/Dcl8IOmV4UhlcySiiyQh7C3vyFzCUrCpjbQ/fEG/hGuRYwsdp2nK1EqJAf74+0LEAFbsbi6MEpswjQvHBQ8gcKMmJQyU5PB2YHP26xxUg9FIiQDLUvGkFJACDmp8yOj++UVLyHhtc9VGwFhdfHTqUynUx4h7jQxLgrQmipVKiKR3OUabmJ6ITcuWighgGAZ78b6wA8lacdJJxwpdun3wiWjcaVJ5mxNusrJqZpUbjp9OQhprQFgTSPkNuUJUE9YtVoZIYoTMJi+1AMhKVN4jhWGU9Nog5Vx7qQh8jHcKCL4TAOMWVKpSoUMiPXL18YqQrNPQqJaSCxiyqQQvJU1/cA+8QRalrtuR9gfuptnhWLuBykFXgM4rJVZVoN1+7yMor3QmU8tZn1i2JThRmWChoEuT8rwnqA9w2RjzTUVM/uyHPTyPr4LL3t2X2NSbd0ufEfF5jveJg2ml3xoeqiDZd3Q5/P5VefUpAAw3ZiXsSCbtzDRAYbJvCdGqaGBtZrn14Uq+J4vSpv3HCSJULwzjlA5ynIEVKu0G07C0davt2lPe2r/L7aK9VexXilpyHL8LdY51roSLsrUoqRSu8QQnXPL7+ULyPAwFpwRvfmsJNrTkkhv0gM2Wn34RaBpASeuoOpYk6YdM8ul3hsDvWO9x6KuKdRuIvvAQxp5HCwo8B1ibQ+zIwU5MonKOLqVmwl3CVinMRGCuIezkJwwnkY7IVhtd5ppDaRyqcJuFrxKoWkZUtldfviYjhXw5QLEWCG4JAMjEqo71tbNnSpU0TVL7QSyMPdI5uEq1f6wq8Pc3aBVp5vZtdvc6wOPRRZvMldbSpq+xMpRJwh3Jw/CrRsQJDdIUhIhl2XaM4GWHAojI70F7NSF4U2d8P/AI/TwEOzHaCUPQbXvDT5fhbsvZIQLs8IHUbjheni0LGBYlShjDrDYWJqI9jspKeUCoBRwpe6mdubDOOe4gWMlDYzcc8JZKCVsl1F7MM21aOcQG2cKY7LqGVIS93zivCOTuRTu1sFKpa6icjHKQWwXBWWuXGQSFA8/CENTqSHBjDk9UYNaDs6+Xy+avf+kU6SJktIlkYbZgKYXSVPZ3LFzz4LnUSnDja0dNCzhzAT31+34UUmYvs1FZe5D2c8LdbRchu4UnGtIdV+XkhLax73PRvv7aNODhYPtTMtBWKTY5UklrJw4lEWS7XUepiHTUUvHphtsrwKUsClRUQL2ZyMuObjwiKJzaZEzWUA28Y86VdYlrHeGBVr5i411i43NOMoL3wSD3hR7/yoRSAKYHO44PqH55iL7zVlBGnaH0088efd+FaFMFC4vqPvWKbqTPZCQUeVmV1FguMoMx+5Zmq0hiNjhV0Ki5CWa6xRSqQwzjrypLcJ1Il1e3XTOIdwqxjKWely7h9Y4cKX5Nr0yThWUHJQBSet0n5RwdubuHRVLNri09eP2TaeYjuhSbhXeL5jhhazRzg7JBUxuZgOHB9YXVd06oT5EynUXIunroYx527HBy1geD3YXO9qUhkVKk5A3HJz8lekacbxJGFnSMMUxrg+voUUyKjtZSVakMeRFiPN4yHs7OQhey0k3bRB/wA/Pqs2s2c92LQxHNWFWfSNkyoJdGAIIZDaC3Sta1ZRT3jh5+UM3jKx3D3ztSoSXYBycvbLrHEisqoBBwuxStlIp5EuUp5oCbBiUkqDzn4XsB04R5ySV0khcPXcmYnEnGO/v8FQrpSEoCEqdKphsA+QUxKfisGPlF2XZJWjBI7fdUQPLu68IamT0ATGLMpQIHFLA20GvrDoa4kX4JuN7SC6+ufhyhukSZswszE4XOXNydG940HUxotef7QzzurjPr5fdEdbVd3skJw53uQsO5fIjwfrrCjG/wCRWht5b6/PyWVNSWSkJBa6FO4xXURzBbXnBxVkk+fklnigGtHkfHmllziktiGFTPqxtbXnDDbHCRk2u/UKP0S0c0EFCza5QR+VbDLi7ANllHOB5HoKsThlrjjoe4+HqloJXZMz9TBXXIHzt4wGslq1CfdbN31fn/vHkm7SlWfQ3i0ZVNS0EIbnBlWhwZC87KNr8JZkcFDrSyDcGOdwoZzauTaPF3yWBOov/tAw+sI7ot3vLQ3p2UqUpcs3VIVhf9UtV5ah4EH+KF9LKHUf+779VbUMtljp9v4Q+vRXH31h0dyTP/cijc3aplzkKfIhJ6aQlqo7aVo6Z94Pkt/8TNlOO3RqMVuDMseV/CF9DJR2lTqY90V9W/b/AF9kP7s1jgpP5v8AMM/MMfCL62L/ACHT7LQ9i6nJjPX7j8j7LfJsRGf1Xo1mVyDgVh0F4ZiI3C0vqv8ApmljbNpDMLB4cmkDBZWJpNP2pI7kb7qbvSxUSXS5ExB45KBy8IyZtY92AU7qYIooXEDNHlGlVXPOUSGeYq9sTBIAUkKICXJTk9k83hE+9lZ8URDA0dB68UIbfrUSllSTkFEkhIJxMbhAAV3uLFheHYWOfha8HuxOfJwPXX1aA9o7SCytSQ2NSj6+pbWNiOEigelLIm1rezcI+pP4+y2t2aUCmmTWOJLAWcOpV3sfyy/SFtS8mUN6evyraFuyO+pv19klE4lkY1KKQ7KBZ3zClBweHSJf+q6TceGbbJrv/JyqtUk9lbNsTcSOuvRouyt30VJw4xY5q/ksqomqWA5LgPcX4s+ucMtAacLMke54AJzV8fRMwd18KibZW6axa8oThi6NrfppHaUpJBCrm9s9W638YUcdsi19Me0gLT4qrWTHA4YQ3vBGilEh3D4LAqk3eGmlYWobbrCjCekTaCBacCODHk8cuwrCFLIw3UM7NnFSGg2iAvIpE6qgVFHJnG6pLUk/iZZcyFnpdD8QIzi0xTOZ3+83z6hMRODm2fI+vXVB8ySUqVLOYNuoy8x7xph24BwSJZtJYfX+0tHOwmOe2wrwvorqmwp/7XRmUoArQHEY8rezksLWY6wCfIrnSJZkT1J4G3un5p6xpuqWOys+Pdp5sdDj9vwi9CiuXiSe7m3pGKRtftPK9tHI2RoeOqza9abAE/3iz+Q1hmIO6/BB1Bwk2HLKZhDF1JSz6hn0jtSQWeRS2kAa833BHO65/wCJlva5fRrF8+EY85pqtr8wOr1lam0atUuZMlTJgmBGE4rBgM3YasCTyiGsBogfys+JjXMD2ir6evouVbx7TM9alhziOQHCwHoDHoNNFsABUTTjsezZZ78evBD6pV8odDlkuizVLo25OyVzqWZLCHCgopPFSXKQOLjtR1aMbUyf3xXK143MiibuP+j/ADSx5FnQpBBsFJN9MxbvaHO0MHPvA/FNsqixw8x+O9VauUoOUJC5YBAOIuzAkm92gjSDyaKVkLmg0Lb5rGQSoqYWHeYXID6a/KGTQAWc1xcSa8f9eqUtNMviwsOL56aC/CIcOitG8uN1g9UUoUEy1hmPdtw7oI94SJshbMQAuun4WHVhKUC+gH+/lDDHElAmLWR/BZS0M5ZwbdIYB6LFec2oggFSQ3hl8om8IdAkKKcnCePWLtNoT/dUkqswksSx9IgstS2akW08pMiuXJX3aesQUHgjGe6Rw7OaLcusZRcZdOJB+pmfOufmE7LF2E7ozwfQ/CHtv0a0F1Bly1GVM/eSWB9D5CHtNI1wocHI+KW1LDQf3YP7LIVm/GGkrwbRxuPtVMqci/dLA+MZ2pjJFrYYWEbW9VJ+KGxuzmdqiwN3HAn5KbzidFJ/gUrq27mCQcjB9eaz9gVWNBRqbi+X6g3X3gerj2uDvXgtr2NqN7TGfMfv68VenyUkhCilFySsg2DZZh9IXa5wG4Z8FqTNxai3ZtMUuxIsPmWi2t/SGpbSt3BxKLKScQsLAcu9xY8R6xkvaCKRpGBzS1bFZ2U+WUHHKxHvKSEq/hAscL3aKRydmQe5ZoifG68H5j8hD21N0Sh0gOynSbsQclFuOets2h9mszkpnTPgfRcPH4/x6tY9Fu0taldqMMtL3FsR0Z9NSRDD9YGgbOVEsLS6jRHh+6K91VJTikJSUpSwGEkG5VgU7u/eDl9IRnLtwkvKHOwMA29O/OOqqbz0ElMwdrNSha0F1YQE9pZyhTgYSRkSL8LCGIZHH9AsdVZkjTETVC6BJzXj4+X15QpLpWWU9rLUFOXxgWdy72/KBD5fi6KDsLbpwz4rK2muWFOlbqy7miuShmCSrXhBog8jIx4rPnLLsHPh3qOWxACsTuTnby1iTYOERjAQLv8AZaUitDMXcqLnpb2Ahd8eb8E9BLjzP8fss/anweUHh5Sus/6apU88Bgdfse5g7mrLa6uVYnTOzGQKckqbThyv84oBuKIXBg8FDXKSpCSAxci3IJL/AOKJjBDiCqzFrmigs5MhRyST0BPtBy8DkpQRPPAJ+C6FvJQCbTkj4pRKw36TaYPRKv4TGBo5tktHg4+PT14r0vtSDe0SDkKltf8A4iXLnn/3k9jO5T5QDKP7ycCvAwzD/acY/wDtyP8A9T0+BwsvD20euPj0QaJZZSCO8ly3Syh8/CNWxhw6rO2mi08j0VPsucQoN4ddIrKMI2ndldaqAmu2cCzqlhjxIaMoXG9aNBxI6O+65fseYqTNbUKPn/VMaM7RKxJaN5glF9D6+YRHtyXi76VOksXYhgz5XZuTxl6Y7fdIyvXS+9ECPXiq2zJM0LExISAWBF7jlBJ3Rlu0pfTxyA78UUcbOUixe/BvL5xhyh3CvLu4V+TVh2AFz/SAOiJFpd0Zqyi+elDlJzCbHkAPMhx5xNUsRhdVjv8AvaFtrrKMICQpOYKTZj8gVC0MRtu8rWg96zdHxQpKqu/MzkrCShKlMzvYnRiQkdIfLMDqOcI7yXE4z4rE2pvEZssy1ymnYmUosWb4kgHIOBaHYtMGO3NOEr25LdhHw6LFk7KXMNkQ06ZrBkoJ0T3myFtSd2bd4kaj/ZoUdrDeEy3Qs4tXpuzglIBDAdQ8LiUl1haG1pbtAWLgZiM8IPR7mHL6JSOOmBw5pUNoy3Q+f1g0R95Ka2P+3axgtocq1gF1FSIWpmFwbtFSBdqwJqgpZ0qxORBw+ICX9/SKtOfXiiOGL9dFJRVuBySoad0t5/esVki3Yx8UfTavsiSb+C6FSqvk/LQg5g8iLeMeeevVyNDmlp6rNoqFpk+hJtNAVJJ//YjvyTyxJJQerQ4+W2M1Hdz5HB+RyvMmMscWFCm1RhWicB8XxD+8LKB6j5xpw5aWHp9krqBtcJB8fPqqE5GBdsrFJ5G4g4O5uUAjY/HHRdG/D/awQvCr4JoYjnkR5+8ZmoZXwWm33248x59UO7+7JNPUYkiz/wBUn3HgIa0km5u0pTVtoiVq0qRSZlMSOHp/QuIz5mmOYL0ns6btYdit7HlEICVDI2PKF9Q4F1hPAFraK1kFhb2hQ5OUM5OVo0mzlMlepUB5kX9YCZgX7AlpJhlvgjHaFalCu1LlKTjxJGQKVEnmChg3EAxSO7IHUrDgic9vZjk4ryI/dCFVtBMycUy1pYqulKgygSDiS2SrXGsNNjLW24Lbii2x27kfMeB/ZUKwSu2Anlkkl3sHD4Xfm0Fj3FlsUlxDQW+CHN4ZYJFSUhPaE4wNC9lHmRnzh/Tk12d8K4YyJ1np1S7KrpKcyHOQzc9BEzRvIwESWeIAe8Aryt6UkBQSsoBwuE2ye4JfLVmgH9G/ixfmkv6mAcWb60VTn7yypuJOI3BZwzPFxpJGkEhWbq4CNrXZpT0uyO1BKMiyXYtcsPeK9qWmimZXMYxR7V2LgQxIJPAjx5iLRzHdag7ZmkAIIqaMjEdA8azJAaC81PpCA5w6JaKpCATqU4eju7dRaJewuKWieGglVRMex1JPo330glVlDaScJAuOpduXUqdQHjyjyzwvdOCq7ekHCicgsuUoX5O6D4L/AMwg+keLMbuD6P0+yx9fFkPCyt5qQTCVoDJqE9ugcJgcTUeCsX8whzSSFoo8tO0+XQ/JZ0jN7S3vyPMflB3xI5o/yn6H3jV4d5rO5Z5fZbO7U03D3Bxp6jMeI9oV1IrPwK0tANzc+YXQt4qQVlIF/mws/sfA3hGJ5jejywhwLO/hBO6M/CTKXZnfkxZY8LGGtbHvbY9dyF7NnMTqPrvRxIoSkHCzDibB8mOsefdKCcr0LpWuq1ubL2WyXWAXhCfUWaaUjPqLNNWtLGjfekLs/UEm5QVUtUySpCQxKFoA49mWA/lIEaLXAO3d35VonNjma93eD8/5XO9n7JnInrZCsRAAaxBGrnKxjVknY6MWVtlsVukc4Ua+lqLfdU04k2UpJQFHmQsqDhgWYXYawXQhgo+f7LPla8xVEMc57u9BMztCMOJQHAEt5RqjZd0sh7ZyNu4j4ml6UhcpQN0kMQoEg8iCIlxa8UhCF8Rpw+KIaSbMmoKSpRSbl7Dxw3VmbQg9rI3bqytSCJ8razSWi2OntGZwS7sMhoBpdoiTUHamotAyN9kX1+X8o3pZoQlCQ2ZJHQW9cPkIzu8okrC9yyNtVqUuTo+cFhYXHCYsRstxoLnO1J4WskZaRvQt2tpeR1swlkJHCqCCJMYypUSnBP6b+sVLqNIrY7aXXwmiJUBdQkZ5x5dy925asiQFApV8KgUnodeoz6gQsXlp3Dokp272kIa/Zl9lOpz/ANWnUZ8vmB3ZyRyIwrHQxq7272yDhw2n9vwsSiPggzakoIm4h8C7+B+Ieb+ka0Li5lHkJGdobJY4PoqKlqTJXa+EuOf+8WewSNyrQTuhdXK63uLO7UTJT2YTEDihWY8DbxEZUjCK+RWlLL/l8vJBm/8AstdFViZLsFModRa4PEOCNQC+cPaVweza7os7UGnCRvX7j8hFW49fKqJSkGyksoX/AC/pv+lVuhTGB7VifDIHt4OPj/IWpptS5zRSLEVmEBrjIN9NYxjFuOUYx7jlT0W0AqxYHTjb2ij4S02EKWEjISbTmlCJKklmXMWrwsevdBHiIbio+76yf4Q2AF7ge4BaaqhHYftAFsL8wR/UNBmxAIDWPM3Y+K5mmX2stSlXxzSr/CG9zGs33SAOgXpHDZIWjoAFnVGzZYBOFfUJsBDDZHFVLG9aUEwiUjGQFyjbi2nkYg++6hgqkj2sb73CWnrpapacg4v1FifvjFHRODiiQTMLQQVqSGAdJuAB0Z39T6Qu7xUtO8lx6/b1fzVaoqO8OIT/AJi/yEXa3CMMO9euiHttTlHXw940NM0BY3tN5OLQzNzjQC82/lexhm1jqypDhtpNXaJGVV2MLwVHUoDl1WTLc5dY8q44XvicIkpRLIBSCkuXBLgDS5jNfvBom1nSbwSDkLG3klGVOlViLsQiYONtf3kYk/wxo6I9pC6F3w9eazpWlrrQVvVssIXMlJulLTZR4ylh7dB/ljZ0cxc1rz1wfMevqk52W0t7sj90KnJ+FvpGj1SHS0TbrbwrpcE5NzJUyk/qkr+JPgoAjwhWSK313/cJwP3Q+X2P4KLPxD2nT10mVMkqxFyMmw4g7HgXSPWF4d0ch3K/Z7osIH3U2oaeekl2B7w5ZLHlfqBB9bpxPEW+vBC0shY+iuqzJ+PI2OTcDHlAzbyvStaALV7ZFOcSuDD6iAah4oIGoeKCubYc0yG+J2D8Spyk9QG8YtAAHi+78pNn/VcPVUmVjqoZyEOrBfiWIJ+RhqL9QJ70aGm6xjnYv9kBTdrIkSEKPj1unL+ExrsiL30FpamSON7nyGh/r8qCi3sx2TKV4hh63gr9LXJS8M8c59wO8yKXuwIlKSQ6VjL9JLm3L2gBd/cB6hMmIFpahqgkYZ3YrfApQHRyGMPyOuPe3mljRMMchjdwrq5s1KzhUSFEniLk5crwENjc3ITzTLEaHCjl1ygs4rm3o5i5hBbhCGte15tMr56VjLnbny6CLRMLSl9TK2QLOmS082092hgErNLWrOmpaDApV4ANprv6RPCrd8pyJBIsIguA5VmxFwsLsFPIJyEePe4L3DnALWkS8LE5c4Vc68BKPduwFaXTy5stclSkjGGDnJT9w3/vN4PFtM97ZQa5SUzXEXXHo/RBG1pBVTJWR/aUi+zWDmZSzZ/3VOOQJjahdtmLej8/EJR+DuQBXU4lzCn8qrg8jdJ8I2o372X1WdKwMeR0PoKGjm4VNxdJHF9Iu9thRE/aa+CsUM9UtapRcJUQCCGuPgJByIduhMUkaHNDu70VMTtkhaeuPwp9syChaZotjv0WPi87HxMUhcHAt7vsjamMseH9/wB+q6NunX9tIH6kAD+EB0+TEeEec18PZy2OD9+q2dJIHRrcmbVUBhYAN4wgNM0m0w3TNJtJvLU4ESUkt/bKUH4AFTc7qMG0rd9kD/GvqlIa3k+AHr4Bbe61RiE52CcKW5Bi5fS/tFv0ghB1zK2VzZQ/tKhTiWFpSZRl5Ea4lMfVRPSDxSGgRzafY7c0d95+n8IBpaxCVFBGRbTT/aNlzHEWmWTs3FvFLbp5iSHd7aNeM+S7TQo8IfmnDWJBH5k+4h1mYL81laggTEKOSvCj5cNbRdzdzlwlDI1l1Uwk4hy8DwhpgoUseaQuduCipJhzxHo0WeAgxuPNpKme5ve1xwPEX+3jmtoYUPdZoqKho+1UzsBn9BziZZezF9VOm0xnfV4HKdtCgwZcYrFNu5RNXoxGLakSogNl4RY0UMGhS7DT1ATmfKPHOYXL1T2F3CjqZ6l9RpF2Ma1c1oaqpU+ZeCUr13KxWTEpmJqJl5U9CpU8M92AWWGp7q/Ewyd0jBt/UDY8wsSaPY4t6Djy6fuEIbxbpTE0aKsrSuWzowuVFCj3cbjutqL+EaUGqAm7OqJ+VpCVge0/+P1WBsqoQJoWlGFzYPiKeHeNzDUrXFu0ldpXta8OAU++VIMSKhItMDK5KA+Y9ojRvwWHore04QHiVvDvur1Mj9qpCM1jL/5ED/Uk/wCKAOPYzeH7H8Jtv/K0v/kPuPyFJuRtAyl4XsR5g/1aKe0YRIxU0JAdtKPZ0pS8KsLhrgZnl45eMefa4NsWtlrgywCn71yyJsvFkiWDyH5ph8WgumcNhDe//SS0tbHPHj/Cs7voMyUuWlsS0MHydiQFDQWNolzffV53CNzZDwDfj04Qbtf9tplFDBgwSlRdJDnK9n7uTZRowiGUZ/lMTv7T+5BRv8FDlTsWpUtRlSwpJIKeIBDgZ5gFn5RoMmjDQHHKzXwakuLht+JpMp5FUhYQZS030vESGEi7CJCdWx1FuO8GwvKmqVVpxZhSQX4giIDQ2A14qHvL9RnoqVbNIJGkHjbYtKal5adqriccIYakuL8MxrlBNotJBxpTrUlOJT3U1uD3JtFKJodyLbW2e9Z6pgfrBqSxcLU1FUmWSdIpIzfhM6XUdjd8KSqrTMYmwGQ+cVZEGK02pMxvgKB+MXQbXV1yC7x5QPFL2QcFe7EpQV5lvvrAd1u2pfcC7asuWtz5Qy4UEcrRrKJUymmIF7Y0/vJew6pKh1aBwThkoB4Ky9WAc9VR/D2uTPkVGzptwxmS34K/6iR0JCvEw/7QYWFszfR/kfZZUbgHZ+PkuZVtIqRPXJVmhRH0PlG1HIJYw8dUsWmOQtRLSShUU6pT3IdPJaf6t4GE3O7KUOWsGDUacs68jzWTuhUlM4ylWx2HJacvmOpEMaxls3Dp9kj7Nm2S7T1+49UrO05PYVIWPgV3h4/EPAv6QKJ3axUeQmNRH2E9jg5/K6Rs2aDKSoHvWJ5sofKPOTNIkIIx/C1LLvXgru/JaYwzUADyAuB4qYdHiNGLJJ4/gJTQ2Y07dyp7IqV8KUlKX42Lv4t5wRxN2OUTUx9qA3zP2QvvPvEidMUhbHurFrkd0kF8sw/lGhptM5o3hEDodOzs7Noc2XtDuoIWQA5tZxiVoeDe8PSR5OF2j1LZDV4Wt2mIHvOMw5JblC7mLUBpDCZCkzlYswXfjDhcCwUsTsnCUlyqz0JUoh73HppzgrCQ1Z+pp0hCpz5BQHcMVFvAMX8xBWuDkm5paqqlk+0EAQiSUwXtEqvOFYEgnO3KB7h0RxGT+peUQOccMqxICaEE5mJsDhD2lxyvoQ0rh2Atkwj572tGl6HtaNLN2pLIS4L6N7w3Ac0mYXAmlVoKB75QSWasIss1YWxXzBT0y5iWx2CP3jy4AAnygOmj7aS3cBZUjy59LlFZtA0tZLqpQYYu0wjJiSJssHh8Q6MY9RFH20Jidzx+CkJzsfu9eK1/xU2WFdnWye8iYlJJHAh0q+ULeyZi0ugfyFbUs3xiQdMHy6FDW7laUqA8R11HiIf1MdhE0E21y9vVTGVPTPl2C2WCNFgv9D5xOlfvj2O6Y+CF7Qi7Kbe3rn4rf2zKFRTCakfl7RPT/wBxPgQf5RCULjFLsPl+PXitKcf1GmEg5GfytncOcZ8pMqzhQfpdKvQCEPabBHJv9d67TzAQ7j0C297awdsU2Bc3/dSkluoIvCuiYS3cp0zdsYVUuKJwDdSidAbJD8w/sYYIHagI8b7kPgPyucpmlKzisWdm+9DG7ttuFmudTjai2bQKmgMQMIa9gbkt5qMWe8NPmiabTFwBHRbNPRzEqD6ZsYXc5pC2WB2FBtRQSokc7H1i0YsUhT+4NyGVzbqPEw6G4C8u99uJXhOdrOcgG52Da5x22lXeDyrsnYivimOgcPzEdPy+PlAXakcMz9v5TLdCeZMDu6/x8VLNpcHdRLIfKxJPjmYq1+7LiiGPZhjVEaFQ+Mty18eEWEgP6VUwkfqSTEJAYCJBJKq4ACgqqS1oKhDuXeK/aKBhD3OQTf2jwUMDjZW7FC42VQpahKw7tdsJb09IZe0sNfVMPY5pqleowgWKgGLecLybjkBLyl54CrbcoJlTNTIQQlCElRUcnU2gzsB6wzp52aeHe7JJ49eSUumlx8kAb3bDMlCk9rLmgHEMJZQsAsFJuxABcOO7zjc0Gq7VwO0t6Z+mfXKXmjcWGwtDcatFXQTqFZdcsFUt8zLVmB+6o+ogXtGMwahs7eDz5/yo0Lg4FjvL4H19kATEqlTFINlIU3kbGNsESMDhwUqQ6J5aeQUSVUxM+kUkllJGNOptoNeIhNgMcvgVpzls+m8QrW4lVjkLl/mlKxpH91eY8FD/ABQH2gzbIHd+PiPX0U+yJQWlh9Wtv8O5PY7RmSvylC1yxyIBA8GUPCE/aR7XTB3W6KC+MxF8fiPkrO+FSFTS4ZTrQCND3ChRH7reXOAaFhDMeB+9p6FoDAD8PNaW76TVUC5ZbtEE90EHuqAYjkLHyiZwI5NzeB6+6q5xjkDnYDhXxH8Ll+3pS5U04gQQlQY/yhvMesb0BD2YWfqba6/XgrW7k4Bwc8xzgWoB5C1vZ5G3b1RDPmhIfoYUaLK0qpCm2qlyQLv1yjQhZQWP7Qn/AMQmbO3XnTBjmf2Mv9SwXP7qMz4sOcVl10bDtb7x7h+5WTDopJfe4HeUSUGz5MoDsk3yxqYrPEjRA5CM6WaST9Z+A4/lbWn00cX6Oe/r/CgraRXeYgsHzL3ITbjn7wWKQYtU1ERb1WHRVZQlQE1RuE4CAxHEEGx6cNYckjDiCWjvtZsMzmWA891KKZMcxcClUmyo5g4+sWCqR3qsme5skKi5bXVDa4uPui11muyKgUuCBlcN+YHQv7x5OLmunrC9YwZo8esKrQ9mqZhM5MlKRiUVHPkkanrBJd7WWG7ieK/dVleWDAs+H7raFdIBIkSMQTnNWSom+bCwEJ9lLX919X0GP5S4ilIBlfV9Bj+VdFRgWA7CdLCMWiVg4Tp9vE9nva09xv4X6KTcCb8DfwXP969grROmCXcpUWCsy2p4vG5pdSC0b0R2hfPGJYyM9EF0O0JlLPE2SrCpPjY5pUDmND0jWkiZPHseLB9WsAl0MmMEeqXtrbQVUTDOUlKSc8IIHqTeOhhELdgPzV5pXTHtCPD14paCsKMlYecS9lq0Uu0XdJ+wdpqkTysXcKSQbO9724gRWeESMoqNJOYpSeUWbs7aKaxE5dwmQtbAZDEy21Ngr7MZuq09wlrf+4D6YWkZO1f7x/wv6rQ3wnKWvtEDEMlAa3056jkb52V0LWsbtd8E6WOawBue8eHgrOw9qhIldjm5e4BbI4sWgsSPSBzQu3OLiiOLZGVyO71/tD+97rmEqSFJBIxJLuoE2vlm7aRpaN1M8UnqWC+LH2PcshEkJlidiIZeHDZ3ZyRfpDBcXO2K0TmRf3M46LR2XNFSSjHgUGYKDlQ1CG/MBe9ucAkaYs8ps+0mytIY2vNbm6v7JMSubTSyJv8A3O8oMLgXIByy4iBalsoIbIceCytPKyT3wM+Kp7R7VanJ8zmdSYrHsbhOPa93koKUTVqGAOHYqLAc8L3UekS/YBn5Lo5Hg4yrlQpKEllJ7UAXUWThCgTa/eNg/K2sUYL6Gvqume85sBCqqUSxiBdOnMkB3OT/AEjSEhdg8rM7IM94cKmqYrNKTmzt89f6QShwShW//EKuoK1DCCAjohlr/wDIYUqQwyMUOUyygMBdArZUwJJPEO948/G5hNL1hIPCy1kOzXfO+XDPjDQuku8DdhbmyphQQ7t1zGn1hKcByu5u5qKFgLlOEuEMoJN7fm87HwjPadrtpPPVZrhtfnr6Cob7YSuVUoPdnIc9QMJjQ0+4+67mv9/VNey3kRuhd/ifocrmm9+zQCJyPhV8XyMbWilP6HLP9taTHbtHg79j+UMiNBedCcBEKwFJQq8dWFwPvWiPYtaUmWkS0zApM9BBYKw4cS8KjkcKlWNi0Izxg2Sa/SfjePqtNkpAaKBsOHjQomiimroDKCTLUpciYMUuZzDqZY0IZV7WDWaM7cHOO4e8OR4cWFp6aQFoYfXgrmxqJYK1ICkVRcCwCQghytVrYWscyWEAle11A5YM/Hu+KJMQOaz6HmqG2dgrCQC6yTiAI+IcWGbsOsMQ6loPcj9lHIyrukP7YpySmSEBU0ElWFySVN3eFm0hyB4ovJwk9WzdTWqalC6QESkdpUKDKULpljVAORVxL8uLw4tmNvNNHzPj5IAgljFMbbj8gsybWrpKpakfAtWMAW7qiSlhoQ7MYaaxs0IB5GPistzn6Wc/Za9XtRNQEkKN1BJWEks5AJUh+6Rfr6wm2AxE368lpf1LZWjb68+5atfVIl91KSLISggsLjFm13BD8PddkbnZJ70YPrCHN4e/LbUEnya3k/nDul91yU1zS9hQ/InLSNSjgcurcYec1pPisqN72Dw7lOuYkF0k8jx6jSKAE8o/aAZaUiZoD97Fd7YvmBE0T0UB4HJtKqZivh/mJ/0kR1V1Ul27NfNdU2tPMuSlTd5RZlA+BHG0eUgYHyFvQL1oOTXrwQ/KpSouqyifCNAvDRjhE2XlyI9l7NCmCDZnuf6RnTz7f1BCll2DIRHIkLCyUuhKU4lHRhw53aE2tEjT66rPe9hbnJJoIc2rVCfRzgAB2E0LSBkEzHCgOWIE+MasLSxzAe6k0yEwzA3+oV8R/BQyGmSihWRtDuWOsJzY2VhY7g4QJV0xlrKDmPUaGNljw9u4Lw+ogdBKY3dPr3FRqBFjFkI2MFeTHFcOVs7GKu0l4Q5AqCBzMlh6sIUnrab/APH/AOSfhDnPYGiz7/8A8V1XYC1CWUzEBMlQQpJf4JoACsIN8JIcEXHmY87PRPunIJ+I8VqugfuHf1C0qPa0qWRLSEsS6lX7zm+d/E36m8CfE9w3FFOieW7ifIevXlwre8cqwWgDEcz4QOF4LqPCHonZLXcIdp9hyZKStR75cqWT4kD6AQ46eSQ107kz2vvW0IK3u24f+nIGBP6gLnpw1yjU0emH6pMpHXayYN2xk+YQaZajcg3u/wA41bCwezfzS1N36U4u1UooQjNixWf0cxx5QvqX42AWT9PH8JrRQku7Qmmj6+H5W9UT8aSr4RiSAlxcspSl5XzT5wm1m3HK0i/cVn7RLpPP52gsXKFObaVQMgFLQxuINpQsBFKFTJFosLPKphowmYdYlRXVN7Z+cTtUbweF1reSehcr43KWAtlwjyOjY5snHK9dE0sskVaZscYwDhcjjwPDw1i+oO3Fq85rqjfZuz1C7BiAAkAe4jFkeX00CysOedpx9UlVtZCUVMoAEI7NGJ2xKIWVAcgwjVjgEUZDclxGfJdHpnudFIetmu4Ypc02rtdEiXMQhBBWMJPLgQ7ZxqQwGRwJOAtXUyCMBzs1x596wtlVoIY2hyaPOFOk1Ic3Kr7yUmJONIun/Kc/LPzi+kk2u2nqlvbOl7WLtW8t+38c/NZMkomyyhXdmpuhWixqhXPgYbO5jrHB5Hd4/leebtlZtdhw4Pf4H9is5MGKVbyjj8ONkdotc5f/AE5YCeqicRHkExj+1NRsaGDkrZ9mtIcZB3UPjz+yNtsz0hPdDBiTa9r+cZMDSTlbcDSMuKCqatWagFCSr8rcXtYcXjVdE3sqOEJ057Sxwj/aG1ihIBPaLI+EkMj94ixPp1jJjgBOMDv7/JAbHZ90V6+gQrtKrKy61Yj6DoI0ImbcNFIjg1gQ/KqSlZmMkliBiD8nh0sBbtSrZnNeXjlZdTVE2Fnt9YO1gGUnJK44UFRWAFCATgSQ443dXnF2x4LjyUCaYAhjeB6PzW/OmJWlKgSSWVkwD6C7H7yhIAtJCdsPorOr1MBzMHiFlCmNAKkuZBgEuSoVDWLoZHVNVziVBKhlWixyhMwul0tU5wLBUlLqCDoXuW1jzT4wBubyeq9wQDZHKKNirxS5kxCbpRjSCCMiHzzzBzhCSEudTjwkJ/1Na44JpVtlbcnGplYllTrTYFg2ZsLZAw32TGM90VSJrNNCyAhrfDxVnfSUiVTImS81zsSjnfCoN5+8RpPeIae78JbRTuMrmv6NofNcu2tVmYW43jbhYGi1GpkMh2qDZaXOFwHteLSmhajSAn3ThXJbpsYE6jkLRhLmYKyds7NwDtZfwk3A/KdPCGtPNuOx3P3WD7V0Ai/vRfpPI7j+FQloxFz4wZx2rMa0PyukbvbTRLo0JJSnCVZAfqNzxPOPP6mBz9QTz/peh0e1sQPAUO0NroKHxu9upgsenduqk2/URtZdhY1JtQSEFYIxrcJ/ujVXIkFvPjDT4TK7b0H18EkJWMYHPIzx+VF/6yTkot7mLjT1yFV+ta7DDhVqjaZIZ8/bWCthrKUdqLwop1awYWa0S2O1z5gBhY8ycVK55CGg0ALLfKXOtOkpAxhXxCw1u7ENr15RBvFLm0CQ7lTyKsoUnGSwADZsk3tx0PjFHRhwNIjZnMI3cD7FTbUnXTwYn1/pFIm4KLqH5CrIWT0gtUhB1pVqiAFLiq8xbxcBBc601LmJ4UNt3C6VV1CAoAkvnHm4mO2+C94XAYRjuXtAqWmWoskpVhyZiLvzGcKPhAeXfNZXtGL3C9vNhR0uzUU1YvER3JapktJ1sR4sH+xEukcWVXWiom1J1MDfE5XOl7eUqRNp5hJCldokn8q3c55pP14xsDTU9sjemPMJZr2HcCaKGjUHI+cP7Un254KfLXfrEEYRWSU411WjJWchccLQFwHVaUctYBwpplXKEtUtah3wxAu3DJ4GI3lwc0cIsup0xidFK4Z9dLWNKowD3ZySNbEFuQ1ht0hPLSsOPRNB92VpHXm/l/K0dl7dNPMUoIK04DLCcRSzqBxEgF8soDJpu1bV0btU1EhsBt7RgflTVG9ilfs6jKI7FaFABfxYUhJfuWcgnUXyLRDdGBuF/qB6cfVLF5DdxHkm1+9HaU3Yqkv/AGeB8ZsppYxthucUsqb+9yvMek2S7w7rfHnj60qyOLoxi1P/APm/eClUzgXA7Rg/9kUq+DMGSD4xT/0/FB308/HxQ+2PJb6x4eCG5k8KWpSEYEkkpS74Qcku12h4NIABNlTG88gKJayYkBWc4lRpUQQQ4IyPCLEA4QQXNNheSW+/WOXcK/NLFBAdRuVWY+WTX6QIdQmnctPJ71DVEqU+IrAbvX4XEWbgcUhvsuwbCckWfX/aIRAMZUi5BId4qH0Uc6Ylt2qSU3IzMFJxaRa0l1LWpkgDn0hV5JK3dOxrGo0qJyXAKUg2csL9TGLG01yvQkAFbmx5bFIIKQXD8AoEP0haU3dFKag4NeqUm9c1cyXKnFJxpJQpQzStFj/CoMfGLaeg8jofqkYWBpLB0yPIrnu2ZCVh/hX7xsad7mmuijWQRvZd077+CHjlGgsT/FTyUqSAouAcv6RQkHCMwuYLIweFPS0SJymU6TphYDInUHQfb2q+R0bbCoImzOAOPJeNHLE7sVFbOAkgh352iO1f2e8UrvhaHiIk9Mq1O2FNClCUxRl31By4u7WY3aKN1TCAX8+Cr2UzbawWOMkeqTpGxqgkBQTh1ZYBYZsSGy4xDtTCBYOfJWrUhtECvNTzdlSRMlyyqc0ziUAguwyDN98oGNRIWl1DHmriIkUSc+Vp0vYsozVScc2yQpJBTdwHB7vEhog6p4YH0Pqp7Ak7dxwvL3clENLnnFqCuWojS6Qxzz4Rw1jx+puPIj6of9M0mmvNofUDLKkLszhQ5jIj7yMPAh4BahMd2Vtfx18xwR64Ku1Oz5fZCdJUpQzIJFm+IWAuM+l4CyZ2/s5AB6/dT2TdnaxkmuUuz6FNQFKViSA3eSQAVZqsRwY8n526SQxUAiAN1Rs46kjv9ZWbUBKSQhyNCc24+PtDDbIspN+1vut9BTy57ywgMFJWQP3ZiSFHwb1EVLadfT8KweXN2jm8eRGV7AyWHEx12bKuBTaCiqbMT5evhEtzgKsprJSftSmjuzFog1b9tAKTZkpKlMteAMS5BNxpbjFZS4C2i1bRMY59PNK7JFuEBctWMYRd2Ll2jI3UKW8QOUT7HWteFC0uk3fi3E639Yzpw1tuacpHUBrbc05RTTUqVY0K+GYGP74DA+KbfwjjC8UliryMhZD3ltOHI+38fuuQb37MMpakB2ckdHj0eimD2gpnVN7SOwfFY9NRiUgT5yXKrypZ/N/3FD9HD9R5Q06QyO7Nh45Pd4Dx+yQjaI29o8eQ71nz56lF1FyftmhhrQ0UECSRzzbitfc6RjqAnn/omfSFtc7bAT5fcKITTwVvr3ZpRU4jPV2uMHBiS2J7JbC/AM8Zw1s/Y0GDbXOfyju01v7Y33+CSRQk7QnS9BKBb+Qj3PnHOlA0jXeP5Ry6iHeH7pK2ikGXMx105SfzITMQXvZIGDjZuV7CLxyShzdsTQehr68pd2m343Oz4/wm7XoiKqlSouSRfqvlHQSgwyEesIzQasm6Viio/wDmSkNlL/0pgb5P+IHeP5Ul3LvH9l6k3eo01BUJ2KbiX3CtPxkkEABIL3IYkxZ+r1DoaLfdoZ8PmgM04a/tRfU+CzJ+ykSu0qJ7KJWQlg7McIAB1cZ8oOzUOk2xRYxlc2Nm4ySZN47lb2TLlTkKVKFwwWggAtfCQRmM76Hkbinc+MgP+BRsD3mij4fYrP3mlJppaZKbAgm36HOXUn3g+kcZ373dEF7mRxlrBQ5+aDSty5jXqll7iTZT6QFy2bGKuqsq0IJdYWj2iUIAChiT8Vg9wCw5g2doDRc7jCb3MY2ryOf4VHEVXPF/f6wXA4QWgvyUyZEhVkxhPkxDkSLCvSCWYgHXK8AcBeFqQudtpwvrwukbCkGchWJQZAxF8/sh2jz2pf2ThQ5W5NLsqhk4RjsenThShLWF+IB0aMfUOduLj1WVqHncXOW1LkgM2j/WE+0cDaRc4lYm+OyadaBUzR3UB1JGaiPy9CY3YZnYMR/V9D1RtLK8XEfn3Lie3K9U6YqYohzYDQAZADQCPSaeIRsDQlp5NzrWMpcNUlC5FX4apxViR1/+ubCHtTGmd8PuFaM8ladRK/5qE/8A9CR/iEJtP/D/APafstt//wCMD4BEWz6T/nM9P/ZHtKhKR3/Bb5/lJSH+wx3n9yuaz5aiqYsIVgC1JxscOJycOLJ2BLco3gQGgE5rjqrwzNkkLGj4roG+CMG0KEYVKslRCEqUQkTO8cKQSWEY2iaXaaXPfzjolhqWsa4HkpkuuQNrKmYVmWZEtbpQpTBcpBSVN8LvmWEWMDjog2xdkc9xKr27dnZ9bQ3M2NU1NZUIppZOGfNCphshH9orNXEZsLw+2SOKBjpTXujHU4Rv64NYGsGfsjXblLRqK6OomsSy8WWFSiVXVcBTuq9mUBGTpzO2pox4V3jj5dPgoGmklj3Btgn4+rWbS01FQpKJEwzps0hJViCiASzkpGFIDu2ZPoeR+o1RBeNoCtBopRZIPx8Fk/inJ7OYgAZSrfzloZ9kG2Hz/YIDjcT3eX3XOXjdWZeFMiawZIucyflwipF8orX7RTeSohnEoY5VlKrRQhONdQUSy5iwGEB7rcrNMloG9OadtBW0X1aBFPNzi11bY9FMlrSlbJSoAOAWUwcdY8vqJWSMJbkj6LXnkY9hLeR9EaUcog2ZiPGMV7gRlYsjgRlW0oMUa3caCCXALmn4l7zJI7FB7ot1POPUezNHR3V5eu8poDsYiXfqK5LPnEmPStbhY0jzagxRZA3ZRh+GNZLlVYmTDhQl3LE5y5gFhe5IEZ3tNhfBtHJ/ITukifNvYwWaH3W0doSlbVE3FhR2yZhfNKQpLlQDt0z5QkIXt023wpbnumH+nabeG8DP1RBQ7epxtSfUlREvscA7pxFQ7OwSLh8JN2tCz9O/+nbH4390F2ildpmxtokHORjk5Kwd697U1ZTTSpaUS0kqSlIFilKrkjuiz2S/WGtPozEDI45U6JkEUojDtzjYscDF/HhGm0t96ftUypOSsKVziPhQTcpSQ6mckOGfQwhHonBu53y8UCP2TIWu3H36sNBz8e5Vkby0iv8AhE4pdOlAQuYWMxfZpSEoYA3ICQ5u2ic4v/TvB7R2XHIHTKj/ANJeYyWuDnAgEA4HmVh70fiZ8UukSJYc3S2IklyXHdQSXyxHmIa0/sy/ekVBHp4OT2ju4fp+fVcxrqyZMXiWS7k56nMu7k83jajY1raaktRNLI/c/pxXA8lrbnzQZ5UtVgEOSSWHbSifaAasUyh6wU37O3SyOySdp62t38VNtyKiaOyJOFGG4Z++S4GYF9W6Qp7L08kbfe7/ANlSZgggcyQjeawM1R69FzyNhZKcMohWvCQGJUAqUqitIpdhIgRJUNGVakmBOCeidhTS1RQhMxuPC7lsacqcmWtRKchhIyYB1Dg/CPEztbES0fP9vgnpaYCAPH+EVS5Rbu+cZuSaCzC4XlCe+u9suTKUiWvErIkGNvQaFz3Cxjv7/XRMQRho7WTjuXEa6vXOUVZh+UetihbGKSc+qdM6xws9chZPw+0HBCQex5PCgNjeLIV0cq7TGakHASnEwLEAlueYz0gbg08pqMSC9ti+VJT9oi6HS4Zw2VvLKKuDXYKKwPZluEqFTAnACQlRcjjpfj0jiGk31UgvDdvQ9FXlVCkKxJOFQcPwcEHPkTFy0OFFBEjmP3NNEJ0uuWnFhWQVfEXufHOIMbTVhcJ3i6NXz4pZM9eEy0qOElyBZ8hfjpaILW3uPKsx7i0sBweR+Uokq4R1hXDSlmSV5jPwjgQuex5yF6mXMQVBFiQAWbJwc9LgRzg13KiJ8rCdmD1pQVSCLkNF2kIEzSACVXiyClEcpCmNMpnb2iu4IhhcOi8JKmy9o6wuDHEcJ4lKFyIgkIrWkZKeiKlHYrEk5wNyZiPJX0VsqiKVWXiSO6Muly2cfPpJO0obclGnlDm5FHlQ727xIpUFAUMZFzw5Q3p9IXu2t+J7/AeH3UaPS9qe0kw1cH2vtMTVl1Ob2Yn2Eez08PZtQNZqWudtaqImBtf5VdOHF4PSTDxX8FO7YHj/ACq+kdRXdo0n+CozMDZH+VX0iaVdwrr8ipETRYX/AJVfTpFSCiMe3j9ivGaAGNrHQ/SOoq28AV+V4zBzt/dV9I6lxePQKQzRzz/Sr6RNKm8H/R/CRKw2uX6Tn5RxCgOFfwUvbpf+h49I7aVYSNtPMwc8/wBKuPSK0iF49AryJwfXhkb+kSQobICf9ryVh9dNDy5dYilYEWlUvKx8j9I4KHG8KMkWz1/KeI5RZDIHX7JwV1/lP0iFINH+ClRMBTa/gT7CIrKuCC3CalYAa/kr6RblDsDH7FRVC+7rnwI9xEgZVHv93+Copa44hWjeFMma0ULUy2UNX0+EYAVuwDq6nT6x83iOd3d91N7yGr5+3+2itc5Qc5kmPc+yoGsiBR/akpa1sTVgIUgMbekaVFZYcwZUiJiWFxr7mIoqwe2ufVpktQGK+vyESVVpABz1/CVcxLG4yaOAKkubRTsacTuPtvpEUaU7m7rv1hNXMTqRkW9PpHAFc57e/wBYT+1TxHz0jqKtvb3qOWod7L4iRfTl7xJVGkZ816VMHec6m3K2UcQua8Zs9U502yLA/KIyr+6pCsOLj7eIViRYUa1BhlYRI5VXEbQpBMFr/d4ghXa4Lypo4jz6xwC50gHVRSJrkvYA284kjCEx+52VYQoNplFDdplu2lHIWHItoeXP2ixCHG4WnmYkWfKIoqxc0YUM9ik3GcSOVR4BaqZS0ES9UvPELrX0FJ29MmzihKHkqLB7EHUv8o8E/SMjhtx94ZXoTpGxs3E+8FzXfbZikTlK0JufaPS+y9Q18Qah66Lc0SN7ghMkWvqfnGusUkJFzLgOL4vrHAKHOyB32lxc+GvOOU3XX1a8nM34ZnpHdFw557k5arZ3ca+sQFZxUS0gqBJZrxIQ3AFwNqYrHH16xWkXcO9NmTLhjmSM4kBVc/IpLjFrix49frHUp3DGfWUiV53GfyEdSkP5ypCqwv6xFK+602cQbODfjHDChxDsKRAAGenyipKKAAE2eQ2f3aLNQpa70qVB8+GsQVZpFpqVADPj84khcHAdU5ZFr68eRiApdRrKQzM7+v3yjqUb05Kha4y4xFK4INKvXqy8flF2IMx4VJ4ulrX06mShCTYd1JNm+xHzPeXOHiVrve45QNtqlTMQVC5YlQ5Dxj0MDnMfSZ00tDY/hc52pRdmrKxNvOPQwS72pLVwCN2OCqaU3H3w/rBrSgblRhPeJY6ac4noq17xPknSxZ21On3zjipbxabMV3sLcD7Rw4XSH3qpSLTkw14RAUkdyRSbi3HTpHLiMjC8E8teESuAShP23lEKQEyapiA2Y8mf6xI4UPNOqlIrVh6dIgK5qsLyU38OHSO6LmjKVamSC3D5xXqiF1NUazkeL+0WCC48FOIvlpwjlYpxTlb8x00YxCkjI80gyPTh0jlHQqJErCGz1i12UPbtFKTQ2+7xCsOCvVI7p+kQ3lXefdKzDBkiQvon9plrUmWSQqZ3Sxa4BdNsiwHmY+eCN7Wl4GB6tejLXMBd3Lc2ZIDKWR+UpHQs455RfSvrd5fdIzvOGjvtc432kSyhRJGIXZshoY1PZ5e1wrgrVY5rmlrugXJ6mQAM+Yj1LHElec1MLQMFUmgyzylw8o5dRV2lYpYgE5ZCBOwU7GA+PhWVyk/pHkIqCUQsb3D5KjWgYrBraBoI3hKzAB2AifcrZ0ubT1xWhClCVhl4mcL7OdMdD/maVpdnhDWyuZJGATV58rAz81aJoLXX3flGNHRUSqyXJEmSVIkJMxPYJZ5i6TBidICiQuZ3g5AWekZj5JxCX7jk4z3B9/YY60mQ2Mvqhx3eSyZO70udJMtKJaFmmkqxYQWP7ROxlwHJKUYX1DQy7UujfuJJG44/9or6m1Gy20O4fdY26FNLVJxGnTOX+1yUAEOVBUuayC7gJxAKNtLuwhnWPcH1uobSfkRnzQI6IuryPssjegyzVzuxSEy8TJCUhIsACUpGQJBI5GGdLvELd/K51bjSrUZBsRe5yEEcmIj0UyZCf0jyHGI3FT2bT0WfNz8YIEs9JhPA+Ucq54Tko5RBVwEkxJOhPgYkKrxaZgI0PlEodEdE0WMdyoHulPeOV7X0Vs7Y4Ku1mulSCbmwOV8J0d/6x87l1JDezZkFelm1ONjM2tymqwuWspLh2t0/rERMMbTfWkk+IteAQub/AIjTQmmADDED7tG17LBdNnonXioZD5BcmkqL4XIfK8eodgWsBmXbSeVDPxA4ST5xdpBFhLzNexxY5NE1X6j5mJoIe93epaNV2irxi0zpHe8W96fiZXeJZjqeBbLnEDIwucNklPJrPf3Y+qctco8SeJJ/R/5+kRTvXn+FYuhPffx/7f8A+voppdUEOJa1p1AClDvYQl7HNlTR0LZGKll/qA9egpPZZ239e4f/AGVhVcy1LRMmhZBGLGsKYFHZgqdy2EfyjgIp2dgAgV5DxtGcIbO2+vf4UohtOalPdnTQpgktMWO66yU2OVwW5nnFuyYTlo+Q8EFxG3HPx8b/AGTZVX2ZR2cyYgYypWFShYFkqDH4sBUHzueMSWbr3AHHr6qXdkC3bdWb8rx9FNPnyZiipapilHC6lFSiWZy5LkkOL5YecVa17RQApMf8Qnr07/C/nkeFeKiKpIxEYgT8Odi1wq9w+TeMT7+FUnTgEi/DnGOue/j64VPtDxPmYJSV3HvUS1OYtSE51lKFtHUpDgEvaniYilO8lNM08T5mJACoXnvXisnMk+JjqUbieSvLjgrv4SRyi8L6Nm1Z7Oc9wlSgBlZLsLdI+dNjG9tdaXqRGN7K6gfVWNirH7JZOEBSg3QC8MTNIOTdoepB/qMnuXOPxVU0uSkZfUqMbXsb9biq60/8YnvcPsuZpWxyePR1a86H7XXSeBiT0BI84rwUWu0jz0F/VV4Ik1JJN4q7hFhNPBVusR3X4QKM5paOsYDGHdVTEFWaFIkRBRmhKoxACs41hNBiUMG16OUrwjlwTo5WTVRyqUxUShFIBEqAEsQpSRKjqlEQpCcTHK5TI5U6L//Z', 'https://youtu.be/dt5g5_1cKVk', 'https://www.hellboy.movie/');
INSERT INTO movies(movie_id, title, releaseDate, rating, runtime, director, synopsis, mainImage, trailerLink, officialSite) VALUES (7, 'Captain Marvel', '03/08/2019'::DATE, 'PG-13', 120,'Anna Boden','Captain Marvel is an extraterrestrial Kree warrior who finds herself caught in the middle of an intergalactic battle between her people and the Skrulls. Living on Earth in 1995, she keeps having recurring memories of another life as U.S. Air Force pilot Carol Danvers. With help from Nick Fury, Captain Marvel tries to uncover the secrets of her past while harnessing her special superpowers to end the war with the evil Skrulls.', 'https://upload.wikimedia.org/wikipedia/en/8/85/Captain_Marvel_poster.jpg', 'https://youtu.be/Z1BCujX3pw8', 'https://movies.disney.com/captain-marvel');


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
--INSERT INTO showtime(showtime_id, movie_id, theater_id, dateTime) VALUES (1, 1, 1, );

--INSERTIONS INTO OUR THEATER TABLE 
INSERT INTO theater(theater_id, totalSeats) VALUES (1, 160);
INSERT INTO theater(theater_id, totalSeats) VALUES (2, 120);
INSERT INTO theater(theater_id, totalSeats) VALUES (3, 120);
INSERT INTO theater(theater_id, totalSeats) VALUES (4, 120);
INSERT INTO theater(theater_id, totalSeats) VALUES (5, 120);
INSERT INTO theater(theater_id, totalSeats) VALUES (6, 120);



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

COMMIT TRANSACTION;