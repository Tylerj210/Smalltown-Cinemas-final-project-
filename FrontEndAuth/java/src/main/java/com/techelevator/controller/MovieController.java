package com.techelevator.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.techelevator.model.movie.Movie;
import com.techelevator.model.movie.MovieDao;
import com.techelevator.model.movie.ShowtimeDao;
import com.techelevator.model.movie.Viewing;

@RestController
@RequestMapping("/movie")
@CrossOrigin
public class MovieController {

	@Autowired
	private MovieDao movieDao;
	@Autowired
	private ShowtimeDao showtimeDao;
	
	@RequestMapping(path="/movies", method=RequestMethod.GET)
    public List<Movie> getAllMovies() {
	 	List<Movie> movies = new ArrayList<Movie>();
	 	
	 	movies = movieDao.getAllMovies();
	 	System.out.print(movies.size());
	 	return movies;
	}
	 
	@RequestMapping(path="/movies/{id}", method=RequestMethod.GET)
	public Movie getMovieById(@PathVariable int id) {
		Movie movie = new Movie();
		movie = movieDao.getMovieById(id);
	 	return movie;
	}
	
	@RequestMapping(path="/viewings", method=RequestMethod.GET)
	public List<Viewing> getTodayViewings(){
		List<Viewing> viewings = showtimeDao.groupTimesWithMovies(LocalDate.now(),movieDao);
		
		return viewings;
	}
	@RequestMapping(path="/viewings/{days}", method=RequestMethod.POST)
	public List<Viewing> getDayViewings(@PathVariable int days){
		List<Viewing> viewings = new ArrayList<Viewing>();
		viewings=		showtimeDao.groupTimesWithMovies(LocalDate.now().plusDays(days),movieDao);
		return viewings;
	}
	
	
	
}
