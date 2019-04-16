package com.techelevator.model.movie;

import java.util.List;

public class SimpleResTime {

	private int movieId;
	private int days;
	private int theaterId;
	private List<SimpleHourMinTime> times;
	
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
	 * @return the days
	 */
	public int getDays() {
		return days;
	}
	/**
	 * @param days the days to set
	 */
	public void setDays(int days) {
		this.days = days;
	}
	/**
	 * @return the time
	 */
	public List<SimpleHourMinTime> getTimes() {
		return times;
	}
	/**
	 * @param time the time to set
	 */
	public void setTimes(List<SimpleHourMinTime> times) {
		this.times = times;
	}
	
}