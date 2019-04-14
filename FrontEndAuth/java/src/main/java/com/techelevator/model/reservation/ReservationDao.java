package com.techelevator.model.reservation;

import java.util.List;

import com.techelevator.model.movie.Showtime;
import com.techelevator.model.user.User;

public interface ReservationDao {

	List<Seat> getSeatsByTheater(int theater);
	List<Seat> setSeatAvailability(int showtime, List<Seat> seats);
	List<Reservation> getReservationsByUser(User user);
	Reservation getReservationByResId(int id);
	Reservation requestSeats(Seat[] seats, User user, Showtime showtime);
	int confirmReservation(Reservation theReservation);
	
}
