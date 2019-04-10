package com.techelevator.model;

import static org.junit.Assert.assertEquals;

import java.sql.SQLException;
import java.time.LocalDateTime;

import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.SingleConnectionDataSource;
import org.springframework.jdbc.support.rowset.SqlRowSet;



public class ShowtimeViewingTest {
	protected static SingleConnectionDataSource dataSource;
	protected ShowtimeDao showtimeDao;
	
	
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
	}

	@Test
	public void Return_Theater_Numbers_Test() {
		assertEquals(6, showtimeDao.getTheaterIds().size());
	}
	
	@Test
	public void Get_Showtime_By_Theater_And_Day_Test() {
		assertEquals(4, showtimeDao.getShowtimesByTheaterAndDay(1, LocalDateTime.now().plusDays(1)).size());
	}
}
