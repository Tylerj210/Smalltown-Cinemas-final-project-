package com.techelevator.model.movie;

import java.util.List;

public interface MovieDao {

	public List<Movie> getAllMovies();
	
	public Movie getMovieById(int id);
	
	public List<String> getGenreList(int id);
	
	public List<String> getActorList(int id);
	
	public List<Integer> getAllIds();
	
}
