package com.techelevator.model;

import static org.junit.Assert.assertEquals;

import java.util.ArrayList;
import java.util.List;
import java.sql.SQLException;

import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import org.springframework.jdbc.datasource.SingleConnectionDataSource;

import com.techelevator.model.movie.JdbcMovieDao;
import com.techelevator.model.movie.JdbcShowtimeDao;
import com.techelevator.model.movie.Showtime;
import com.techelevator.model.movie.ShowtimeDao;
import com.techelevator.model.reservation.JdbcReservationDao;
import com.techelevator.model.reservation.ReservationDao;
import com.techelevator.model.reservation.Seat;
import com.techelevator.model.user.User;

public class ReservationTest {

	protected static SingleConnectionDataSource dataSource;
	private ReservationDao reservationDao;
	private ShowtimeDao showtimeDao;
	
	
	/* Before any tests are run, this method initializes the datasource for testing. */
	@BeforeClass
	public static void setupDataSource() {
		dataSource = new SingleConnectionDataSource();
		dataSource.setUrl("jdbc:postgresql://localhost:5432/theater");
		dataSource.setUsername("postgres");
		dataSource.setPassword("postgres1");
		/* The following line disables autocommit for connections 
		 * returned by this DataSource. This allows us to rollback
		 * any changes after each test */
		dataSource.setAutoCommit(false);
		
	}
	/* After all tests have finished running, this method will close the DataSource */
	@AfterClass
	public static void closeDataSource() throws SQLException {
		dataSource.destroy();
	}
	
	@Before
	public void setup() {
		reservationDao = new JdbcReservationDao(dataSource);
		showtimeDao = new JdbcShowtimeDao(dataSource);
	}
	
	@Test
	public void Return_Seats_By_Theater_Test() {
		assertEquals(120, reservationDao.getSeatsByTheater(3).size());
	}
	
	@Test
	public void Set_Seat_Availability_Test() {
		assertEquals(false,reservationDao.setSeatAvailability(82,reservationDao.getSeatsByTheater(1)).get(0).isAvailable());
		assertEquals(true,reservationDao.setSeatAvailability(82,reservationDao.getSeatsByTheater(1)).get(1).isAvailable());
	}
	
	@Test
	public void Get_Reservation_By_Id_Test() {
		assertEquals(82,reservationDao.getReservationByResId(1).getShowtimeId());
	}
	
	@Test
	public void Get_Tickets_By_Reservation_Id_Test() {
		assertEquals(1,reservationDao.getReservationByResId(1).getTickets().get(0).getSeatId());
	}
	
	@Test
	public void Request_Tickets_Test() {
		List<Integer> seats = new ArrayList<Integer>();
		List<Seat> theaterOneSeats = reservationDao.getSeatsByTheater(1);
		seats.add(theaterOneSeats.get(3).getSeatId());
		seats.add(theaterOneSeats.get(4).getSeatId());
		User theUser = new User();
		theUser.setId(1);
		Showtime showtime = showtimeDao.getShowtimeById(82);
		
		assertEquals(82,reservationDao.requestSeats(seats, theUser, showtime).getShowtimeId());
	}
	
}
