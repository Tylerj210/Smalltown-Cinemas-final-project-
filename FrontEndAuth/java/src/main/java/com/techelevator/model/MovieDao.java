package com.techelevator.model;

import java.util.List;

public interface MovieDao {

	public List<Movie> getAllMovies();
	
	public Movie getMovieById(int id);
	
}
