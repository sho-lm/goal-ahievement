<template lang="pug">
  #login
    h1 Login Page
    p
    button(@click="changeMode") change mode
    section(v-if="$store.getters.isLoggedIn")
      button(@click="logout") logout
    section(v-else)
      p name
      input(type="text", v-model="name")
      p password
      input(type="password", v-model="password")
      div(v-if="isLoginMode")
        button(@click="login") login
      div(v-else)
        button(@click="postCreate") create
      div(v-else)

</template>

<script lang="ts">
import Vue from 'vue'
import axios from 'axios';
import { api } from '~/config/api'
import { User } from '~/models/user'

const sessionKey = 'userId';

export type DataType = {
  name:        string
  password:    string
  isLoginMode: boolean
}

export default Vue.extend({
  data(): DataType  {
    return {
      name:        '',
      password:    '',
      isLoginMode: true
    }
  },
  methods: {
    login(): void {
      const params = {
        name: this.name,
        password:   this.password
      }
      this.$store.dispatch('login', params);
    },
    logout(): void {
      this.name = '';
      this.password = '';
      this.$store.dispatch('logout');
    },
    postCreate(): void {
      const params = {
        name: this.name,
        password:   this.password
      }
      axios.post(api.usersPath, { user: params })
        .then(response => {
          console.log('created');
          this.$store.dispatch('saveSession', response.data);
        })
        .catch(error => {
          console.log(error);
        })
    },
    changeMode(): void {
      this.isLoginMode = !this.isLoginMode;
    }
  }
})
</script>

<style lang="scss" scoped>
</style>