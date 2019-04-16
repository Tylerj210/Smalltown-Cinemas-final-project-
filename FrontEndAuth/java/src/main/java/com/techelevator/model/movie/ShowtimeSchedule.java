package com.techelevator.model.movie;

import java.time.LocalDateTime;

public class ShowtimeSchedule{
	private int days;
	private int theaterId;

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
	
}
