package com.techelevator.model;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

public interface ShowtimeDao {

	
	public List<Showtime> getAllShowtimes();
	public List<Showtime> getShowtimesByMovieId(int id);
	public List<Showtime> getShowtimesByTheaterAndDay(int theaterId,LocalDateTime day);
	public List<Integer> getTheaterIds();
	public List<Viewing> groupTimesWithMovies(LocalDateTime day);
	
}
