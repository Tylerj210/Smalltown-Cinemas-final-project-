package com.techelevator.controller;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.techelevator.model.movie.Movie;

@RestController
@CrossOrigin
@RequestMapping(path="/admin")
public class AdminController {

	@RequestMapping(path="/add",method=RequestMethod.POST)
	public Movie addMovie() {
		Movie movie = new Movie();
		
		
		return movie;
	}
	
}
