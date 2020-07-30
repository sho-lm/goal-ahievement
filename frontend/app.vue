<template lang="pug">
  #app
    header
      el-menu(
              mode="horizontal"
      )
        el-menu-item(index="home", route="{ name: 'home' }")
          router-link(to="/home") home
        el-menu-item(index="users", route="{ name: 'users' }")
          router-link(to="/users") users
        el-menu-item(index="goals", route="{ name: 'goals' }")
          router-link(to="/goals") goals
        el-menu-item(index="workRecords", route="{ name: 'workRecords' }")
          router-link(to="/workRecords") workRecords
    main
      RouterView
</template>

<script lang="ts">
import Vue from 'vue';

export default Vue.extend({
  data () {
    return {
    }
  },
})
</script>

<style lang="scss" scoped>
</style>
