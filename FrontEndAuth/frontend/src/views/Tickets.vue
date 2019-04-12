<template>
    <div id="tickets">
        <h1> Purchase tickets  </h1>
            <div id="ticketList">
                <div v-for="seat in seats" v-bind:key="seat.id" class="seatWrapper">

                </div>
            </div>
    </div>
</template>


<script>
import auth from "@/shared/auth.js";

export default {
    name:"tickets",
    components: {

},
data() {
return {
    seats: []
    };

},
props: {
    showtime: Object
},

methods: {
    viewAvailableSeats(){

    }

},
computed: {

},
created() {
    const showtimeId = this.$route.params.showtime;
  fetch(`${process.env.VUE_APP_REMOTE_API}/seats/${showtimeId}`, {
      method: "GET",
      headers: {
        // A Header with our authentication token.
        Authorization: "Bearer " + auth.getToken()
      }
    })
    .then(response => response.json())
    .then(moviesJSON => {
        this.movies = moviesJSON;
    })
},
}
</script>

<style>

</style>
