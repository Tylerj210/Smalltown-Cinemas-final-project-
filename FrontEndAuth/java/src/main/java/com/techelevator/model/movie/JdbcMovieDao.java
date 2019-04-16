package com.techelevator.model.movie;

import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;



@Component
public class JdbcMovieDao implements MovieDao {

	private JdbcTemplate jdbcTemplate;
	
	@Autowired
    public JdbcMovieDao(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }
	
	@Override
    public List<Movie> getAllMovies() {
        List<Movie> movies = new ArrayList<Movie>();
        String sqlSelectAllMovies = "SELECT * FROM movies";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sqlSelectAllMovies);

        while(results.next()) {
            Movie movie = mapResultToMovie(results);
            movies.add(movie);
        }

        return movies;
    }
	
	@Override
    public Movie getMovieById(int id) {
        Movie movie = new Movie();
        String sqlSelectMovieById = "SELECT * FROM movies WHERE movies.movie_id = ?";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sqlSelectMovieById, id);

        if(results.next()) {
            movie = mapResultToMovie(results);
        }

        return movie;
    }
	
	
	
	/* (non-Javadoc)
	 * @see com.techelevator.model.movie.MovieDao#getAllIds()
	 */
	@Override
	public List<Integer> getAllIds() {
		List<Integer> ids = new ArrayList<Integer>();
		String sqlGetAllIds = "SELECT movie_id FROM movies ORDER BY movie_id";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlGetAllIds);
		while(results.next()) {
			ids.add(results.getInt("movie_id"));
		}
		return ids;
	}

	private Movie mapResultToMovie(SqlRowSet results) {
        Movie movie = new Movie();
        movie.setId(results.getInt("movie_id"));
        movie.setTitle(results.getString("title"));
        movie.setReleaseDate(results.getDate("releaseDate").toLocalDate());
        movie.setRating(results.getString("rating"));
        movie.setRuntime(results.getInt("runtime"));
        movie.setDirector(results.getString("director"));
        movie.setDescription(results.getString("synopsis"));
        movie.setOfficialSite(results.getString("officialSite"));
        movie.setImage(results.getString("mainImage"));
        movie.setTrailerLink(results.getString("trailerLink"));
        movie.setActors(getActorList(movie.getId()));
        movie.setGenres(getGenreList(movie.getId()));
        return movie;
    }
	
	public List<String> getActorList(int id) {
		List<String> actors = new ArrayList<String>();
        String sqlSelectActorByMovieId = "SELECT actors.firstname, actors.lastname "
        		+ "FROM actors "
        		+ "JOIN movie_actor ON actors.actor_id = movie_actor.actor_id "
        		+ "WHERE movie_actor.movie_id = ?";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sqlSelectActorByMovieId, id);
        while(results.next()) {
        	actors.add(results.getString("firstname") + " " + results.getString("lastname"));
        }
        
        return actors;
	}
	
	public List<String> getGenreList(int id) {
		List<String> genres = new ArrayList<String>();
        String sqlSelectGenreByMovieId = "SELECT genre.genre "
        		+ "FROM genre "
        		+ "JOIN genre_movie ON genre.genre_id = genre_movie.genre_id "
        		+ "WHERE genre_movie.movie_id = ?";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sqlSelectGenreByMovieId, id);
        while(results.next()) {
        	genres.add(results.getString("genre"));
        }
        
        return genres;
	}
}

