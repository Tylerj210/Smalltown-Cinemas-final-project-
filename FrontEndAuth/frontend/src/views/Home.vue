<!-- 
  The Home Page should display a feed of all current featured movies.
  NOTES:
  - Upon creation, it calls api/posts and sorts the response.
  DEPENDENCIES: 
    
-->
<template>
  <div id="home" class="container">
    <div id="all-movies">
      <div v-for="movie in movies" v-bind:key="movie.id" class="movie-wrapper">
        <img v-bind:src="movie.image">
        <div class="movie-main-details">
          <a v-bind:href="movie.officialSite"><h3>{{movie.title}}</h3></a>
          <div class="description">
            {{movie.description}}
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
      movies: []
    };
  },
  methods: {
    buildMovieList(){
      // this.movies.forEach((movie)=>{
      //   let wrapper = document.getElementById('movie-wrapper');
      //   let card = document.createElement("div");
      //   card.classList.add("movie-card-wrapper");
      //   let theImage = document.createElement("img");
      //   let theTitle = document.createElement("p");

      //   theImage.src=movie.image;
      //   theTitle.innerText=movie.title;
      //   wrapper.appendChild(theImage);
      //   wrapper.appendChild(theTitle);
      // })
    }
  },
  computed:{
    
  },
  created() {
    // Call the Api to get the featured movies
    fetch(`${process.env.VUE_APP_REMOTE_API}/api/movies`, {
      method: "GET",
      headers: {
        // A Header with our authentication token.
        Authorization: "Bearer " + auth.getToken()
      }
    })
    .then(response => response.json())
    .then(moviesJSON => {
        this.movies = moviesJSON;
        console.log(moviesJSON);
        this.buildMovieList();
    })
  }
};
</script>

<style scoped>
#home {
  margin-top: 0.5rem;
}
#all-movies{
  min-width:90%;
  margin:20px;
  padding:20px;
  border:1px solid black;
  background-color:black;
}
.description{
  width:80%;
  margin:auto;
}
.movie-wrapper{
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

.movie-wrapper img{
  width: 50%;
}

</style>
