package com.techelevator.model.reservation;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
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
								"WHERE reservations.showtime_id=? "+
								"AND (reservations.finalized=true "+
								"OR current_time::time without time zone -(interval '15 minutes')<reservations.bookingtime::time)";
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
		Reservation theReservation = new Reservation();
		String sqlGetResById = "SELECT * FROM reservations WHERE reservation_id=?";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlGetResById,id);
		if(results.next()) {
			theReservation=mapResultToReservation(results);
		}
		addTicketsToRes(theReservation);
		return theReservation;
	}
	
	public void addTicketsToRes(Reservation reservation) {
		List<Ticket> tickets = new ArrayList<Ticket>();
		String sqlGetTickets = "SELECT * FROM tickets WHERE reservation_id=?";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlGetTickets,reservation.getReservationId());
		while(results.next()) {
			tickets.add(mapResultToTicket(results));
		}
		reservation.setTickets(tickets);
	}

	/* (non-Javadoc)
	 * @see com.techelevator.model.reservation.ReservationDao#requestSeats(java.util.List)
	 */
	@Override
	public Reservation requestSeats(List<Integer> seats, User user, Showtime showtime) {

		//Find the next reservaiton ID so the inserted reservation doesn't get lost
		int resId = getNextResId();
		
		//make sure the entire transaction is legal
		boolean isReservable = confirmAvailability(showtime,seats);
		
		if(isReservable) {
			//insert the reservation into the reservation table
			String sqlInsertNonfinalReservation = "INSERT INTO reservations (reservation_id,id,showtime_id,bookingtime,finalized,confirmationnumber) "+
												"VALUES (?,?,?,?,?,?)";
			jdbcTemplate.update(sqlInsertNonfinalReservation,resId,user.getId(),showtime.getShowtimeId(),LocalDateTime.now(),false,resId);

			//insert all the seats into the ticket table
			for(int seat: seats) {
				String sqlAddTickets = "INSERT INTO tickets (reservation_id,seat_id,price) "+
										"VALUES (?,?,?)";
				jdbcTemplate.update(sqlAddTickets,resId,seat,showtime.getPrice());
			}
		}

		return getReservationByResId(resId);
	}
	
	public int getNextResId() {
		String sqlGetNextResId = "SELECT max(reservation_id) as max FROM reservations";
		int resId = 0;
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlGetNextResId);
		if(results.next()) {
			resId=results.getInt("max");
		}
		resId++;
		return resId;
	}

	public boolean confirmAvailability(Showtime showtime,List<Integer> seats) {
		boolean isReservable = true;
		
		for(int seat : seats) {
			String sqlCheckSeatAvailability = "SELECT seat_id FROM tickets WHERE seat_id = ? AND reservation_id "+
											"IN (SELECT reservation_id FROM reservations WHERE showtime_id=? "+
											"AND (reservations.finalized=true "+
											"OR current_time::time without time zone -(interval '15 minutes')<reservations.bookingtime::time))";
			SqlRowSet results = jdbcTemplate.queryForRowSet(sqlCheckSeatAvailability,seat,showtime.getShowtimeId());
			
			if(results.next()) {
				
				isReservable=false;
				break;
			}
		}
		
		return isReservable;
	}
	/* (non-Javadoc)
	 * @see com.techelevator.model.reservation.ReservationDao#confirmReservation(com.techelevator.model.reservation.Reservation)
	 */
	@Override
	public Reservation confirmReservation(Reservation theReservation) {
		String sqlFinalizeReservation = "UPDATE reservations SET finalized=true "+
										"WHERE reservation_id=?";
		jdbcTemplate.update(sqlFinalizeReservation,theReservation.getReservationId());
		
		return getReservationByResId(theReservation.getReservationId());
	}
	
	/* (non-Javadoc)
	 * @see com.techelevator.model.reservation.ReservationDao#removeSeats(com.techelevator.model.reservation.Reservation)
	 */
	@Override
	public Reservation removeSeats(Reservation theReservation) {
		String sqlRemoveSeats = "DELETE FROM tickets WHERE reservation_id IN (SELECT reservation_id FROM reservations WHERE reservation_id=? AND finalized=false)";
		jdbcTemplate.update(sqlRemoveSeats,theReservation.getReservationId());
		
		return getReservationByResId(theReservation.getReservationId());
	}


	private Seat mapResultToSeats(SqlRowSet results) {
        Seat seat = new Seat();
        seat.setSeatId(results.getInt("seat_id"));
        seat.setTheaterId(results.getInt("theater_id"));
        seat.setSeatNumber(results.getInt("seatNumber"));
        return seat;
    }
	private Reservation mapResultToReservation(SqlRowSet results) {
		Reservation reservation = new Reservation();
		reservation.setBookingDate(results.getDate("bookingTime").toLocalDate());
		reservation.setBookingTime(results.getTime("bookingTime").toLocalTime());
		reservation.setReservationId(results.getInt("reservation_id"));
		reservation.setShowtimeId(results.getInt("showtime_id"));
		reservation.setUserId(results.getInt("id"));
		return reservation;
	}
	private Ticket mapResultToTicket(SqlRowSet results) {
		Ticket ticket = new Ticket();
		ticket.setPrice(results.getDouble("price"));
		ticket.setReservationId(results.getInt("reservation_id"));
		ticket.setSeatId(results.getInt("seat_id"));
		ticket.setTicketId(results.getInt("ticket_id"));
		return ticket;
	}
}
