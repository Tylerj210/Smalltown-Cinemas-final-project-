package com.techelevator.model.reservation;

public class Ticket {
	private int ticketId;
	private int seatId;
	private int reservationId;
	private double price;
	/**
	 * @return the ticketId
	 */
	public int getTicketId() {
		return ticketId;
	}
	/**
	 * @param ticketId the ticketId to set
	 */
	public void setTicketId(int ticketId) {
		this.ticketId = ticketId;
	}
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
	 * @return the reservationId
	 */
	public int getReservationId() {
		return reservationId;
	}
	/**
	 * @param reservationId the reservationId to set
	 */
	public void setReservationId(int reservationId) {
		this.reservationId = reservationId;
	}
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
	
	
}
