<template lang="pug">
  v-app
    v-snackbar.snackbar(
      v-model="snackbarDisplay"
      top
      app
      absolute
      timeout=1000
      color="grey darken-3"
    ) {{ $store.getters.snackbarMessage }}
    v-app-bar(
      app
      clipped-left
      dark
      height="60"
    )
      template(v-if="$store.getters.isLoggedIn")
        v-app-bar-nav-icon(@click.stop="drawer = !drawer")
        v-spacer
        v-btn(@click.stop="logout") ログアウト
      template(v-else)
        v-spacer
        router-link(to="login") ログイン
        router-link.ml-5(to="sign_up") 新規登録
    v-navigation-drawer(
      v-if="$store.getters.isLoggedIn"
      v-model="drawer"
      app
      clipped
    )
      v-list(dense)
        v-list-item(v-for="route in routesOnLogin" :key="route.name" :to="route.path")
          v-list-item-icon
            v-icon {{ route.meta.icon }}
          v-list-item-content
            v-list-item-title {{ route.meta.text }}

    v-main(v-bind:style="{ background: activeBackGround }")
      v-container.page-component.pa-0
        router-view
</template>

<script lang="ts">
import Vue from 'vue';
import { RouteConfig } from 'vue-router';
import { routes } from '@/router/router';
import axios from 'axios';
import { api } from '@/config/api';


export type DataType = {
  drawer: boolean | null,
  routes: Array<RouteConfig>
}

export default Vue.extend({
  data(): DataType {
    return {
      drawer: null,
      routes,
    }
  },
  computed: {
    activeBackGround(): string {
      return this.$route.meta.background || '#fff';
    },
    routesOnLogin(): Array<RouteConfig> {
      return this.routes.filter(route => route.meta.requiresLogin);
    },
    snackbarDisplay: {
      get(): boolean { return this.$store.getters.snackbarDisplay; },
      set(): void { this.$store.dispatch('hideMessage'); }
    }
  },
  methods: {
    logout(): void {
      axios.delete(api.logoutPath)
        .then(response => {
          this.$store.dispatch('discardSession');
          this.$router.push({ name: 'login' });

          this.$store.dispatch('showMessage', 'ログアウトしました');
        })
        .catch(error => {
          console.log(error);
        })
    },
  }
})
</script>

<style lang="scss" scoped>
  .snackbar {
    z-index: 1000;
    margin: 2px;

    /deep/ .v-snack__wrapper  {
      margin: 4px;
    }
  }

  .page-component {
    /deep/ .page-header {
      background: #fff;
      position: sticky;
      top: 60px;
      z-index: 4;
    }
  }
</style>