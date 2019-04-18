<template>
    <div id="tickets">
        <h1 id="mainTicketHeading"> Purchase tickets  </h1>
        <div class="progress-bar">
            <div class="step active"></div>
            <div class="step"></div>
            <div class="step"></div>
            <div class="step"></div>
        </div>
        <div id="ticket-wrapper">
            <div id="selectedMovie">
                <img v-bind:src="this.theMovie.image" id="movieImage">
                <div id="movieInfo">
                    <p>Theater: {{this.showtime.showtime.theaterId}}</p>
                    <p>Tickets Selected: {{selectedSeats.length}}</p>
                    <p>Seats:</p>
                    <div id="seatId">
                        <ul>
                            <li v-for="ticket in selectedSeatNumbers()" v-bind:key="ticket">
                                {{ticket}} - ${{showtime.showtime.price}}
                            </li>
                        </ul>
                    </div>               
                    <p>Total Price: ${{selectedSeats.length*showtime.showtime.price}}</p>
                </div>
            </div>
            <div v-show="views[0].show" id="seatChart">
                <span id="heading"> Seats </span>
                <div id="seats">
                    <span v-for="seat in showtime.seats" class="seat" v-bind:key="seat.seatId" v-bind:class="{ notAvailable: !seat.available }" v-on:click="toggleSelected(seat, $event)">
                        {{seat.seatNumber}}
                    </span>
                </div>
                <p v-show="message != ''">{{message}}</p>
                <button class="btn" v-on:click="verifySeats()">Next</button>
            </div>
            <div v-show="views[1].show" id="payment">
                <span id="heading">Payment</span>
                <form id="paymentForm" class="formLayout">
                    <div id="name" class="section">
                        <label for="firstName">First Name: </label>
                        <input type="text" name="firstName" id="firstName" v-model="paymentForm.firstName" placeholder="First">
                        <label for="lastName">Last Name: </label>
                        <input type="text" name="lastName" id="lastName" v-model="paymentForm.lastName" placeholder="Last">
                    </div>
                    <div id="address" class="section">
                        <label class="row" for="streetAddress">Street Address: </label>
                        <input class="row" type="text" name="streetAddress" id="streetAddress" v-model="paymentForm.streetAddress" placeholder="Street">
                        <label class="row" for="city">City: </label>
                        <input class="row" type="text" name="city" id="city" v-model="paymentForm.city" placeholder="City">
                        <label class="row" for="city">State: </label>
                        <input class="row" type="text" name="state" id="state" v-model="paymentForm.state" placeholder="ST">
                        <label class="row" for="zipCode">Zip Code: </label>
                        <input class="row" type="text" name="zipCode" id="zipCode" v-model="paymentForm.zipCode" placeholder="12345">
                    </div>
                    <div id="card" class="section">
                        <label class="row" for="number">Email </label>
                        <input class="row" type="text" name="email" id="email" v-model="paymentForm.email" placeholder="example@gmail.com">
                        <Label class="row" for="exp"> Phone </Label>
                        <input class="row" type="text" name="phone" id="phone" v-model="paymentForm.phoneNum" placeholder="(000) 000 - 0000">
                    </div>                    
                </form>
                <p v-show="message != ''">{{message}}</p>
                <button class="btn"  v-on:click="getView(backView)">Back</button>
                <button class="btn"  v-on:click="verifyPayment()">Next</button>
            </div>
            <div v-show="views[2].show" id="comfirmation">
                <span id="heading"> Confirmation </span>
                <table id="comfirmTable">
                    <tr>
                        <td>First Name:</td>
                        <td>{{paymentForm.firstName}}</td>
                    </tr>
                    <tr>
                        <td>Last Name:</td>
                        <td>{{paymentForm.lastName}}</td>
                    </tr>
                    <tr>
                        <td>Street Address:</td>
                        <td>{{paymentForm.streetAddress}}</td>
                    </tr>
                    <tr>
                        <td>City:</td>
                        <td>{{paymentForm.city}}</td>
                    </tr>
                    <tr>
                        <td>State:</td>
                        <td>{{paymentForm.state}}</td>
                    </tr>
                    <tr>
                        <td>Zip Code:</td>
                        <td>{{paymentForm.zipCode}}</td>
                    </tr>
                    <tr v-if="this.paymentForm.email.length != 0">
                        <td>Email:</td>
                        <td>{{paymentForm.email}}</td>
                    </tr>
                    <tr v-if="this.paymentForm.phoneNum.length != 0">
                        <td>Phone:</td>
                        <td>{{paymentForm.phoneNum}}</td>
                    </tr>
                </table>    
                <button class="btn" v-on:click="getView(backView)">Edit</button>
                <button class="btn" v-on:click="getView(3)">Finish</button>              
            </div>
            <div v-show="views[3].show" id="completed">
                <span id="heading"> Purchase Completed! </span>
                <p>You will recieve an email containing your purchase number</p>
                <p>Enjoy the show!</p>
                
                <div class="ticket-wrapper">
                    <table class="ticketStub" v-for="ticket in selectedSeatNumbers()" v-bind:key="ticket">
                        <tr>
                            <td>{{theMovie.title}}</td>
                        </tr>
                        <tr>
                            <td>Theater</td>
                            <td>Seat #</td>
                            <td>Price</td>
                        </tr>
                        <tr>
                            <td>{{showtime.showtime.movieId}}</td>
                            <td>{{ticket}}</td>
                            <td>${{showtime.showtime.price}}</td>
                        </tr>
                    </table>
                </div>  

                <!-- <div id="printableReceipt">
                    <p>{{paymentForm.firstName}} {{paymentForm.lastName}}</p>
                    <p>{{showtime.showtime.movieId}}</p>
                    <p>Tickets Selected: {{selectedSeats.length}}</p>
                    <p>Seat Numbers:</p>
                    <p v-for="ticket in selectedSeatNumbers()" v-bind:key="ticket">
                      {{ticket}} - ${{showtime.showtime.price}} </p>
                    <p> Total Price: ${{selectedSeats.length*showtime.showtime.price}}</p>
                </div> -->
            </div>
        </div>
    </div>
</template>


<script>
import auth from "@/shared/auth.js";
// import Seats from "@/components/checkout/seats.vue";
// import Payments from "@/components/checkout/payments.vue";

export default {
    name:"tickets",
    components: {
        // Seats,
        // Payments
},
data() {
return {
    currentView: 0,
    selectedSeats: [],
    showtime: {seats:[],showtime:{}},
    views: [
        {
          name: 'seats',
          show: true
        },
        {
          name: 'payment',
          show: false
        },{
          name: 'confirmation',
          show: false
        },{
          name: 'completed',
          show: false
        }
    ],
    lastView: 0,
    backView: 0,
    paymentForm: {
        firstName: '',
        lastName: '',
        streetAddress: '',
        city: '',
        state: '',
        zipCode: '',
        email: '',
        phoneNum: ''
    }, 
    message: '',
    reservation:[],
    theMovie: {title: ""}
    };

},

methods: {
    toggleSelected(seat, event){
        let seatSelected = event.target;
        let seatId = seat.seatId;
        if(!seatSelected.classList.contains('notAvailable')){
            if(seatSelected.classList.contains('selected')){
                seatSelected.classList.remove('selected');
                let seatIndex = (this.selectedSeats).indexOf(seatId);
                (this.selectedSeats).splice(seatIndex, 1);
            } else {
                seatSelected.classList.add('selected');
                this.selectedSeats.push(seatId);    
                     
            }
        }
    },
    verifySeats(){
        let seats = document.getElementsByClassName("selected");
        if(seats.length > 0){
            this.claimSeats();
            this.message = '';
            this.getView(1);
        } else {
            this.message = "Please choose a seat";
        }
    },
    verifyPayment(){
        let payment = this.paymentForm;
        if(payment.firstName == '' || payment.lastName == '' || payment.streetAddress == '' || payment.city == '' || payment.state == ''
        || payment.zipCode == '' || (payment.email == '' && payment.phoneNum == '')){
            this.message = "Please fill in all fields \n";
        }  else {
            this.message = '';
            this.getView(2);
        }
    },
    localMovieById(){
      fetch(`${process.env.VUE_APP_REMOTE_API}/movie/movies/${this.showtime.showtime.movieId}`, {
        method: "GET",
        headers: {
        // A Header with our authentication token.
          "Content-Type": "application/json",
          Authorization: "Bearer " + auth.getToken()
        }
        })
        .then(response => response.json())
        .then(movieJSON => {
            this.theMovie = movieJSON;
        })
    },
    getView(nextView){
        this.message = '';
        let steps = document.getElementsByClassName('step');
        if(nextView == 0){
            this.releaseSeats();
            this.lastView = this.currentView;
            this.currentView = nextView;
            this.backView = 0;
            this.views[this.lastView].show = false;
            this.views[this.currentView].show = true;
        } else if(nextView == 3){
            this.confirmSeats();
            this.lastView = this.currentView;
            this.backView = nextView-1;
            this.currentView = nextView;
            this.views[this.lastView].show = false;
            this.views[this.currentView].show = true;
        }   else {
            this.lastView = this.currentView;
            this.backView = nextView-1;
            this.currentView = nextView;
            this.views[this.lastView].show = false;
            this.views[this.currentView].show = true;
        }
    
        for(let i = 0; i < steps.length; i++){
            if(i <= this.currentView){
                steps[i].classList.add('active');
                if(i < this.currentView){
                    steps[i].classList.add('completed');
                }
            } else { 
                    steps[i].classList.remove('active');
                    steps[i].classList.remove('completed');
            }
        }
        window.scrollTo(0,0);
    },
    claimSeats() {
        const res = this.seatData();
        
        console.log(res);
        fetch(`${process.env.VUE_APP_REMOTE_API}/seats/book`, {
            method: "POST",
            body: JSON.stringify(res),
            headers: {
            // A Header with our authentication token.
            Authorization: "Bearer " + auth.getToken(),
            "Content-Type":"application/json"
            }
            
        })
        .then(response => response.json())
        .then(reservationJSON => {
            this.reservation = reservationJSON;
        })
        .catch(error => {
            console.error(error)
        })
    },
    seatData(){
        return {
            seats:this.selectedSeats,
            showtime:this.showtime.showtime.showtimeId
        }
    },
    selectedSeatNumbers(){
        let selected=[];
        if (this.showtime.seats.length > 0) {
            this.showtime.seats.forEach(seat=>{
                this.selectedSeats.forEach(inList=>{
                    if(seat.seatId==inList){
                        selected.push(seat.seatNumber)
                    }
                })
            })
        }
        return selected;  
    },
    getPurchasedMovie(){
        fetch(`${process.env.VUE_APP_REMOTE_API}/movie/movies/${this.showtime.showtime.movieId}`, {
            method: "GET",
            headers: {
                // A Header with our authentication token.
                "Content-Type": "application/json",
                // Authorization: "Bearer " + auth.getToken()
            } 
        })
    },
    releaseSeats() {
        const res = {reservationId:this.reservation.reservationId};
            console.log("releasing seats");
            fetch(`${process.env.VUE_APP_REMOTE_API}/seats/book`, {
                method: "DELETE",
                body: JSON.stringify(res),
                headers: {
                // A Header with our authentication token.
                Authorization: "Bearer " + auth.getToken(),
                "Content-Type":"application/json"
                }
                
            })
            .then(response => response.json())
            .then(reservationJSON => {
                this.reservation = reservationJSON;
                
            })
            .catch(error => {
                console.error(error)
            })
        
    },
    confirmSeats() {
        const res = {reservationId:this.reservation.reservationId};
        
        console.log(res);
        fetch(`${process.env.VUE_APP_REMOTE_API}/seats/book`, {
            method: "PUT",
            body: JSON.stringify(res),
            headers: {
            // A Header with our authentication token.
            Authorization: "Bearer " + auth.getToken(),
            "Content-Type":"application/json"
            }
            
        })
        .then(response => response.json())
        .then(reservationJSON => {
            this.reservation = reservationJSON;
        })
        .catch(error => {
            console.error(error)
        })
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
            this.localMovieById();
    })
    window.onbeforeunload=this.releaseSeats();
}
}
</script>

<style>

#printableReceipt {
    background-color: white !important;
    margin-right: 20px;
    margin-left: 20px;
    color: black;
}

#ticketData {
    background-color: black;
    border-radius: 50px;
    border-width:0px;
}

#tickets {
    margin-top: 30px;
    text-align: center;
    color: white;
}

#ticket-wrapper{
  max-width: 90%;
  min-height: 500px;
  margin: 20px auto;
  margin-bottom: 60px;
  padding: 30px 0px;
  border: 3px solid #800020;
  border-radius: 12px;
  box-shadow: 5px 10px 20px 4px rgba(255,215,0,80%);
  color: rgba(255,215,0,90%);
  text-align:center;
  background-color: #000;  
}

#mainTicketHeading {
    margin: 0;
}

#heading {
    display: block;
    width: 90%;
    margin: 20px auto 10px auto;
    padding-top: 4%;
    border-top: 3px solid white;
    border-radius: 40%;
    font-size: 2em;
}

.btn {
    width: 100px;
    height: 50px;
    margin: 15px 10px;
    background-color: lightgray;
    border-radius: 25px;
    font-size: 2em;
}

.btn:hover {
    cursor: pointer;
    background-color: darkgray;
}

/**************** Progress Bar **************/
.progress-bar {
  display: flex;
  margin: 5% auto;
  max-width: 50%;
  justify-content: space-between;
}

.step {
  box-sizing: border-box;
  position: relative;
  z-index: 1;
  display: block;
  width: 25px;
  height: 25px;
  margin-bottom: 30px;
  border: 4px solid gold;
  border-radius: 50%;
  background-color: #efefef;
}
 
.step:after {
  position: absolute;
  z-index: -1;
  top: 5px;
  left: 22px;
  width: 225px;
  height: 6px;
  content: '';
  background-color: #efefef;
}
 
.step:before {
  color: #2e2e2e;
  color: white !important;
  position: absolute;
  top: 40px;
}

.step::before {
  font-size: .5em;
}
 
.step.active {
  background-color: #800020;
}
.step.active:after {
  background-color: #800020;
}
.step.completed:before {
  color: #800020;
}

.step.completed::after {
    color: #800020;
}

.step.active + .step:before {
  color: #800020;
  /*#f62f5e if preferred*/
}

 
.step:nth-child(1):before {
  content: 'Seats';
  left: -1px;
}
.step:nth-child(2):before {
  right: -9px;
  content: 'Payment';
}
.step:nth-child(3):before {
  right: -15px;
  content: 'Confirmation';
}
.step:nth-child(4):before {
  right: -2px;
  content: 'Finish';
}

.step:last-child:after {
    border: 4px solid #000;
    background-color: #000;
    background-color: #000;
}

/**************** Seating Chart **************/

#seatChart {
    width: 100%;
    position: relative;
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

.notAvailable {
    background-color: white;
    cursor: default !important;
}

.selected {
  background-color: red;
}

/**************** Payment **************/

#payment {
    background-color: rgba(128,0,32,.9);
    width: 90%;
    min-height: 1000px;
    margin: 2% auto;
    padding: 2%;
    border-radius: 5%;   
}

#comfirmation {
    background-color: rgba(128,0,32,.9);
    width: 90%;
    margin: 2% auto;
    padding: 2%;
    border-radius: 5%;
}

.formLayout {
    width: 90%;
    height: 800px;
    margin: auto;
    display: flex;
    flex-direction: column;
    justify-content: space-around;
    text-align: left;
    color: white !important;
}

input {
    height: 45px;
    font-size: 100%;
    padding-left: 20px;
    border-radius: 25px;
}

#seatId {
    left: 5px;
}

input::placeholder {
  color: rgba(145,145,145,.4);
  font-size: 100%;
}

.formLayout .section {
    display: flex;
    flex-direction: column;
    justify-content: space-around;
    font-size: 1.5em;
}

#comfirmTable {
    width: 90%;
    margin: 30px auto;
    text-align: left;
    color: white !important;
}

#comfirmTable td {
    text-align: left;
}

#comfirmForm span {
    display: block;
    max-width: 50%;
    font-size: .6em;
}

#selectedMovie {
    max-width: 90%;
    max-height: 200px;
    margin: auto;
    display: flex;
    justify-content: center;
}

#movieInfo {
    display: flex;
    flex-direction: column;
    justify-content: space-around;
    text-align: left;
    margin-left: 30px;
}

#movieInfo * {
    margin: 0px;
}

#movieImage {
    max-width: 160px;
    height: auto;
}

.ticket-wrapper {
    max-width: 90%;
    background-color: white;
    margin: auto;
    display: flex;
    flex-direction: column;
    justify-content: space-around;
}

.ticketStub {
    width: 96%;
    min-height: 50px;
    margin: 3px auto;
    background-color: white;
    border: 1px dashed black;
    color: black !important;
}

.ticketStub td {
    width: 30%;
}

.ticketStub td:first-child {
    border-right: 1px solid black;
}

.ticketStub td:last-child {
    border-left: 1px solid black;
}


@media screen and (min-width: 600px) {

    .progress-bar {
        margin: 5% auto;
    }

    .seat {
        padding: 1% .5%;
    }

    .ticket-wrapper {
    max-width: 600px;

    }
}


@media screen and (min-width: 768px) {

    .seat {
        font-size: 1em;
        margin: 2px;
        padding: 2px;

    }

    #heading {
        width: 90%;
        margin: 20px auto 5px auto;
        padding-top: 2%;
        border-top: 3px solid white;
        border-radius: 40%;
        font-size: 3em;
    }

    #comfirmTable {
        max-width: 600px;
        margin-left: 15%;
        
    }

    #comfirmTable td {
        width: 50%;
        font-size: 1.5em;
    }

}

@media screen and (min-width: 992px) {

    .progress-bar {
        max-width: 700px;
        margin: 2% auto;
    }


}
</style>
