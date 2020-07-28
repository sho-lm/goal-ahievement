<template>
  <div id="app">
    <div>
      <p>hello</p>
    </div>
    <p>hello2</p>
    <users></users>
    <goals></goals>
  </div>
</template>

<script lang="ts">
import Vue from 'vue'
import Users from './pages/users/users.vue'
import Goals from './pages/goals/goals.vue'

export default Vue.extend({
  components: {
    Users,
    Goals
  }
})
</script>

<style lang="scss" scoped>
  #app {
    div {
      p {
        color: red;
      }
    }
    p {
      color: blue;
    }
  }
</style>