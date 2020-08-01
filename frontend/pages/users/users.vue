<template lang="pug">
  #users
    .user-info
      p userid: {{ user.id }}
      label(for="accountId") accountId
      input#accountId(v-model="user.account_id")
      label(for="userName") userName
      input#userName(v-model="user.name")
      label(for="userPassword") userPassword
      input#userPassword(v-model="user.password")
    div(v-if="isExist")
      button(@click="patchUpdate") update
      p
      button(@click="deleteDestroy") delete
    div(v-else)
      p user not found
      button(@click="postCreate") create
</template>
<script lang="ts">
import Vue from 'vue'
import axios from 'axios';
import { api } from '../../config/api'

const sessionKey = 'userId';


export default Vue.extend({
  data () {
    return {
      user: {},
      isExist: false,
    }
  },
  mounted () {
    this.loading = true;
    const userId = sessionStorage.getItem(sessionKey);
    
    axios.get(api.usersPath(userId))
      .then(response => {
        this.user = response.data;
        this.isExist = true;
      })
      .catch(error => {
        console.log(error);
        this.isExist = false;
      })
  },
  methods: {
    postCreate() {
      const params = {
        user: {
          account_id: this.user.account_id,
          name: this.user.name,
          password: this.user.password
        }
      };
      axios.post(api.userPath, params)
        .then(response => {
          this.user = response.data;
          this.isExist = true;
          console.log('created');
          sessionStorage.setItem(sessionKey, this.user.id);
        })
        .catch(error => {
          console.log(error);
        })
    },
    patchUpdate() {
      const params = {
        user: {
          account_id: this.user.account_id,
          name: this.user.name
        }
      };
      axios.patch(api.usersPath(this.user.id), params)
        .then(response => {
          console.log('update');
        })
        .catch(error => {
          console.log(error);
          
        })
    },
    deleteDestroy() {
      axios.delete(api.usersPath(this.user.id))
        .then(response => {
          console.log('deleted');
          sessionStorage.removeItem(sessionKey);
          this.user = {};
        })
        .catch(error => {
          console.log(error);
        })
    }
  }
})
</script>

<style lang="scss" scoped>
  .error {
    color: #f00;
  }
  .user-info {
    display: grid;
    gap: 10px;
    margin-bottom: 20px;
  }
</style>