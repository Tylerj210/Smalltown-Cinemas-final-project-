package com.techelevator.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.techelevator.authentication.RequestAuthProvider;
import com.techelevator.authentication.UnauthorizedException;
import com.techelevator.authentication.UserCreationException;
import com.techelevator.model.user.User;
import com.techelevator.model.movie.Movie;
import com.techelevator.model.movie.MovieDao;
import com.techelevator.model.movie.Showtime;
import com.techelevator.model.movie.ShowtimeDao;
import com.techelevator.model.reservation.Reservation;
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
		Showtime theShowtime = showtimeDao.getShowtimeById(showtime);
		Movie movie = movieDao.getMovieById(theShowtime.getMovieId());
		int theater = theShowtime.getTheaterId();
		List<Seat> seats = reservationDao.setSeatAvailability(showtime,reservationDao.getSeatsByTheater(theater));
		
		showtimeData.put("seats", seats);
		showtimeData.put("showtime", theShowtime);
		showtimeData.put("movie", movie);
		return showtimeData;
		
	}
	@RequestMapping(path="/seats/book",method=RequestMethod.POST)
	public String bookSeats(@RequestBody int showtime,
			@RequestBody Seat[] seats,
		    HttpServletRequest request
		    ) throws UnauthorizedException {
        
		User currentUser = (User) request.getAttribute(RequestAuthProvider.USER_KEY);
		Showtime theShowtime = showtimeDao.getShowtimeById(showtime);
		
		Reservation placedRes = reservationDao.requestSeats(seats,currentUser,theShowtime);
		
		if(placedRes.getReservationId()==0) {
			throw new UnauthorizedException();
		} 
		
		return "success";
	}
	
}
