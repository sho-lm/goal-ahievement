<template lang="pug">
  #login
    section
      h5(v-if="loginSuccess") login success
      h5(v-else) plese login

      p account_id
      input(type="text", name="accountId", v-model="accountId")
      p password
      input(type="password", name="password", v-model="password")
      p
      button(@click="login") login
      p
      button(@click="logout") logout
    section.user-index
      div.user-info(v-for="user in users")
        p id: {{ user.id }}
        p accountId {{ user.account_id }}
        p name {{ user.name }}
</template>

<script lang="ts">
import Vue from 'vue'
import axios from 'axios';
import { api } from '../../config/api'

const sessionKey = 'userId';

export default Vue.extend({
  data () {
    return {
      accountId: '',
      password: 'aaaaaa',
      loginSuccess: false,
      users: {}
    }
  },
  mounted () {
    this.loginSuccess = false;
    axios.get(api.userPath)
      .then(response => {
        this.users = response.data;
      })
      .catch(error => {
        console.log(error);
        
      })
  },
  methods: {
    login() {
      const params = {
        session: {
          account_id: this.accountId,
          password: this.password
        }
      }
      axios.post(api.loginPath, params)
        .then(response => {
          sessionStorage.setItem(sessionKey, response.data.id);
          this.loginSuccess = true;
          console.log('log in');
        })
        .catch(error => {
          console.log(error);
        })
    },
    logout() {
      axios.delete(api.logoutPath)
        .then(response => {
          sessionStorage.removeItem(sessionKey);
          this.loginSuccess = false;
          console.log('log out');
        })
        .catch(error => {
          console.log(error);
        })
    }
  }
})
</script>

<style lang="scss" scoped>
  .user-info {
    border-bottom: 1px solid #0328fa;
    margin-bottom: 10px;
  }
</style>