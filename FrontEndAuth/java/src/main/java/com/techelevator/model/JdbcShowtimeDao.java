package com.techelevator.model;

import java.time.LocalDateTime;
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
private JdbcMovieDao movieDao;
	
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

	/* (non-Javadoc)
	 * @see com.techelevator.model.ShowtimeDao#getShowtimesByMovieId(int)
	 */
	@Override
	public List<Showtime> getShowtimesByMovieId(int id) {
		List<Showtime> showtimes = new ArrayList<Showtime>();
		String sqlSelectShowtimesByMovieId = "Select * From showtime JOIN showtime_movie ON showtime.showtime_id=showtime_movie.showtime_id WHERE movie_id=?";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlSelectShowtimesByMovieId,id);
		
		while(results.next()) {
			Showtime showtime = mapResultToShowtime(results);
			showtimes.add(showtime);
		}
		return showtimes;
	}
	
	
	@Override
	public List<Showtime> getShowtimesByTheaterAndDay(int theaterId, LocalDateTime day) {
		List<Showtime> showtimes = new ArrayList<Showtime>();
		String sqlSelectShowtimesByTheaterAndDay="SELECT * FROM showtime JOIN showtime_movie ON showtime.showtime_id=showtime_movie.showtime_id WHERE theater_id=? AND datetime > ? AND datetime < ?";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlSelectShowtimesByTheaterAndDay,theaterId,day.truncatedTo(ChronoUnit.DAYS),day.truncatedTo(ChronoUnit.DAYS).plusDays(1));
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
	public List<Viewing> groupTimesWithMovies(LocalDateTime day) {
		List<Viewing> viewings = new ArrayList<Viewing>();
		for(Integer i:getTheaterIds()) {
			List<Showtime> showtimes=getShowtimesByTheaterAndDay(i, day);
			viewings.add(new Viewing(movieDao.getMovieById(showtimes.get(0).getMovieId()),showtimes,i));
		}
		return viewings;
	}

	private Showtime mapResultToShowtime(SqlRowSet results) {
		Showtime showtime = new Showtime();
		 showtime.setShowtimeId(results.getInt("showtime_id"));
	     showtime.setMovieId(results.getInt("movie_id"));
	     showtime.setTheaterId(results.getInt("theater_id"));
	     showtime.setDate(results.getDate("datetime").toLocalDate());
		return showtime;
	}

	

}
