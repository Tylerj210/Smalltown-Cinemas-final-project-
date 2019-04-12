package com.techelevator.model;

import static org.junit.Assert.assertEquals;

import java.sql.SQLException;

import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import org.springframework.jdbc.datasource.SingleConnectionDataSource;

import com.techelevator.model.movie.JdbcMovieDao;
import com.techelevator.model.movie.JdbcShowtimeDao;
import com.techelevator.model.reservation.JdbcReservationDao;
import com.techelevator.model.reservation.ReservationDao;

public class ReservationTest {

	protected static SingleConnectionDataSource dataSource;
	private ReservationDao reservationDao;
	
	
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
	}
	
	@Test
	public void Return_Seats_By_Theater() {
		assertEquals(120, reservationDao.getSeatsByTheater(3).size());
	}
	
	
	
	
}
