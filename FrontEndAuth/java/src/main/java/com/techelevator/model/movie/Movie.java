package com.techelevator.model.movie;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

public class Movie {
	
	private int id;
	private String title;
	private LocalDate releaseDate;
	private String rating;
	private int runtime;
	private String director;
	private String description;
	private String officialSite;
	private String image;
	

	private	String trailerLink;
	private List<String> actors;
	private List<String> genres;
	
	public Movie(int id, String title, LocalDate releaseDate, String rating, int runtime, String director,
			String description, String officialSite, String image, String trailerLink, List<String> actors,
			List<String> genres) {
		super();
		this.id = id;
		this.title = title;
		this.releaseDate = releaseDate;
		this.rating = rating;
		this.runtime = runtime;
		this.director = director;
		this.description = description;
		this.officialSite = officialSite;
		this.image = image;
		this.trailerLink = trailerLink;
		this.actors = actors;
		this.genres = genres;
	}
	public Movie() {
		
	}
	
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public String getTitle() {
		return title;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	public LocalDate getReleaseDate() {
		return releaseDate;
	}
	
	public void setReleaseDate(LocalDate releaseDate) {
		this.releaseDate = releaseDate;
	}
	
	public String getRating() {
		return rating;
	}
	
	public void setRating(String rating) {
		this.rating = rating;
	}
	
	public int getRuntime() {
		return runtime;
	}
	
	public void setRuntime(int runtime) {
		this.runtime = runtime;
	}
	public String getDirector() {
		return director;
	}
	
	public void setDirector(String director) {
		this.director = director;
	}
	
	public String getDescription() {
		return description;
	}
	
	public void setDescription(String description) {
		this.description = description;
	}
	
	public String getOfficialSite() {
		return officialSite;
	}
	
	public void setOfficialSite(String officialSite) {
		this.officialSite = officialSite;
	}
	
	public String getImage() {
		return image;
	}
	
	public void setImage(String image) {
		this.image = image;
	}
	
	public String getTrailerLink() {
		return trailerLink;
	}
	
	public void setTrailerLink(String trailerLink) {
		this.trailerLink = trailerLink;
	}

	/**
	 * @return the actors
	 */
	public List<String> getActors() {
		return actors;
	}

	/**
	 * @param actors the actors to set
	 */
	public void setActors(List<String> actors) {
		this.actors = actors;
	}

	/**
	 * @return the genres
	 */
	public List<String> getGenres() {
		return genres;
	}

	/**
	 * @param genres the genres to set
	 */
	public void setGenres(List<String> genres) {
		this.genres = genres;
	}


	
}
