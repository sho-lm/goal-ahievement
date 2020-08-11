<template lang="pug">
  v-app#inspire
    v-app-bar(
      app
      clipped-left
      dark
    )
      v-app-bar-nav-icon(@click.stop="drawer = !drawer")
      v-toolbar-title(v-if="$store.getters.isLoggedIn") {{ $store.getters.user.name}}

    v-navigation-drawer(
      v-model="drawer"
      app
      clipped
    )
      v-list(dense)
        v-list-item(v-for="route in routes" :key="route.name" :to="route.path")
          v-list-item-icon
            v-icon {{ route.meta.icon }}
          v-list-item-content
            v-list-item-title {{ route.name }}

    v-main(v-bind:style="{ background: activeBackGround }")
      v-container(fluid)
        router-view
</template>

<script lang="ts">
import Vue from 'vue';
import { RouteConfig } from 'vue-router';
import { routes } from '@/router/router';

export type DataType = {
  drawer: boolean | null,
  routes: Array<RouteConfig>
  color: string
}

export default Vue.extend({
  data(): DataType {
    return {
      drawer: null,
      routes,
      color: 'red'
    }
  },
  computed: {
    activeBackGround() {
      return this.$route.meta.background;
    }
  },
})
</script>
