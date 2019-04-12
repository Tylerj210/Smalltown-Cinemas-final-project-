<!-- 
  The Login Page displays a register and login screen for the user to authenticate.
  NOTES:
    - This page displays one UI or the other (register or login)
    - The page uses the async/await syntax over fetch().then().then()
      This is an alternative syntax and done here because we need to make a course of action
      depending on the response.statuscode that comes back. With the other approach, it goes
      out of scope after the first .then()
    - Errors that result from registering (user name taken) or logging in (invalid creds)
      will be displayed to the user using the Error component.
  DEPENDENCIES:
    - Error 
-->

<template>
  <div id="login">
    <!-- <section id="content">
      <h1>TEGram</h1>
      <p>
        Create an account or log in to TEGram &mdash; A simple, fun &amp; creative way to capture,
        edit &amp; share photos, videos &amp; messages with friends &amp; family.
      </p>
    </section> -->
    <section id="login-signup" v-bind:class="{ showSignupForm: !showLoginForm }">
      <form v-if="showLoginForm" v-on:submit.prevent="login">
        <h1>Welcome Back!</h1>

        <error-message v-bind:error="error"></error-message>

        <label for="email">Username</label>
        <input
          v-model.trim="loginForm.username"
          type="text"
          placeholder="Captain America"
          id="email"
        />

        <label for="password">Password</label>
        <input
          v-model.trim="loginForm.password"
          type="password"
          placeholder="shamballa"
          id="password"
        />

        <div class="form-actions">
          <button class="login">Log In</button>
          <div class="extras">
            <a v-on:click="toggleForm">Create an Account</a>
          </div>
        </div>
      </form>

      <form v-else v-on:submit.prevent="signup">
        <h1>Get Started</h1>

        <error-message :error="error"></error-message>

        <label for="email2">Username</label>
        <input
          v-model.trim="signupForm.username"
          type="text"
          placeholder="Captain America"
          id="email2"
        />

        <label for="password2">Password</label>
        <input
          v-model.trim="signupForm.password"
          type="password"
          placeholder="min 6 characters"
          id="password2"
        />

        <label for="password3">Confirm Password</label>
        <input
          v-model.trim="signupForm.confirmPassword"
          type="password"
          placeholder="confirm password"
          id="password3"
        />

        <div class="form-actions">
          <button>Sign Up</button>
          <div class="extras">
            <a v-on:click="toggleForm">Back to Login</a>
          </div>
        </div>
      </form>
    </section>
  </div>
</template>

<script>
import auth from "@/shared/auth";
import ErrorMessage from "@/components/ui/ErrorMessage.vue";

export default {
  components: { ErrorMessage },
  data() {
    return {
      showLoginForm: true,
      error: "",
      /** Contents of the login form */
      loginForm: {
        username: "",
        password: ""
      },
      /** Contents of the sign up form */
      signupForm: {
        password: "",
        username: "",
        role: "user"
      }
    };
  },
  methods: {
    /**
     * Toggles the showLoginform
     * @function
     */
    toggleForm() {
      this.showLoginForm = !this.showLoginForm;
      this.error = "";
    },
    /**
     * Navigates the user to the home route.
     * @function
     */
    goHome() {
      this.$router.push("/");
    },
    /**
     * Logs the user in and then sends them to the dashboard.
     * NOTE: Uses async/await
     */
    async login() {
      this.error = "";

      /**
       * This example uses async/await over Promise .then()
       * Under the hood it still relies on promises but the syntax of
       * await Promise makes it a bit shorter and easier to read.
       * It also helps with one issue which is the need to conditionally
       * run logic based on the response.statusCode.
       */
      try {
        const url = `${process.env.VUE_APP_REMOTE_API}/login`;
        const response = await fetch(url, {
          method: "POST",
          headers: {
            Accept: "application/json",
            "Content-Type": "application/json"
          },
          body: JSON.stringify(this.loginForm)
        });

        if (response.status === 401) {
          this.error = "Your username and/or password is invalid";
          this.loginForm.password = "";
        } else {
          // Parse output and save authentication token
          const token = await response.json();
          auth.saveToken(token);
          this.goHome();
          location.reload();
        }
      } catch (error) {
        console.error(error);
        this.error = "There was an error logging in";
      }
    },
    /**
     * Signs the user up and then redirects them to the dashboard.
     */
    async signup() {
      this.error = "";

      try {
        const url = `${process.env.VUE_APP_REMOTE_API}/register`;
        const response = await fetch(url, {
          method: "POST",
          headers: {
            Accept: "application/json",
            "Content-Type": "application/json"
          },
          body: JSON.stringify(this.signupForm)
        });

        // We definitely need the response if success or not.
        const data = await response.json();

        if (response.status === 400) {
          this.error = data.message;
        } else {
          auth.saveToken(data);
          this.goHome();
          location.reload();
        }
      } catch (error) {
        console.error(error);
        this.error = "There was an error attempting to register";
      }
    }
  }
};
</script>

<style scoped>
#login {
  display: flex;
  height: 100vh;
  flex-direction: column;
  
}

#content {
  display: initial;
  background-color: #00adee;
  color: #fff;
}

#content,
#login-signup {
  padding: 5vh 1rem 1rem 1rem;
  
}

#content h1,
#login-signup h1 {
  margin-bottom: 2rem;
}

form h1 {
  margin-left: 0;
  color:gold;
  text-shadow: 2px 2px black;
  font-family: 'Fascinate Inline', cursive;
}

form label {
  font-size: 1rem;
  margin-bottom: 0.5rem;
  color:gold;
  text-shadow: 2px 2px black;
}

form input {
  width: 100%;
  margin-bottom: 1rem;

  padding: 10px;
  border: 1px solid #e6ecf0;
  border-radius: 3px;
}

form label,
form input {
  display: block;
}

form button {
  font-size: 15px;
  padding: 0.8rem 0.2rem;
  background: #80002000;
  color: gold;
  text-shadow: 2px 2px black;
  border-radius: 3px;
  font-weight: bold;
  border: none;
}
form {
  border: 3px solid #800020;
  border-radius: 12px;
  /* box-shadow: 5px 10px 20px 4px rgba(255,215,0,80%); */
  /* background:black; */
  background:#800020;
  box-shadow: inset -1px 2px 38px 22px rgba(0,0,0,0.3);
  padding: 5%;
  border-radius:8px;
  font-weight: bold;
}
.form-actions {
  display: flex;
  border: none;
}

.form-actions .extras {
  flex: 2;
  border: none;
}

.form-actions .extras {
  text-align: right;
  align-self: center;
  
}
.form-actions .extras a{
  font-weight: bold;
  text-shadow: 2px 2px black;
  color:gold;
}

@media screen and (min-width: 768px) {
  #login-signup {
    padding-top: 10vh;
  }

  #content > *,
  #login-signup form {
    max-width: 80%;
    margin: 0 auto;
  }
}

@media screen and (min-width: 1024px) {
  #content h1,
  #login-signup h1 {
    margin-bottom: 2rem;
  }

  #login {
    flex-direction: row;
    border: none;
  }

  #content,
  #login-signup {
    flex: 1;
    padding: 25vh 1rem 1rem 1rem;
  }

  #login-signup.showSignupForm {
    padding-top: 15vh;
  }
}
</style>
