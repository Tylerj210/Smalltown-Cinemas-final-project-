package com.techelevator.model;

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
        String sqlSelectMovieById = "SELECT * FROM movies WHERE movies.id = ?";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sqlSelectMovieById, id);

        if(results.next()) {
            movie = mapResultToMovie(results);
        }

        return movie;
    }
	
	private Movie mapResultToMovie(SqlRowSet results) {
        Movie movie = new Movie();
        movie.setId(results.getInt("movie_id"));
        movie.setTitle(results.getString("title"));
        movie.setReleaseDate(results.getDate("releaseDate"));
        movie.setRating(results.getString("rating"));
        movie.setRuntime(results.getInt("runtime"));
        movie.setDirector(results.getString("director"));
        movie.setDescription(results.getString("synopsis"));
        movie.setOfficialSite(results.getString("officialSite"));
        movie.setImage(results.getString("mainImage"));
        movie.setTrailerLink(results.getString("trailerLink"));
        return movie;
    }
}
