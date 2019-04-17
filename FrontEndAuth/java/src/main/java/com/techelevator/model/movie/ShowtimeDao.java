package com.techelevator.model.movie;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

public interface ShowtimeDao {

	public List<Showtime> getAllShowtimes();
	public List<Showtime> getShowtimesByMovieId(int id);
	public List<Showtime> getShowtimesByTheaterAndDay(int theaterId,LocalDate day);
	public List<Showtime> changeShowtimesByTheaterAndDay(int theaterId,int movieId, LocalDate day,List<SimpleHourMinTime> times);
	public List<Integer> getTheaterIds();
	public List<Viewing> groupTimesWithMovies(LocalDate day,MovieDao movieDao);
	public Showtime getShowtimeById(int id);
	public Showtime removeShowtimeByTheaterAndDay(int id,LocalDate date);
	public Viewing getViewingByTheaterAndDay(int theaterId,LocalDate day,MovieDao movieDao);
	
}
