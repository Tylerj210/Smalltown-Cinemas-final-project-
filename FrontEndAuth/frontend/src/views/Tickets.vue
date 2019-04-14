<template>
    <div id="tickets">
        <h1> Purchase tickets  </h1>
        <div class="progress-bar">
            <div class="step active"></div>
            <div class="step"></div>
            <div class="step"></div>
            <div class="step"></div>
        </div>
        <div id="ticket-wrapper">
            <!-- <seats v-show="views[0].show"></seats> -->
            <!-- <payments v-show="views[1].show"></payments> -->
            <div v-show="views[0].show" id="seatChart">
                <span id="heading"> Seats </span>
                <div id="seats">
                    <span v-for="seat in showtime.seats" class="seat" v-bind:class="{ notAvailable: !seat.available }" v-on:click="toggleSelected(seat, $event)">{{seat.seatNumber}}</span>
                </div>
                    <p v-show="message != ''">{{message}}</p>
                    <button class="btn" v-on:click="verifySeats()">Next</button>
            </div>
            <div v-show="views[1].show" id="payment">
                <span id="heading">Payment</span>
                <form id="paymentForm" class="formLayout">
                    <div id="name" class="section">
                        <label for="firstName">First Name: </label>
                        <input type="text" name="firstName" id="firstName" v-model="paymentForm.firstName" placeholder="first">
                        <label for="lastName">Last Name: </label>
                        <input type="text" name="lastName" id="lastName" v-model="paymentForm.lastName" placeholder="last">
                    </div>
                    <div id="address" class="section">
                        <label class="row" for="streetAddress">Street Address: </label>
                        <input class="row" type="text" name="streetAddress" id="streetAddress" v-model="paymentForm.streetAddress" placeholder="street">
                        <label class="row" for="city">City: </label>
                        <input class="row" type="text" name="city" id="city" v-model="paymentForm.city" placeholder="city">
                        <label class="row" for="city">State: </label>
                        <input class="row" type="text" name="state" id="state" v-model="paymentForm.state" placeholder="ST">
                        <label class="row" for="zipCode">Zip Code: </label>
                        <input class="row" type="text" name="zipCode" id="zipCode" v-model="paymentForm.zipCode" placeholder="1234">
                    </div>
                    <div id="card" class="section">
                        <label class="row" for="number">Card Number: </label>
                        <input class="row" type="text" name="number" id="number" v-model="paymentForm.cardNum" placeholder="****-****-****-****">
                        <Label class="row" for="exp"> Exp: </Label>
                        <input class="row" type="text" name="exp" id="exp" v-model="paymentForm.exp" placeholder="MM/YY">
                        <Label class="row" for="secNum"> Sec.Num: </Label>
                        <input class="row" type="text" name="secNum" id="secNum" v-model="paymentForm.secNum" placeholder="123">
                    </div>                    
                </form>
                <!-- </div> -->
                <p v-show="message != ''">{{message}}</p>
                <button class="btn"  v-on:click="getView(backView)">Back</button>
                <button class="btn"  v-on:click="verifyPayment()">Next</button>
            </div>
            <div v-show="views[2].show" id="confirmation">
                <span id="heading"> Confirmation </span>
                <div id="confirmForm" class="formLayout">
                    <div id="name" class="section">
                        <label for="firstName">First Name: </label>
                        <input type="text" name="firstName" id="firstName" v-model="paymentForm.firstName" disabled>
                        <label for="lastName">Last Name: </label>
                        <input type="text" name="lastName" id="lastName" v-model="paymentForm.lastName" disabled>
                    </div>
                    <div id="address" class="section">
                        <label class="row" for="streetAddress">Street Address: </label>
                        <input class="row" name="streetAddress" id="streetAddress" v-model="paymentForm.streetAddress" disabled>
                        <label class="row" for="city">City: </label>
                        <input class="row" type="text" name="city" id="city" v-model="paymentForm.city" disabled>
                        <label class="row" for="city">State: </label>
                        <input class="row" type="text" name="state" id="state" v-model="paymentForm.state" disabled>
                        <label class="row" for="zipCode">Zip Code: </label>
                        <input class="row" type="text" name="zipCode" id="zipCode" v-model="paymentForm.zipCode" disabled>
                    </div>
                    <div id="card" class="section">
                        <label class="row" for="number">Card Number: </label>
                        <input class="row" type="text" name="number" id="number" v-model="paymentForm.cardNum" disabled>
                        <Label class="row" for="exp"> Exp: </Label>
                        <input class="row" type="text" name="exp" id="exp" v-model="paymentForm.exp" disabled>
                        <Label class="row" for="secNum"> Sec.Num: </Label>
                        <input class="row" type="text" name="secNum" id="secNum" v-model="paymentForm.secNum" disabled>
                    </div> 
                </div>    
                <button class="btn" v-on:click="getView(backView)">Edit</button>
                <button class="btn" v-on:click="getView(3)">Finish</button>              
            </div>
            <div v-show="views[3].show" id="completed">
                <span id="heading"> Purchase Completed! </span>
                <p>You will recieve an email containing your purchase number</p>
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
    showtime: [],
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
        cardNum: '',
        exp: '',
        secNum: ''
    }, 
    message: ''
    };

},

methods: {
    toggleSelected(seat, event){
        let seatSelected = event.target;
        let seatId = seat.seatId;
        if(!seatSelected.classList.contains('notAvailable')){
            if(seatSelected.classList.contains('selected')){
                seatSelected.classList.remove('selected');
                let seatIndex = Array.from(this.selectedSeats).indexOf(seatId);
                Array.from(this.selectedSeats).splice(seatIndex, 1);
            } else {
                seatSelected.classList.add('selected');
                this.selectedSeats = seatId;          
            }
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
    },
    verifyPayment(){
        let payment = this.paymentForm;
        if(payment.firstName == '' || payment.lastName == '' || payment.streetAddress == '' || payment.city == '' || payment.state == ''
        || payment.zipCode == '' || payment.cardNum == '' || payment.exp == '' || payment.secNum == ''){
            this.message = "Please fill in all fields";
        }  else {
            this.message = '';
            this.getView(2);
        }
    },
    getView(nextView){
        this.message = '';
        let steps = document.getElementsByClassName('step');
        if(nextView == 0){
            this.lastView = this.currentView;
            this.currentView = nextView;
            this.backView = 0;
            this.views[this.lastView].show = false;
            this.views[this.currentView].show = true;
        } else {
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

#ticket-wrapper{
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
  margin: 8% auto;
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
  border: 4px solid #fff;
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
  background-color: #f62f5e;
}
.step.active:after {
  background-color: #f62f5e;
}
.step.completed:before {
  color: #f62f5e;
}

.step.active + .step:before {
  color: #f62f5e;
}

 
.step:nth-child(1):before {
  content: 'Seats';
}
.step:nth-child(2):before {
  right: -10px;
  content: 'Payment';
}
.step:nth-child(3):before {
  right: -20px;
  content: 'Confirmation';
}
.step:nth-child(4):before {
  right: 0;
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
    /* border: 1px solid white; */
    /* border-radius: 5px; */
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
}

.selected {
  background-color: red;
}

/**************** Payment **************/

#payment, #confirmation {
    background-color: rgba(128,0,32,.9);
    width: 90%;
    min-height: 1000px;
    margin: 10% auto;
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

input::placeholder {
  color: rgba(145,145,145,.4);
  font-size: 100%;
  /* padding-left: 10px; */
}

.formLayout .section {
    flex-basis: 1 2 1;
    display: flex;
    flex-direction: column;
    justify-content: space-around;
    font-size: 1.5em;
}

/* #confirmForm input {
    
} */

@media screen and (min-width: 768px) {

}

</style>
