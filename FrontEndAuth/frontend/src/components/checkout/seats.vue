<template>
    <div id="seatChart">
        <span id="seatsHead"> Seats </span>
        <div id="seats">
            <span v-for="seat in showtime.seats" class="seat" v-on:click="toggleSelected(seat, $event)">{{seat.seatNumber}}</span>
        </div>
        <p v-show="message != ''">{{message}}</p>
        <button id="seatSelect" v-on:click="verifySeats()">Next</button>
    </div>
</template>

<script>
export default {
    name:"seats",
    components: {   
    }, 
    methods: {
        toggleSelected(seat, event){
            let seatSelected = event.target;
            let seatId = seat.seatId;
            if(seatSelected.classList.contains('selected')){
                seatSelected.classList.remove('selected');
                let seatIndex = Array.from(this.selectedSeats).indexOf(seatId);
                Array.from(this.selectedSeats).splice(seatIndex, 1);
            } else {
                seatSelected.classList.add('selected');
                this.selectedSeats = seatId;          
            }
        },
        verifySeats(){
            let seats = document.getElementsByClassName("selected");
            if(seats.length > 0){
                this.message = '';
                this.getView(1);
            } else {
                this.message = "Please choose a seat";
            }
        }
    }
}
</script>

<style>

/**************** Seating Chart **************/

#seatChart {
    width: 100%;
    /* border: 1px solid white; */
    /* border-radius: 5px; */
}

#seatsHead {
    display: block;
    width: 90%;
    margin: 20px auto 10px auto;
    padding-top: 2%;
    border-top: 3px solid white;
    border-radius: 40%;
    font-size: 5em;
}

#seats {
    display: flex;
    justify-content: space-around;
    flex-wrap: wrap;
    margin: auto;
    padding: 2% 4%;
}

.seat {
    /* width: 8%; */
    flex: 1 1 9%;
    font-size: .6em;
    border: 1px solid white;
    border-bottom-left-radius: 10px;
    border-bottom-right-radius: 10px;
    margin: .5%;
    padding: 2% .5%;

}

.seat:hover {
    cursor: pointer;
}

.selected {
  background-color: red;
}

#seatSelect {
    width: 100px;
    height: 50px;
    margin-top: 15px;
    margin-bottom: 20px;
    background-color: lightgray;
    border-radius: 5%;
    font-size: 2em;
}

</style>
