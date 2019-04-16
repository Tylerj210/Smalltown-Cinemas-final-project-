<template>
    <div>
        <div id="manage-wrapper" v-if="adminUser">
            <div id="movie-scheduler">
                <div id="viewing-form">
                    <form v-on:submit.prevent="updateViewings">
                        <label>SHOW DATE (YYYY-MM-DD): </label>
                        <input type="date" v-model="viewDate" v-on:change="loadShowtimes">
                        <label>THEATER NUMBER</label>
                        <select v-model="theaterNum" v-on:change="loadShowtimes">
                            <option v-for="n in 6" v-bind:key="n">{{n}}</option>
                        </select>
                        <input v-model="theViewing.movie.title">
                        <table>
                            <th>Time</th><th>Hour</th><th>Minute</th><th>Remove?</th>
                            <tr v-for="(showtime,n) in theViewing.showtimes" v-bind:key="n" class="time-list">
                                <td>{{n+1}}</td>
                                <td><input type="number" v-model="theViewing.showtimes[n].time.hour"></td>
                                <td><input type="number" v-model="theViewing.showtimes[n].time.minute"></td>
                                <td> 
                                    <div v-on:click="remove(n)" class="remove-time">x</div>
                                </td>
                            </tr>
                            <tr>
                                <td>Add</td><td><div v-on:click="addTime" class="add-time">+</div></td>
                            </tr>
                        </table>
                        <div>{{message}}</div>
                        <button>Update Movie Showtime</button>
                    </form>
                </div>
            </div>
            <hr>
            <hr>
            <div id="movie-search">
                <div>
                    <form v-on:submit.prevent="query">
                        <label>Movie Title: </label>
                        <input v-model="searchString">
                        <label>Release Year: </label>
                        <input v-model="searchYear">
                        <button>Search For Movies</button>
                    </form>
                </div>
                <div> 
                    <table>
                        <th>TITLE</th><th>Description</th><th>RELEASE</th>
                        <tr v-for="movie in movieResults.results" v-bind:key="movie.key" class="movie-results">
                            <td>{{movie.title}}</td>{{movie.overview}}<td></td><td>{{movie.release_date}}</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <div v-if="!adminUser">
            <h1>403</h1>
            <h2>Forbidden</h2>
        </div>
    </div>
</template>

<script>
import auth from "@/shared/auth.js";

export default {
    name:'Manage',
    data(){
        return{
            searchString: '',
            searchYear: '',
            movieResults: [],
            MOVIE_DB_API: 'https://api.themoviedb.org/3',
            MOVIE_DB_KEY: '8d04c38ec89333dce4c70f77712eb41d',
            selectedMovie: {},
            theViewing: {movie:{title:'',
                                actors:[],
                                description:'',
                                genres:[],
                                id:'',
                                image:'',
                                officialSite:'',
                                rating:'',
                                releaseDate:{
                                    dayOfMonth:'',
                                    dayOfWeek:'',
                                    dayOfYear:'',
                                    month:'',
                                    monthValue:'',
                                    year:''
                                },
                                runtime:'',
                                trailerLink:''
                            },
                        showtimes:[{time:{hour:'',minute:''}},{time:{hour:'',minute:''}},{time:{hour:'',minute:''}},{time:{hour:'',minute:''}}],
                        theaterNum:''
            },
            viewDate: new Date(),
            theaterNum: 1,
            message:''
        }
    },
    methods:{
        query(){
            if(this.searchString!=''){
                fetch(`${this.MOVIE_DB_API}/search/movie?api_key=${this.MOVIE_DB_KEY}&query=${this.searchString}${this.searchYear==''?'':'&primary_release_year='+this.searchYear}`, {
                method: "GET",
                })
                .then(response => response.json())
                .then(moviesJSON => {
                    this.movieResults = moviesJSON;
                })
            }
        },
        loadShowtimes(){
            if(new Date(this.viewDate).getTime()>Date.now()-(1000*24*60*60)){
                const showDate = Math.ceil((new Date(this.viewDate).getTime()-Date.now())/(1000*24*60*60));
                const showtime = {days:showDate,theaterId:this.theaterNum}
                
                console.log(showtime);
                fetch(`${process.env.VUE_APP_REMOTE_API}/movie/showtimes/`, {
                method: "POST",
                headers: {
                    // A Header with our authentication token.
                    "Content-Type": "application/json",
                    Authorization: "Bearer " + auth.getToken()
                }, 
                body:JSON.stringify(showtime)
                })
                .then(response => response.json())
                .then(viewingJSON => {
                    this.theViewing = viewingJSON;
                })
            }
        },
        remove(n){
            this.theViewing.showtimes.splice(n,1);
        },
        addTime(){
            this.theViewing.showtimes.push({time:{hour:Number,minute:Number}})
        },
        updateViewings(){
            console.log(JSON.stringify(this.theViewing))
            const date = new Date;
            console.log(date.setDate('2019-01-01'))
            if(this.theViewing.movie.id!=''){
                fetch(`${process.env.VUE_APP_REMOTE_API}/movie/update-times/`, {
                method: "POST",
                headers: {
                    // A Header with our authentication token.
                    "Content-Type": "application/json",
                    Authorization: "Bearer " + auth.getToken()
                }, 
                //body:JSON.stringify(this.theViewing)
                })
                .catch(error=>{

                })
            }
        }
    },
    computed:{
        adminUser(){
            return auth.getUser().rol=='admin';
        }
    }
}
</script>

<style>
div{
    max-width:100%;
}
table{
    width:100%;
}
.movie-results{
    margin-bottom:5px;
    width:100%;
}
.movie-results td{
    max-width:40%;
}
#viewing-form form *{
    padding:0px;
    margin:10px;
}
td{
    text-align: center;
}
.remove-time{
    cursor:pointer;
    background-color:red;
    border-radius:50%;
    color:white;
    width:2em;
    justify-self:center;
}
.add-time{
    cursor:pointer;
    background-color:green;
    border-radius:50%;
    color:white;
    width:2em;
    justify-self:center;
}
button{
    height:30px;
}
</style>
