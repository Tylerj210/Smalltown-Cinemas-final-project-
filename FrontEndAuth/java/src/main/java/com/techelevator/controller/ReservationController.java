package com.techelevator.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.techelevator.model.reservation.ReservationDao;
import com.techelevator.model.reservation.Seat;

@RestController
@CrossOrigin
public class ReservationController {
	
	@Autowired
	ReservationDao reservationDao;
	
	@RequestMapping(path="/seats/{theater}",method=RequestMethod.GET)
	public List<Seat> allSeats(@PathVariable int theater){
		List<Seat> seats = new ArrayList<Seat>();
		seats=reservationDao.getSeatsByTheater(theater);
		return seats;
	}
}
