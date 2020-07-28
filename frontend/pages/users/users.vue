<template>
  <div class="users">
    hello from users
    <users-index></users-index>
  </div>
</template>

<script lang="ts">
import Vue from 'vue'
import UsersIndex from './usersIndex'
export default Vue.extend({
  components: {
    UsersIndex
  }
})
</script>

<style lang="scss" scoped>
  .users {
    background: yellow;
  }
</style>