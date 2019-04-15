<!-- 
  The Header component is used to house the UI and logic to display the header for the web page.
  NOTES:
  - The navigation displays some items depending if the user has logged in or not.  
  DEPENDENCIES:
    None
-->

<template>
  <header>
    <div class="container">
      <h1 id="theaterName">Smalltown Cinemas</h1>
      <nav>
        <ul id="nav-bar">
          <li class="left-nav">
            <router-link to="/">Home</router-link>
          </li>
          <li v-if="isAuthenticated" id="userName" v-on:mouseover="seeOptions()" v-on:mouseout="hideOptions()">
            Hey, {{getUser}}!
            <ul id="userOptions">
              <li v-if="getRole=='admin'">
                <router-link to="/manage" id="userOption-manage">Manage Movies</router-link>
              </li>
              <li v-if="isAuthenticated">
                <a href="/" v-on:click.prevent="logout" id="userOption-logout">Logout</a>
              </li>
            </ul>
          </li>
          <li v-else>
            <router-link to="/login">Login</router-link>
          </li>
        </ul>
      </nav>
    </div>
  </header>
</template>

<script>
import auth from "@/shared/auth";

export default {
  name: "the-header",
  data() {
    return {
      isAuthenticated: auth.getUser() !== null
    };
  },
  methods: {
    /**
     * Logs the user out and takes them to the login page
     * @function
     */
    logout() {
      auth.destroyToken();
      this.$router.push("/");
      location.reload();
    }, 
    seeOptions(){
      let optionsList = document.getElementById('userOptions')
      optionsList.style.display = "block";
    },
    hideOptions(){
      let optionsList = document.getElementById('userOptions')
      optionsList.style.display = "none";
    }
  },
  computed: {
    getUser() {
      return auth.getUser().sub;
    },
    getRole(){
      return auth.getUser().rol;
    }
  }
};
</script>

<style scoped>


header {
  background-color: #800020;
  border-bottom: 1px solid #800020;
  box-shadow: inset -1px 2px 38px 22px rgba(0,0,0,0.3);
  width:100%;

}

#theaterName {
  font-family: 'Fascinate Inline', cursive;
  text-align: center;
  margin-top: 0;
  margin-bottom: 0;
  font-size: 55px;
  color: rgba(255,215,0,80%);
  text-shadow: 2px 2px black;
}

#nav-bar {
  display: flex;
  justify-content: space-between;
  padding-left: 0;
  margin: 0;
}

li {
  list-style: none;
  line-height: 2rem;
}

li a, #userName {
  font-weight: bold;
  font-size: 1.3rem;
  color: rgba(255,215,0,80%);
  text-shadow: 2px 2px black;
}

li.left-nav {
  flex: 2;
}

li:not(.left-nav) {
  margin-left: 1.5rem;
}

#userName {
  align-content: center;
}

#userName:hover {
  cursor: pointer;
}

#userOptions, #userOptions * {
  margin: 0px;
  padding: 0px;
}

#userOptions {
  display: none;
  width: 97px;
  margin: auto;
  margin-top: 3px;
  position: absolute;
  background-color: #800020;
  border-bottom: 1px solid #800020;
  border-radius: 5px;
  box-shadow: inset -1px 2px 38px 22px rgba(0,0,0,0.3);
}

#userOptions li {
  border-top: 1px solid #000
}

#userOption-manage,
#userOption-logout {
  margin-left: 10px;
  padding: 2%;
}

</style>
