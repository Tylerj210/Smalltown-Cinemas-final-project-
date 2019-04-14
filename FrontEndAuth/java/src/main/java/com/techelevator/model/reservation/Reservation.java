package com.techelevator.model.reservation;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

public class Reservation {
	
	private int reservationId;
	private LocalDate bookingDate;
	private LocalTime bookingTime;
	private boolean finalized;
	private int userId;
	private int showtimeId;
	private int confirmationNum;
	private List<Ticket> tickets;
	
	/**
	 * @return the confirmationNum
	 */
	public int getConfirmationNum() {
		return confirmationNum;
	}
	/**
	 * @return the tickets
	 */
	public List<Ticket> getTickets() {
		return tickets;
	}
	/**
	 * @param tickets the tickets to set
	 */
	public void setTickets(List<Ticket> tickets) {
		this.tickets = tickets;
	}
	/**
	 * @param confirmationNum the confirmationNum to set
	 */
	public void setConfirmationNum(int confirmationNum) {
		this.confirmationNum = confirmationNum;
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
	 * @return the bookingDate
	 */
	public LocalDate getBookingDate() {
		return bookingDate;
	}
	/**
	 * @param bookingDate the bookingDate to set
	 */
	public void setBookingDate(LocalDate bookingDate) {
		this.bookingDate = bookingDate;
	}
	/**
	 * @return the bookingTime
	 */
	public LocalTime getBookingTime() {
		return bookingTime;
	}
	/**
	 * @param bookingTime the bookingTime to set
	 */
	public void setBookingTime(LocalTime bookingTime) {
		this.bookingTime = bookingTime;
	}
	/**
	 * @return the finalized
	 */
	public boolean isFinalized() {
		return finalized;
	}
	/**
	 * @param finalized the finalized to set
	 */
	public void setFinalized(boolean finalized) {
		this.finalized = finalized;
	}
	/**
	 * @return the userId
	 */
	public int getUserId() {
		return userId;
	}
	/**
	 * @param userId the userId to set
	 */
	public void setUserId(int userId) {
		this.userId = userId;
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
	
	

}
