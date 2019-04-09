package com.techelevator.model;

import java.util.List;

public interface ShowtimeDao {

	
	public List<Showtime> getAllShowtimes();
	public List<Showtime> getShowtimesByMovieId(int id);
	
}
