package com.techelevator.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.techelevator.model.movie.Movie;
import com.techelevator.model.movie.MovieDao;
import com.techelevator.model.movie.Showtime;
import com.techelevator.model.movie.ShowtimeDao;
import com.techelevator.model.reservation.ReservationDao;
import com.techelevator.model.reservation.Seat;

@RestController
@CrossOrigin
public class ReservationController {
	
	@Autowired
	ReservationDao reservationDao;
	@Autowired 
	ShowtimeDao showtimeDao;
	@Autowired 
	MovieDao movieDao;
	
	@RequestMapping(path="/seats/{showtime}",method=RequestMethod.GET)
	public Map<String, Object> allSeats(@PathVariable int showtime){
		Map<String, Object> showtimeData = new HashMap<>();
		Showtime theShowtime = new Showtime();
		theShowtime=showtimeDao.getShowtimeById(showtime);
		List<Seat> seats = new ArrayList<Seat>();
		Movie movie = new Movie();
		int theater = 0;
		theater = theShowtime.getTheaterId();
		seats=reservationDao.getSeatsByTheater(theater);
		movie=movieDao.getMovieById(theShowtime.getMovieId());
		showtimeData.put("seats", seats);
		showtimeData.put("showtime", theShowtime);
		showtimeData.put("movie", movie);
		return showtimeData;
		
	}
}
