package com.techelevator.model.movie;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;



public class Showtime {
	
	private int showtimeId;
	private int movieId;
	private int theaterId;
	private LocalDate date;
	private LocalTime time;
	private double price;
	
	
	/**
	 * @return the price
	 */
	public double getPrice() {
		return price;
	}

	/**
	 * @param price the price to set
	 */
	public void setPrice(double price) {
		this.price = price;
	}

	public Showtime(int showtimeId, int movieId, int theaterId, LocalDate date, LocalTime time) {
		super();
		this.showtimeId = showtimeId;
		this.movieId = movieId;
		this.theaterId = theaterId;
		this.date = date;
		this.time = time;
	}
	
	public Showtime() {
		
	}
	/**
	 * @return the time
	 */
	public LocalTime getTime() {
		return time;
	}
	/**
	 * @param time the time to set
	 */
	public void setTime(LocalTime time) {
		this.time = time;
	}
	/**
	 * @return the showtimeId
	 */
	public int getShowtimeId() {
		return showtimeId;
	}
	/**
	 * @param showtimeId the showtimeId to set
	 */
	public void setShowtimeId(int showtimeId) {
		this.showtimeId = showtimeId;
	}
	/**
	 * @return the movieId
	 */
	public int getMovieId() {
		return movieId;
	}
	/**
	 * @param movieId the movieId to set
	 */
	public void setMovieId(int movieId) {
		this.movieId = movieId;
	}
	/**
	 * @return the theaterId
	 */
	public int getTheaterId() {
		return theaterId;
	}
	/**
	 * @param theaterId the theaterId to set
	 */
	public void setTheaterId(int theaterId) {
		this.theaterId = theaterId;
	}
	/**
	 * @return the date
	 */
	public LocalDate getDate() {
		return date;
	}
	/**
	 * @param date the date to set
	 */
	public void setDate(LocalDate date) {
		this.date = date;
	}
	

}
