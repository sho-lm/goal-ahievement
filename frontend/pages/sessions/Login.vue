<template lang="pug">
  #login
    h1 Login Page
    section(v-if="$store.getters.isLoggedIn")
      button(@click="logout") logout
    section(v-else)
      p accountId
      input(type="text", name="accountId", v-model="accountId")
      p password
      input(type="password", name="password", v-model="password")
      p
      button(@click="login") login
</template>

<script lang="ts">
import Vue from 'vue'
import axios from 'axios';
import { api } from '../../config/api'
import { User } from '../../models/user'

const sessionKey = 'userId';

export type DataType = {
  accountId:      string
  password:       string
}

export default Vue.extend({
  data(): DataType  {
    return {
      accountId:    '',
      password:     '',
    }
  },
  methods: {
    login() {
      const params = {
        account_id: this.accountId,
        password:   this.password
      }
      this.$store.dispatch('login', params);
    },
    logout() {
      this.accountId = '';
      this.password = '';
      this.$store.dispatch('logout');
    }
  }
})
</script>

<style lang="scss" scoped>
</style>