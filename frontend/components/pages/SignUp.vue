<template lang="pug">
  v-container
    v-row(justify="center")
      v-card(
        flat
        width="90%"
        max-width="500"
      )
        v-card-title.justify-center 新規登録
        v-form(
          v-model="valid"
          ref="form"
        )
          label Name
          name-form(:name.sync="name")
          label Password
          password-form(:password.sync="password")
          v-card-text(
            align="center"
          )
            v-btn(
              :disabled="loading"
              color="primary"
              @click="signUp"
              width="100%"
            ) 登録する

</template>

<script lang="ts">
import Vue from 'vue';
import axios from 'axios';
import { api } from '@/config/api';
import NameForm from '@/components/users/NameForm.vue';
import PasswordForm from '@/components/users/PasswordForm.vue';
import { VForm } from '@/plugins/vuetify';

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
  computed: {
    getForm(): VForm {
      return (this.$refs as any).form;
    }
  },
  methods: {
    logout(): void {
      this.name = '';
      this.password = '';
      this.$store.dispatch('logout');
    },
    signUp(): void {
      if (!this.getForm.validate()) return;

      this.loading = true;
      const params = {
        name: this.name,
        password:   this.password
      }
      axios.post(api.usersPath, { user: params })
        .then(response => {
          console.log('created');
          this.$store.dispatch('saveSession', response.data);
          this.$router.push({ name: 'users' });
        })
        .catch(error => {
          console.log(error);
        })
      this.loading = false;
    },
  }
})
</script>
