<!-- 
  The Home Page should display a feed of all current featured movies.
  NOTES:
  - Upon creation, it calls api/posts and sorts the response.
  DEPENDENCIES: 
    
-->
<template>
  <div id="home" class="container">
      <select id="datePicker" v-on:change="showMovies" v-model="selectedDay" name="searchDate">
        <option v-for="date in getDates()" v-bind:value="date.day">{{date.date.toDateString()}}</option>
      </select>
      <!-- <input type="submit"> -->
    <div id="all-movies">
      <div v-for="viewing in viewings" v-bind:key="viewing.theater"  class="movie-wrapper">
        <div  class="movie">
          <div class="image">
            <img v-bind:src="viewing.movie.image">
          </div>
          <div class="movie-main-details">
            <div class="movieHead">
              <a v-bind:href="viewing.movie.officialSite" target="_blank"><h3>{{viewing.movie.title}}</h3></a>
              <div class="rating">
                <p>{{viewing.movie.rating}}</p>
              </div>
            </div>
            <div class="details">
              <section> 
                <h4>Director:</h4> 
                <p>{{viewing.movie.director}} </p>
              </section>
              <section>
                <h4>Cast:</h4>
                <ul>
                  <li v-for="actor in viewing.movie.actors">{{actor}}</li>
                </ul>
              </section>
              <section>
                <h4>Genre(s):</h4>
                <ul>
                  <li v-for="genre in viewing.movie.genres">{{genre}}</li>
                </ul>
              </section>
            </div>
            <div class="videoTrailer">
              <iframe width="560" height="315" v-bind:src="viewing.movie.trailerLink" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
            </div>
            <div class="mainShowtimes">
              <h3>Showtimes</h3>
              <ul class="showtimesList">
                <li v-for="showtime in viewing.showtimes" v-bind:key="showtime.showtimeId" class="showtime" v-bind:class="{ pastShow: !compareTime(showtime)}">
                  <a v-if="compareTime(showtime)" v-bind:href="'/tickets/' + showtime.showtimeId" class="showTimeAnchor">{{setTime(showtime.time)}}</a>
                  <p v-else class="showtimeP">{{setTime(showtime.time)}}</p>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import auth from "@/shared/auth.js";

export default {
  name: "home",
  components: {
    
  },
  data() {
    return {
      viewings: [], 
      selectedDay: 0,
      currentShowing: {}
    };
  },
  methods: {
    showMovies(){
      fetch(`${process.env.VUE_APP_REMOTE_API}/movie/viewings/${this.selectedDay}`, {
      method: "POST",
      headers: {
        // A Header with our authentication token.
        "Content-Type": "application/json",
        // Authorization: "Bearer " + auth.getToken()
      }, 
      body: JSON.stringify(this.selectedDay)
    })
    .then(response => response.json())
    .then(viewingsJSON => {
        this.viewings = viewingsJSON;
        console.log(viewingsJSON);
    })
    }, 
    setTime(showtime){
      let hour = showtime.hour;
      let minutes = showtime.minute;
      if(minutes < 10){
        minutes = "0" + minutes;
      }
      if(hour >= 12){
        if(hour > 12){
        hour = hour - 12;
        }
        return hour + ":" + minutes + " pm";
      }
      return hour + ":" + minutes + " am";
    },
    compareTime(showtime){
  
      let currentTime = Date.now();
      let compareTime = new Date;
          compareTime.setFullYear(showtime.date.year ,showtime.date.monthValue - 1 , showtime.date.dayOfMonth);
          compareTime.setHours(showtime.time.hour, showtime.time.minute);

      return currentTime < Date.parse(compareTime);

    }, 
    getDates(){
      let theDates = [];
      let today = new Date();
      for(let i = 0; i < 7; i++){
        let newdate = new Date();
        newdate.setDate(today.getDate()+i);
        let dateObj = {
          date: newdate,
          day: i
        }
        theDates[i] = dateObj;
      }  
      return theDates;
    }, 
    getTickets(viewing){
      console.log(viewing);
      this.currentShowing = viewing;
      this.$emit("getTickets");
    }
  },
  computed:{
    
  },
  created() {
    // Call the Api to get the featured movies
    fetch(`${process.env.VUE_APP_REMOTE_API}/movie/viewings`, {
      method: "GET",
      headers: {
        // A Header with our authentication token.
        Authorization: "Bearer " + auth.getToken()
      }
    })
    .then(response => response.json())
    .then(viewingsJSON => {
        this.viewings = viewingsJSON;
        console.log(viewingsJSON);
    })
  }
};
</script>

<style scoped>
#home {
  margin-top: 0.5rem;
}

#datePicker {
  height: 40px;
  background-color: lightgray;
  color: black;
  font-size: 1em;
}

#all-movies{
  min-width:100%;
  /* margin:20px; */
  /* padding:20px; */
  border:1px solid black;
  background-color:black;
}
.description{
  width:80%;
  margin:auto;
}
.movie-wrapper{
  /* max-height: 500px;*/
  margin: 25px;
  margin-bottom: 60px;
  padding: 40px;
  border: 3px solid #800020;
  border-radius: 12px;
  box-shadow: 5px 10px 20px 4px rgba(255,215,0,80%);
  color: rgba(255,215,0,90%);
  text-align:center;
    background-color: #000;
    background-image:  
        linear-gradient(to right, #fff, #fff), 
        linear-gradient(to right, #fff, #fff), 
        linear-gradient(to right, #fff, #fff), 
        linear-gradient(to right, #fff, #fff), 
        linear-gradient(to right, #fff, #fff), 
        linear-gradient(to right, #fff, #fff), 
        linear-gradient(to right, #fff, #fff), 
        linear-gradient(to right, #fff, #fff), 
        linear-gradient(to right, #fff, #fff), 
        linear-gradient(to right, #fff, #fff), 
        linear-gradient(to right, #fff, #fff),  
        linear-gradient(to right, #fff, #fff),       
         
        linear-gradient(to right, #fff, #fff), 
        linear-gradient(to right, #fff, #fff), 
        linear-gradient(to right, #fff, #fff), 
        linear-gradient(to right, #fff, #fff), 
        linear-gradient(to right, #fff, #fff), 
        linear-gradient(to right, #fff, #fff), 
        linear-gradient(to right, #fff, #fff), 
        linear-gradient(to right, #fff, #fff), 
        linear-gradient(to right, #fff, #fff), 
        linear-gradient(to right, #fff, #fff), 
        linear-gradient(to right, #fff, #fff);

    background-repeat:no-repeat;
    background-position: 
        5% 5%,
        5% 15%,
        5% 25%, 
        5% 35%,
        5% 45%,
        5% 55%,
        5% 65%,
        5% 75%, 
        5% 85%,
        5% 95%,
             
        95% 5%,
        95% 15%,
        95% 25%, 
        95% 35%,
        95% 45%,
        95% 55%,
        95% 65%,
        95% 75%, 
        95% 85%,
        95% 95%;
    
    background-size:
        5% 6%,
        5% 6%,
        5% 6%,
        5% 6%,
        5% 6%,
        5% 6%,
        5% 6%,
        5% 6%,
        5% 6%,
        5% 6%,
        5% 6%,
            
        5% 6%,
        5% 6%,
        5% 6%,
        5% 6%,
        5% 6%,
        5% 6%,
        5% 6%,
        5% 6%,
        5% 6%,
        5% 6%,
        5% 6%;
}

.movie-wrapper *{
  color: rgba(255,215,0,90%);
}

.movie {
  padding: 10px 10px;
  border-top: 1px solid white;
  border-bottom: 1px solid white;
  width: 100%;
  margin: auto;
}

.movieHead {
    display: flex;
    justify-content: center;
    flex-wrap: nowrap;
    width: 90%;
    margin: auto;
  }

  .rating {
    margin-left: 10px;
  }

  .movieHead p {
    border: 1px solid white ;
    border-radius: 5px;
    padding: 3px;
    font-size: .5em;
    
    
  }

  .image img {
    width: 90%;
    object-fit: cover;

  }

 .details {
   border-top: 1px solid white;
   border-bottom: 1px solid white;
   width: 90%;
   margin: auto;
 }

  .details h4 {
    margin-top: 6px;
    margin-bottom: 3px;
    color: white;
  }

  .details p {
    margin: 0;
    color: white;
  }

  .details ul {
    padding: 0;
    margin-top: 0;
  }

  .details li {
    font-size: .8em;
    list-style: none;
    color: white;
  }

  .videoTrailer {
    display: none;
  }

  .showtimesList {
    padding: 0;
    display: flex;

    justify-content: space-around;

  }

  .showtime {
    list-style: none;
    border: 1px solid white ;
    border-radius: 5px;
    padding: 7px;
    font-size: .6em;
  }

  .showtimeP {
    display: inline-block;
    margin: 0px;
    color: black;
  }

  .showtime:hover {
    background-color: #800020;
  }

  .showtime a:hover {
    text-decoration: none;
    /* font-weight: 800; */
  }

  .pastShow {
    background-color: darkgray !important;
  }

  .pastShow:hover {
    background-color: darkgray !important;
  }

@media screen and (min-width: 768px) {

  .movie {
    display: flex;
    justify-content: space-around;
    flex-wrap: nowrap;
    max-width: 80%;
    margin: auto;
    padding: 20px 5px;
    border-top: 1px solid white;
    border-bottom: 1px solid white;
  }

  .movie-main-details,
  .image {
    width: 50%; 
  }
}
@media screen and (min-width: 992px) {

  .movie-main-details {
    display: flex;
    flex-direction: column;
  }

  .details {
    display: flex;
    flex-direction: column;
    justify-content: space-around;
    flex-grow: 1;
    align-content: center;
  }

  .videoTrailer {
    display: block;
    flex-grow: 1;
  }

  iframe {
    width: 100%;
    height: auto;
    margin-top: 20px;
  }
}
</style>
