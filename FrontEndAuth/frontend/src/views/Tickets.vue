<template>
    <div id="tickets">
        <h1> Purchase tickets  </h1>
                <div class="ticket-wrapper">
                    <div id="seatChart">
                        <span id="seatsHead"> Seats </span>
                        <div id="seats">
                            <span v-for="seat in showtime.seats" class="seat" v-on:click="toggleSelected">{{seat.seatNumber}}</span>
                        </div>
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
    seats: [],
    showtime: []
    };

},

methods: {
    toggleSelected(){
        let seat = event.target;
        if(seat.classList.contains('selected')){
            seat.classList.remove('selected');
        } else {
            seat.classList.add('selected');
        }

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
    .then(showtimeJSON => {
        this.showtime = showtimeJSON;
        console.log(this.showtime);
    })
},
}
</script>

<style>

#tickets {
    margin-top: 50px;
    text-align: center;
    color: white;
}

.ticket-wrapper{
  max-width: 90%;
  min-height: 500px;
  margin: 25px auto;
  margin-bottom: 60px;
  padding: 40px none;
  border: 3px solid #800020;
  border-radius: 12px;
  box-shadow: 5px 10px 20px 4px rgba(255,215,0,80%);
  color: rgba(255,215,0,90%);
  text-align:center;
  background-color: #000;  
}

#seatChart {
    width: 100%;
    /* border: 1px solid white; */
    /* border-radius: 5px; */
}

#seatsHead {
    display: block;
    min-width: 100px;
    margin-top: 10px;
    padding-top: 10px;
    border-top: 2px solid white;
    border-radius: 40%;
}

#seats {
    display: flex;
    justify-content: space-around;
    flex-wrap: wrap;
    margin: auto;
    padding: 5%;
}

.seat {
    width: 8%;
    font-size: .6em;
    border: 1px solid white;
    margin: 2px;
    padding: 2px;
}

.selected {
  background-color: red;
}


</style>
