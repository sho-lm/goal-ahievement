<template lang="pug">
  el-container#app
    el-header
      el-menu(
              mode="horizontal"
      )
        el-menu-item(index="login", route="{ name: 'login' }")
          router-link(to="/login") login
        el-menu-item(index="goals", route="{ name: 'goals' }")
          router-link(to="/goals") goals
        el-menu-item(index="workRecords", route="{ name: 'workRecords' }")
          router-link(to="/workRecords") workRecords
        el-menu-item(index="usersList", route="{ name: 'usersList' }")
          router-link(to="/usersList") usersList
    el-container
      el-aside
        users
      el-main
        router-view
</template>

<script lang="ts">
import Vue from 'vue';
import Users from '~/pages/users/Users.vue';

export default Vue.extend({
  components: {
    Users
  }
})
</script>

<style lang="scss">
  .router-link-active {
    color: rgb(187, 34, 34) !important;
  }
</style>
