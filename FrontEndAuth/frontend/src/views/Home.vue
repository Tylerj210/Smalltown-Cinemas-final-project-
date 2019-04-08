<!-- 
  The Home Page should display a feed of all posts from most recent.
  NOTES:
  - Upon creation, it calls api/posts and sorts the response.
  DEPENDENCIES: 
    
-->
<template>
  <div id="home" class="container">
    
  </div>
</template>

<script>
import auth from "@/shared/auth.js";

export default {
  name: "home",
  components: {
    
  },
  data() {
    return {
      
    };
  },
  methods: {
    
  },
  
  created() {
   
  }
};
</script>

<style scoped>
#home {
  margin-top: 0.5rem;
}

.post {
  border-bottom: 1px solid #eee;
  margin-bottom: 0.5rem;
}
</style>
