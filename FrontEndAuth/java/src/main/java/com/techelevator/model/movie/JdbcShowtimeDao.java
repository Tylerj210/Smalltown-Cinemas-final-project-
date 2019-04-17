package com.techelevator.model.movie;

import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.sql.DataSource;

import org.postgresql.util.PSQLException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

@Component
public class JdbcShowtimeDao implements ShowtimeDao {

	private JdbcTemplate jdbcTemplate;

	@Autowired
    public JdbcShowtimeDao(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }
	
	/* (non-Javadoc)
	 * @see com.techelevator.model.movie.ShowtimeDao#getViewingByTheaterAndDay(int, java.time.LocalDate)
	 */
	@Override
	public Viewing getViewingByTheaterAndDay(int theaterId, LocalDate day, MovieDao movieDao) {
		Viewing viewing;
		List<Showtime> showtimes = getShowtimesByTheaterAndDay(theaterId,day);
		if(showtimes.size()>0) {
			
			viewing=new Viewing(movieDao.getMovieById(showtimes.get(0).getMovieId()),showtimes,theaterId);
		} else {
			viewing=new Viewing(new Movie(0, "", LocalDate.ofYearDay(1900, 1), "", 0, "", "No description available", "", "https://image.flaticon.com/icons/png/512/21/21174.png", "", new ArrayList<String>(), new ArrayList<String>()),showtimes,theaterId);
		}
		return viewing;
	}

	@Override
	public List<Showtime> getAllShowtimes() {
		List<Showtime> showtimes = new ArrayList<Showtime>();
		String sqlSelectAllShowtimes = "Select * From showtime";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlSelectAllShowtimes);
		
		while(results.next()) {
			Showtime showtime = mapResultToShowtime(results);
			showtimes.add(showtime);
		}
		return showtimes;
	}


	@Override
	public List<Showtime> getShowtimesByMovieId(int id) {
		List<Showtime> showtimes = new ArrayList<Showtime>();
		String sqlSelectShowtimesByMovieId = "Select * From showtime WHERE movie_id=?";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlSelectShowtimesByMovieId,id);
		
		while(results.next()) {
			Showtime showtime = mapResultToShowtime(results);
			showtimes.add(showtime);
		}
		return showtimes;
	}
	
	
	@Override
	public List<Showtime> getShowtimesByTheaterAndDay(int theaterId, LocalDate day) {
		List<Showtime> showtimes = new ArrayList<Showtime>();
		String sqlSelectShowtimesByTheaterAndDay="SELECT * FROM showtime WHERE theater_id=? AND datetime > ? AND datetime < ? ORDER BY datetime";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlSelectShowtimesByTheaterAndDay,theaterId,day,day.plusDays(1));
		while(results.next()) {
			Showtime showtime = mapResultToShowtime(results);
			showtimes.add(showtime);
		}
		
		return showtimes;
	}

	
	/* (non-Javadoc)
	 * @see com.techelevator.model.movie.ShowtimeDao#changeShowtimesByTheaterAndDay(int, java.time.LocalDate, java.util.List)
	 */
	@Override
	public List<Showtime> changeShowtimesByTheaterAndDay(int theaterId, int movieId, LocalDate day, List<SimpleHourMinTime> times) {
		try {
			String sqlDeleteShowtimes ="DELETE FROM showtime WHERE theater_id=? AND datetime > ? AND datetime < ?";
			jdbcTemplate.update(sqlDeleteShowtimes,theaterId,day,day.plusDays(1));
			String sqlHighestKey = "SELECT max(showtime_id) FROM showtime";
			SqlRowSet results = jdbcTemplate.queryForRowSet(sqlHighestKey);
			int showtimeId = 0;
			if(results.next()) {
				showtimeId=results.getInt("max")+1;
			}
			for(SimpleHourMinTime time : times) {
				String sqlInsertShowtimes ="INSERT INTO showtime (showtime_id,theater_id,movie_id,dateTime,price) VALUES (?, ?, ?, ?,?)";
				LocalTime localTime = LocalTime.of(time.getHour(), time.getMinute());
				
				LocalDateTime dateTime = LocalDateTime.of(day, localTime);
				jdbcTemplate.update(sqlInsertShowtimes,showtimeId,theaterId,movieId,dateTime,time.getHour()<12?8:10);
				showtimeId++;
			}
		} finally {}
		
						
		return getShowtimesByTheaterAndDay(theaterId,day);
	}

	/* (non-Javadoc)
	 * @see com.techelevator.model.movie.ShowtimeDao#removeShowtimeById(int)
	 */
	@Override
	public Showtime removeShowtimeByTheaterAndDay(int id,LocalDate date) {
		System.out.println("outside");
		try {
			String sqlDeleteShowtimes ="DELETE FROM showtime WHERE theater_id=? AND datetime > ? AND datetime < ?";
			jdbcTemplate.update(sqlDeleteShowtimes,id,date,date.plusDays(1));
			System.out.println("inside");
			
		} finally {}
		return getShowtimeById(id);
	}

	@Override
	public List<Integer> getTheaterIds() {
		List<Integer> theaters = new ArrayList<Integer>();
		String sqlSelectUniqueTheaterId="SELECT theater_id FROM showtime GROUP BY theater_id ORDER BY theater_id";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlSelectUniqueTheaterId);
		while(results.next()) {
			theaters.add(results.getInt("theater_id"));
		}
		return theaters;
	}

	
	@Override
	public List<Viewing> groupTimesWithMovies(LocalDate day,MovieDao movieDao) {
		List<Viewing> viewings = new ArrayList<Viewing>();
		List<Integer> theaters = getTheaterIds();
		for(Integer i:theaters) {
			List<Showtime> showtimes=getShowtimesByTheaterAndDay(i, day);
			
			if(showtimes.size()>0) {
				
				viewings.add(new Viewing(movieDao.getMovieById(showtimes.get(0).getMovieId()),showtimes,i));
			} else {
				viewings.add(new Viewing(new Movie(0, "", LocalDate.ofYearDay(1900, 1), "", 0, "", "No description available", "", "https://image.flaticon.com/icons/png/512/21/21174.png", "", new ArrayList<String>(), new ArrayList<String>()),showtimes,i));
			}
			
			
		}
		return viewings;
	}

	/* (non-Javadoc)
	 * @see com.techelevator.model.movie.ShowtimeDao#getShowtimeById(int)
	 */
	@Override
	public Showtime getShowtimeById(int id) {
		Showtime showtime = new Showtime();
		String sqlGetShowtimeByShowtimeId = "SELECT * FROM showtime WHERE showtime_id=?";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlGetShowtimeByShowtimeId, id);
		if(results.next()) {
			showtime = mapResultToShowtime(results);
		}
		else {
			showtime = new Showtime(id, 0, 0, LocalDate.ofYearDay(1900, 1), LocalTime.of(0, 00));
		}
		return showtime;
	}

	private Showtime mapResultToShowtime(SqlRowSet results) {
		Showtime showtime = new Showtime();
		 showtime.setShowtimeId(results.getInt("showtime_id"));
	     showtime.setMovieId(results.getInt("movie_id"));
	     showtime.setTheaterId(results.getInt("theater_id"));
	     showtime.setDate(results.getDate("datetime").toLocalDate());
	     showtime.setTime(results.getTime("datetime").toLocalTime());
	     showtime.setPrice(results.getDouble("price"));
		return showtime;
	}

	

}
