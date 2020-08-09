<template lang="pug">
  #app
    .header
      router-link(to="/login") login
      router-link(to="/users") users
      router-link(to="/goals") goals
      router-link(to="/work_records") workRecords
      router-link(to="/debug") debug (usersList)
    .main
      router-view
</template>

<script lang="ts">
import Vue from 'vue';
import Users from '~/components/UsersPage.vue';

export default Vue.extend({
  components: {
    Users
  }
})
</script>

<style lang="scss">
  .header {
    display: grid;
    grid-auto-flow: column;
    padding-bottom: 10px;
    border-bottom: 1px solid rgb(149, 221, 158);
  }
  .router-link-active {
    color: rgb(230, 76, 76);
    font-weight: bold;
  }
</style>
