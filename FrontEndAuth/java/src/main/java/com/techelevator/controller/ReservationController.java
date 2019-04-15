package com.techelevator.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.techelevator.authentication.AuthProvider;
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
import com.techelevator.model.reservation.SeatData;

@RestController
@CrossOrigin
public class ReservationController {
	
	@Autowired
	ReservationDao reservationDao;
	@Autowired 
	ShowtimeDao showtimeDao;
	@Autowired 
	MovieDao movieDao;
	@Autowired
    private AuthProvider authProvider;
	
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
	public Reservation bookSeats(@RequestBody SeatData seatData,
		    HttpServletRequest request
		    ) throws UnauthorizedException, JsonParseException, IOException {
		
		User currentUser = (User) authProvider.getCurrentUser();
		Showtime theShowtime = showtimeDao.getShowtimeById(seatData.getShowtime());
		
		Reservation placedRes = reservationDao.requestSeats(seatData.getSeats(),currentUser,theShowtime);
		
		if(placedRes.getReservationId()==0) {
			throw new UnauthorizedException();
		} 
		
		return placedRes;
	}
	
	@RequestMapping(path="/seats/book",method=RequestMethod.PUT)
	public Reservation confirmSeats(@RequestBody Reservation reservation,HttpServletRequest request) {
		return reservationDao.confirmReservation(reservation);
	}
	
	@RequestMapping(path="/seats/book",method=RequestMethod.DELETE)
	public Reservation undoSeats(@RequestBody Reservation reservation,HttpServletRequest request) {
		return reservationDao.removeSeats(reservation);
	}
	
}
