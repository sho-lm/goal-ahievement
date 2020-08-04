<template lang="pug">
  #userList
    div.user-info(v-for="user in userList")
      p id: {{ user.id }}
      p account: {{ user.account_id }}
</template>

<script lang="ts">
import Vue from 'vue'
import axios from 'axios';
import { api } from '../../config/api'
import { User } from '../../models/user'

const sessionKey = 'userId';

export type DataType = {
  userList: Array<User>
}

export default Vue.extend({
  data(): DataType  {
    return {
      userList:    []
    }
  },
  mounted():void {
    axios.get(api.usersPath)
      .then(response => {
        this.userList = User.createIndexDataBy(response.data);
      })
      .catch(error => {
        console.log(error);
      })
  }  
})
</script>

<style lang="scss" scoped>
  .user-info {
    border-bottom: 1px solid rgba(15, 60, 206, 0.541);
    margin-bottom: 5px;
  }
</style>