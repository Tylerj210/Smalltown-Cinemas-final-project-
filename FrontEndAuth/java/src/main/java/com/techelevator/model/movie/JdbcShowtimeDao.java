package com.techelevator.model.movie;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.sql.DataSource;

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
		String sqlSelectShowtimesByTheaterAndDay="SELECT * FROM showtime WHERE theater_id=? AND datetime > ? AND datetime < ?";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlSelectShowtimesByTheaterAndDay,theaterId,day,day.plusDays(1));
		while(results.next()) {
			Showtime showtime = mapResultToShowtime(results);
			showtimes.add(showtime);
		}
		
		return showtimes;
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
		return showtime;
	}

	

}
