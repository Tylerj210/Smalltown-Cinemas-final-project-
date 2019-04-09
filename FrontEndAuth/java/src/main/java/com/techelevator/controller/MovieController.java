package com.techelevator.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.techelevator.model.Movie;
import com.techelevator.model.MovieDao;

@RestController
@RequestMapping("/api")
public class MovieController {

	@Autowired
	private MovieDao moviedao;
	
	 @RequestMapping(path="/movies", method=RequestMethod.GET)
	    public List<Movie> getAllMovies() {
		 	List<Movie> movies = new ArrayList<Movie>();
		 	
		 	movies = moviedao.getAllMovies();
		 	System.out.print(movies.size());
		 	return movies;
	 }
	
	
	
	
	
	
}
