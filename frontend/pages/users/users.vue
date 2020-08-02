<template lang="pug">
  #users
    .user-info
      p(v-if="this.user.id !== 0") userid: {{ user.id }}
      label(for="accountId") accountId
      input#accountId(v-model="user.accountId")
      label(for="userName") userName
      input#userName(v-model="user.name")
      label(for="userPassword") userPassword
      input#userPassword(v-model="user.password")
    
    div(v-if="this.user.id === 0")
      p user not found
      button(@click="postCreate") create
    div(v-else)
      button(@click="patchUpdate") update
      p
      button(@click="deleteDestroy") delete
</template>
<script lang="ts">
import Vue from 'vue'
import axios from 'axios';
import { api } from '../../config/api';
import { User } from '../../models/user';

const sessionKey = 'userId';

export type DataType = {
  user: User
}


export default Vue.extend({
  data(): DataType {
    return {
      user: new User(),
    }
  },
  mounted() {
    const userId = Number(sessionStorage.getItem(sessionKey));
    axios.get(api.usersPath(userId))
      .then(response => {
        this.user.setResponse(response.data);
      })
      .catch(error => {
        console.log(error);
      })
  },
  methods: {
    postCreate() {
      axios.post(api.userPath, this.user)
        .then(response => {
          this.user.setResponse(response.data);
          console.log('created');
          sessionStorage.setItem(sessionKey, this.user.id.toString());
        })
        .catch(error => {
          console.log(error);
        })
    },
    patchUpdate() {
      axios.patch(api.usersPath(this.user.id), this.user)
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
          this.user.initialize();
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