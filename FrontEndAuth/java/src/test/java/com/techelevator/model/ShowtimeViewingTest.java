package com.techelevator.model;

import static org.junit.Assert.assertEquals;

import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;

import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.SingleConnectionDataSource;
import org.springframework.jdbc.support.rowset.SqlRowSet;

import com.techelevator.model.movie.JdbcMovieDao;
import com.techelevator.model.movie.JdbcShowtimeDao;
import com.techelevator.model.movie.MovieDao;
import com.techelevator.model.movie.ShowtimeDao;



public class ShowtimeViewingTest {
	protected static SingleConnectionDataSource dataSource;
	protected ShowtimeDao showtimeDao;
	protected MovieDao movieDao;
	
	
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
		showtimeDao = new JdbcShowtimeDao(dataSource);
		movieDao= new JdbcMovieDao(dataSource);
	}

	@Test
	public void Return_Theater_Numbers_Test() {
		assertEquals(6, showtimeDao.getTheaterIds().size());
	}
	
	@Test
	public void Get_Showtime_By_Theater_And_Day_Test() {
		assertEquals(4, showtimeDao.getShowtimesByTheaterAndDay(1, LocalDate.now()).size());
	}
	
	@Test
	public void Get_Movie_By_Id_Test() {
		assertEquals("Avengers: Endgame",movieDao.getMovieById(1).getTitle());
	}
	
	@Test
	public void Group_Times_With_Movies_Test() {
		assertEquals(1,showtimeDao.groupTimesWithMovies(LocalDate.now(),movieDao).get(0).getTheaterNum());
		assertEquals(2,showtimeDao.groupTimesWithMovies(LocalDate.now(),movieDao).get(1).getTheaterNum());
		assertEquals(3,showtimeDao.groupTimesWithMovies(LocalDate.now(),movieDao).get(2).getTheaterNum());
		assertEquals(4,showtimeDao.groupTimesWithMovies(LocalDate.now(),movieDao).get(3).getTheaterNum());
	}
	
}
