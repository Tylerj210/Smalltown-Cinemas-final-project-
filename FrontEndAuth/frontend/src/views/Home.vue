<!-- 
  The Home Page should display a feed of all current featured movies.
  NOTES:
  - Upon creation, it calls api/posts and sorts the response.
  DEPENDENCIES: 
    
-->
<template>
  <div id="home" class="container">
    <span v-for="movie in movies" v-bind:key="movie.movie_id">
      {{movie.title}}
    </span>
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
    });
  }
};
</script>

<style scoped>
#home {
  margin-top: 0.5rem;
}

.post {
  border-bottom: 1px solid #eee;
  margin-bottom: 0.5rem;
}
</style>
