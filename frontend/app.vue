<template lang="pug">
  v-app
    v-navigation-drawer(app)
    v-app-bar(app)
    v-main
      v-container(fluid)
        router-view
    v-footer(app)
</template>

<script lang="ts">
import Vue from 'vue';
import Users from '@/components/UsersPage.vue';

export default Vue.extend({

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
