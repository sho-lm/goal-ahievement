<template>
  <div class="example">
    <p>hello</p>
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
