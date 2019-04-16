package com.techelevator.model.movie;

import java.util.List;

public class Viewing {
	private Movie movie;
	private List<Showtime> showtimes;
	private int theaterNum;
	
	public Viewing(Movie movie,List<Showtime> showtimes,int theaterNum) {
		this.movie=movie;
		this.showtimes=showtimes;
		this.theaterNum=theaterNum;
	}
	
	public Viewing() {
		
	}

	/**
	 * @return the theMovie
	 */
	public Movie getMovie() {
		return movie;
	}

	/**
	 * @param theMovie the theMovie to set
	 */
	public void setMovie(Movie movie) {
		this.movie = movie;
	}

	/**
	 * @return the showtimes
	 */
	public List<Showtime> getShowtimes() {
		return showtimes;
	}

	/**
	 * @param showtimes the showtimes to set
	 */
	public void setShowtimes(List<Showtime> showtimes) {
		this.showtimes = showtimes;
	}

	/**
	 * @return the theaterNum
	 */
	public int getTheaterNum() {
		return theaterNum;
	}

	/**
	 * @param theaterNum the theaterNum to set
	 */
	public void setTheaterNum(int theaterNum) {
		this.theaterNum = theaterNum;
	}
	
}
