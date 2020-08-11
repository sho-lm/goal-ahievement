<template lang="pug">
  v-container.login-page
    v-row(justify="center")
      v-card.my-5(
        width="90%"
        max-width="368"
        color="transparent"
      )
        v-form.login-form.pa-5(
          v-model="valid"
          ref="form"
        )
          label Name
          name-form(:name.sync="name")
          label Password
          password-form(:password.sync="password")
          v-card-text(
            align="center"
            full-width
          )
            v-btn(
              color="success"
              width="80%"
              max-width="200"
              :disabled="loading"
              @click="login"
            ) ログイン
</template>

<script lang="ts">
import Vue from 'vue';
import axios from 'axios';
import { api } from '@/config/api';
import NameForm from '@/components/users/NameForm.vue';
import PasswordForm from '@/components/users/PasswordForm.vue';
import { VForm } from '@/plugins/vuetify';


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
  computed: {
    getForm(): VForm {
      return (this.$refs as any).form;
    }
  },
  methods: {
    login(): void {
      if (!this.getForm.validate()) return;
      
      const params = {
        name: this.name,
        password:   this.password
      }
      this.loading = true;
      this.$store.dispatch('login', params);
      this.loading = false;
    },
    logout(): void {
      this.name = '';
      this.password = '';
      this.$store.dispatch('logout');
    },
  }
})
</script>

<style lang="scss" scoped>
  .login-form {
    background: #fff;
  }
</style>