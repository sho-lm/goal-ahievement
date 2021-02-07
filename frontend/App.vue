<template lang="pug">
  v-app
    v-snackbar.snackbar(
      v-model="snackbarDisplay"
      top
      app
      absolute
      timeout=2000
      :color="snackbarColor"
    ) {{ $store.getters.snackbarMessage }}
    v-app-bar.my-app-bar(
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
    v-navigation-drawer.my-side-bar(
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
import { customAxios } from '@/plugins/customAxios';
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
    },
    snackbarColor(): string {
      return this.$store.getters.snackbarColor;
    }
  },
  methods: {
    logout(): void {
      customAxios.delete(api.logoutPath)
        .then(response => {
          this.$store.dispatch('discardSession');
          this.$router.push({ name: 'login' });

          this.$store.dispatch('showMessage', 'ログアウトしました');
        })
        .catch(error => {
          console.log(error.response);
        })
    },
  }
})
</script>

<style lang="scss" scoped>
  .my-app-bar {
    z-index: 30 !important; // 勉強記録画面の select 要素の z-index との調整のため
  }

  .my-side-bar {
    z-index: 40 !important; // 勉強記録画面の select 要素の z-index との調整のため
  }

  .snackbar {
    z-index: 1000;
    margin: 2px;
    height: 99%; // vuetifyが自動でつける [height: 100%] のせいで縦スクロールがでるのを防ぐ

    /deep/ .v-snack__wrapper  {
      margin: 4px;
    }
  }

  .page-component {
    /deep/ .page-header {
      background: #fff;
      position: sticky;
      top: 60px;
      z-index: 10;
    }
  }
</style>
