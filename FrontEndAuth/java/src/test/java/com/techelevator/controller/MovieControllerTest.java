package com.techelevator.controller;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import javax.servlet.http.HttpServletRequest;

import org.junit.Before;
import org.springframework.jdbc.datasource.SingleConnectionDataSource;

import com.techelevator.authentication.RequestAuthProvider;
import com.techelevator.model.movie.MovieDao;
import com.techelevator.model.movie.ShowtimeDao;
import com.techelevator.model.user.UserDao;
import com.techelevator.model.reservation.ReservationDao;



public class MovieControllerTest {
	protected static SingleConnectionDataSource dataSource;
	
	  	private HttpServletRequest mockedRequest;
	    private MovieDao mockedMovieDao;
	    private ShowtimeDao mockedShowtimeDao;
	    private ReservationDao mockedReservationDao;

	    @Before
	    public void before() {
	        mockedRequest = mock(HttpServletRequest.class);
	        mockedMovieDao = mock(MovieDao.class);
	    }
	    
	    
	
	

}
