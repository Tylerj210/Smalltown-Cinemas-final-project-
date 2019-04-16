<template>
    <div>
        <div>
            <form v-on:submit.prevent="query">
                <label>Movie Title: </label>
                <input v-model="searchString">
                <button>Submit</button>
            </form>
        </div>
        <div> 
            <table>
                <th>TITLE</th><th>RELEASE</th>
                <tr v-for="movie in movieResults.results" v-bind:key="movie.key">
                    <td>{{movie.title}}</td><td>{{movie.release_date}}</td>
                </tr>
            </table>
        </div>
    </div>
</template>

<script>
export default {
    name:'Manage',
    data(){
        return{
            searchString: '',
            movieResults: [],
            MOVIE_DB_API: 'https://api.themoviedb.org/3',
            MOVIE_DB_KEY: '8d04c38ec89333dce4c70f77712eb41d',
            selectedMovie:{}
        }
    },
    methods:{
        query(){
            console.log(`${this.MOVIE_DB_API}/search/movie?api_key=${this.MOVIE_DB_KEY}&query=${this.searchString}`);
            fetch(`${this.MOVIE_DB_API}/search/movie?api_key=${this.MOVIE_DB_KEY}&query=${this.searchString}`, {
            method: "GET",
            })
            .then(response => response.json())
            .then(moviesJSON => {
                this.movieResults = moviesJSON;
                
                console.log(this.movieResults);
            })
        }
    }
}
</script>

<style>

</style>
