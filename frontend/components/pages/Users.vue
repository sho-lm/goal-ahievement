<template lang="pug">
  #users
    h1 Users Page
    section(v-if="$store.getters.isLoggedIn")
      div.edit-mode(v-if="isEditMode")
        p edit mode
        p(v-if="this.user.id !== 0") userid: {{ userCopy.id }}
        label(for="name") name
        input#name(v-model="userCopy.name")
        label(for="userPassword") userPassword
        input#userPassword(v-model="userCopy.password")
        button(@click="patchUpdate") update
        button(@click="deleteDestroy") delete
        button(@click="cancelUpdate") cancel
      div.normal-mode(v-else)
        p normal mode
        button(@click="editMode") edit mode
    section(v-else)
      p please log in
</template>
<script lang="ts">
import Vue from 'vue'
import axios from 'axios';
import { api } from '@/config/api';
import { User } from '@/models/user';

const deepCopy = (data: any) => JSON.parse(JSON.stringify(data));

export type DataType = {
  user:       User
  userCopy:   User
  isEditMode: boolean
}

export default Vue.extend({
  data(): DataType {
    return {
      user:       this.$store.getters.user,
      userCopy:   new User(),
      isEditMode: false,
    }
  },
  methods: {
    editMode(): void {
      this.isEditMode = true;
      this.userCopy = deepCopy(this.user);
    },
    cancelUpdate(): void {
      this.isEditMode = false;
    },
    patchUpdate() {
      axios.patch(api.userPath(this.$store.getters.userId), { user: this.userCopy })
        .then(response => {
          console.log('update');
          this.$store.commit('setUser', response.data);
          this.isEditMode = false;
        })
        .catch(error => {
          console.log(error);
        })
    },
    deleteDestroy() {
      axios.delete(api.userPath(this.$store.getters.userId))
        .then(response => {
          console.log('deleted');
          this.$store.dispatch('discardSession');
          this.isEditMode = false;
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
  .edit-mode {
    display: grid;
    gap: 10px;
    margin-bottom: 20px;
  }
</style>