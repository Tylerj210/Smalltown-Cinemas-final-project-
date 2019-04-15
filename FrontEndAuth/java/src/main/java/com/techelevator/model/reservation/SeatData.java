package com.techelevator.model.reservation;

import java.util.List;

public class SeatData {

	private List<Integer> seats;
	private int showtime;
	/**
	 * @return the seats
	 */
	public List<Integer> getSeats() {
		return seats;
	}
	/**
	 * @param seats the seats to set
	 */
	public void setSeats(List<Integer> seats) {
		this.seats = seats;
	}
	/**
	 * @return the showtime
	 */
	public int getShowtime() {
		return showtime;
	}
	/**
	 * @param showtime the showtime to set
	 */
	public void setShowtime(int showtime) {
		this.showtime = showtime;
	}
	
}
