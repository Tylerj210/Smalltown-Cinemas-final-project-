package com.techelevator.model.reservation;

public class Seat {
	
	private int seatId;
	private int theaterId;
	private int seatNumber;
	
	/**
	 * @return the seatId
	 */
	public int getSeatId() {
		return seatId;
	}
	/**
	 * @param seatId the seatId to set
	 */
	public void setSeatId(int seatId) {
		this.seatId = seatId;
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
	 * @return the seatNumber
	 */
	public int getSeatNumber() {
		return seatNumber;
	}
	/**
	 * @param seatNumber the seatNumber to set
	 */
	public void setSeatNumber(int seatNumber) {
		this.seatNumber = seatNumber;
	}

}
