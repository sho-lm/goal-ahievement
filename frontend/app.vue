<template lang="pug">
  #app
    header
      el-menu(
              mode="horizontal"
      )
        el-menu-item(index="login", route="{ name: 'login' }")
          router-link(to="/login") login
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

import { mapMutations } from 'vuex';

export default Vue.extend({
})
</script>

<style lang="scss" scoped>
</style>
