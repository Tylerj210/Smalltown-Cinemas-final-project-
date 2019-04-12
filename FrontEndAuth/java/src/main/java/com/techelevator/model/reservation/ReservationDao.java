package com.techelevator.model.reservation;

import java.util.List;

import com.techelevator.model.user.User;

public interface ReservationDao {

	List<Seat> getSeatsByTheater(int theater);
	List<Seat> getAvailableSeats(int theater,int movieId,int dayOfYear,int hour,int minute);
	List<Reservation> getReservationsByUser(User user);
	Reservation getReservationByResId(int id);
	Reservation requestSeats(List<Integer> seatIds);
	int confirmReservation(Reservation theReservation);
	
}
