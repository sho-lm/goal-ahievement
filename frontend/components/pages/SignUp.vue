<template lang="pug">
  v-container
    v-row(justify="center")
      v-card(
        flat
        width="90%"
        max-width="368"
        color="transparent"
      )
        v-card-title 新規登録
        v-form(
          v-model="valid"
          ref="form"
        )
          name-form(:name.sync="name")
          password-form(:password.sync="password")
          v-card-text
            v-btn.mr-4(
              :disabled="!valid || loading"
              :loading="loading"
              color="primary"
              @click="signUp"
            ) 登録する

</template>

<script lang="ts">
import Vue from 'vue';
import axios from 'axios';
import { api } from '@/config/api';
import NameForm from '@/components/users/NameForm.vue';
import PasswordForm from '@/components/users/PasswordForm.vue';

const sessionKey = 'userId';

export type DataType = {
  valid:    boolean
  name:     string
  password: string
  loading:  boolean
}

export default Vue.extend({
  data(): DataType  {
    return {
      valid:    true,
      name:     '',
      password: '',
      loading:  false,
    }
  },
  components: {
    NameForm,
    PasswordForm
  },
  methods: {
    logout(): void {
      this.name = '';
      this.password = '';
      this.$store.dispatch('logout');
    },
    signUp(): void {
      const params = {
        name: this.name,
        password:   this.password
      }
      axios.post(api.usersPath, { user: params })
        .then(response => {
          console.log('created');
          this.$store.dispatch('saveSession', response.data);
          this.$router.push('/users');
        })
        .catch(error => {
          console.log(error);
        })
    },
  }
})
</script>

<style lang="scss">
</style>