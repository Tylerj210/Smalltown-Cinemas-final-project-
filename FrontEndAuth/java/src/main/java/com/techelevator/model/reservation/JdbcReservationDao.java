package com.techelevator.model.reservation;

import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

import com.techelevator.model.movie.Movie;
import com.techelevator.model.movie.Showtime;
import com.techelevator.model.user.User;

@Component
public class JdbcReservationDao implements ReservationDao {

	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	public JdbcReservationDao(DataSource dataSource) {
		jdbcTemplate=new JdbcTemplate(dataSource);
	}
	

	/* (non-Javadoc)
	 * @see com.techelevator.model.reservation.ReservationDao#getSeatsByTheater(int)
	 */
	@Override
	public List<Seat> getSeatsByTheater(int theater) {
		List<Seat> seats = new ArrayList<Seat>();
		String sqlGetSeatsByTheater = "SELECT * FROM seats WHERE theater_id=? ORDER BY seat_id";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlGetSeatsByTheater,theater);
		while(results.next()) {
			seats.add(mapResultToSeats(results));
		}
		return seats;
	}

	/* (non-Javadoc)
	 * @see com.techelevator.model.reservation.ReservationDao#getAvailableSeats(int, int, int, int, int)
	 */
	@Override
	public List<Seat> setSeatAvailability(int showtime, List<Seat> seats) {
		List<Integer> seatIds = new ArrayList<Integer>();
		String sqlGetReservedSeats = "SELECT seat_id FROM tickets JOIN "+
								"reservations ON tickets.reservation_id=reservations.reservation_id "+
								"WHERE reservations.showtime_id=?";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlGetReservedSeats,showtime);
		while(results.next()) {
			seatIds.add(results.getInt("seat_id"));
		}
		for(int seatId : seatIds) {
			for(Seat seat : seats) {
				if((int)seatId==(int)seat.getSeatId()) {
					seat.setAvailable(false);
				}
			}
		}
		return seats;
	}

	/* (non-Javadoc)
	 * @see com.techelevator.model.reservation.ReservationDao#getReservationsByUser(com.techelevator.model.user.User)
	 */
	@Override
	public List<Reservation> getReservationsByUser(User user) {
		// TODO Auto-generated method stub
		return null;
	}

	/* (non-Javadoc)
	 * @see com.techelevator.model.reservation.ReservationDao#getReservationByResId(int)
	 */
	@Override
	public Reservation getReservationByResId(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	/* (non-Javadoc)
	 * @see com.techelevator.model.reservation.ReservationDao#requestSeats(java.util.List)
	 */
	@Override
	public Reservation requestSeats(List<Integer> seatIds) {
		// TODO Auto-generated method stub
		return null;
	}

	/* (non-Javadoc)
	 * @see com.techelevator.model.reservation.ReservationDao#confirmReservation(com.techelevator.model.reservation.Reservation)
	 */
	@Override
	public int confirmReservation(Reservation theReservation) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	private Seat mapResultToSeats(SqlRowSet results) {
        Seat seat = new Seat();
        seat.setSeatId(results.getInt("seat_id"));
        seat.setTheaterId(results.getInt("theater_id"));
        seat.setSeatNumber(results.getInt("seatNumber"));
        return seat;
    }

}
