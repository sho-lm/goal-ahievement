<template lang="pug">
  #users
    p {{ user.id }}
    p {{ user.name }}
</template>
<script lang="ts">
import Vue from 'vue'
import axios from 'axios';


export default Vue.extend({
  data () {
    return {
      user: {}
    }
  },
  mounted () {
    axios
      .get('http://localhost:3000/api/v1/users/1')
      .then(res => {
        console.log(res);
        this.user = res.data;
      })
    
  }
})
</script>

<style lang="scss" scoped>
  #users {
    color: red;
  }
</style>