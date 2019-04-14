<template>
    <div v-show="views[1].show" id="payment">
                <span id="seatsHead"> Payment </span>
                <div class="pagewrap">
                <form class="form" id="form">
                    <h3 class="form__title">Login</h3>
                    <div class="container">
                        <input class="container__input" type="text" id="username" name="username" value="" required>
                        <label id="userLabel" for="username" class="container__label">Username</label>
                    </div>
                    <div class="container">
                        <input class="container__input" type="password" id="pass" name="password" value="" required>
                        <label id="passLabel" for="pass" class="container__label">Password</label>
                    </div>
                    <button class="form__submit" id="submit" type="button" value="submit">Submit</button>
                </form>
                <!-- <form id="paymentForm">
                    <div id="name" class="section">
                        <label for="firstName">First Name: </label>
                        <input type="text" name="firstName" id="firstName" placeholder="first">
                        <label for="lastName">Last Name: </label>
                        <input type="text" name="lastName" id="lastName" placeholder="last">
                    </div>
                    <div id="address" class="section">
                        <label class="row" for="streetAddress">Street Address: </label>
                        <input class="row" type="text" name="streetAddress" id="streetAddress" placeholder="first">
                        <label class="row" for="city">City: </label>
                        <input class="row" type="text" name="city" id="city" placeholder="city">
                        <label class="row" for="city">State: </label>
                        <input class="row" type="text" name="state" id="state" placeholder="ST">
                        <label class="row" for="areaCode">Area Code: </label>
                        <input class="row" type="text" name="areaCode" id="areaCode" placeholder="1234">
                    </div>
                    <div id="card" class="section">
                        <label class="row" for="number">Card Number: </label>
                        <input class="row" type="text" name="number" id="number" placeholder="****-****-****-****">
                        <Label class="row" for="exp"> Exp: </Label>
                        <input class="row" type="text" name="exp" id="exp" placeholder="MM/YY">
                        <Label class="row" for="secNum"> Sec.Num: </Label>
                        <input class="row" type="text" name="secNum" id="secNum" placeholder="123">
                    </div>                    
                </form> -->
                </div>
                <p v-show="message != ''">{{message}}</p>
                <button id="seatSelect" v-on:click="getView(backView)">Back</button>
                <button id="seatSelect" v-on:click="verifyPayment()">Next</button>
            </div>
</template>

<script>
export default {
    name:"payments",
    components: {  

    }, 
    methods: {
        verifyPayment(){
        let firstName = document.getElementById('firstName').value;
        let lastName = document.getElementById('lastName').value;
        if(firstName == '' && lastName == ''){
            this.message = "Please fill in first name and last name";
        } else if(firstName == '' && lastName != ''){
            this.message = "Please fill in first name"; 
        } else if(firstName != '' && lastName == ''){
            this.message = "Please fill in last name"; 
        } else if(firstName != '' && lastName != ''){
            this.message = '';
            this.getView(2);
        }
    }
    }
}
</script>

<style>

/**************** Payment **************/

#payment {
    background-color: rgba(145,145,145,.4);
    width: 90%;
    min-height: 1000px;
    margin: 10% auto;
    padding: 2%;
    border-radius: 5%;   
}

#paymentForm {
    height: 900px;
    display: flex;
    flex-direction: column;
    justify-content: space-around;
}
.form {
  width: 95%;
  height: 90%;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-flow: column wrap;
  background-color: #ecedee;
  border-radius: 5px;
}

.pagewrap {
    max-width: 100%; 
    height: 100vh; 
    margin: 0 auto; 
    display: flex; 
    justify-content: center; 
    align-items: center;
    background: #74ebd5;
  background: -webkit-linear-gradient(to bottom, #74ebd5, #acb6e5);
  background: linear-gradient(to bottom, #74ebd5, #acb6e5);
  font-size: 16px;
  line-height: 1.2;
  color: #888;
}

#paymentForm .section {
    flex-basis: 30%;
    display: flex;
    flex-direction: column;
    justify-content: space-around;
    font-size: 2em;
}

.row {
    display: block;
   flex-grow: 5%;
}

</style>
