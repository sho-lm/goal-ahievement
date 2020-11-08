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
          name-form(
            :name.sync="name"
            :duplicateNameList="duplicateNameList"
          )
          password-form(
            :password.sync="password"
          )
          v-card-text(
            align="center"
          )
            v-btn(
              :disabled="loading"
              color="primary"
              @click="signUp"
              width="150"
            ) 登録する

</template>

<script lang="ts">
import Vue from 'vue';
import { customAxios } from '@/plugins/customAxios';
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
  duplicateNameList: Array<String>
}

export default Vue.extend({
  data(): DataType  {
    return {
      valid:             true,
      name:              '',
      password:          '',
      loading:           false,
      duplicateNameList: []
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
    signUp(): void {
      if (!this.getForm.validate()) return;

      this.loading = true;
      const params = {
        name: this.name,
        password:   this.password
      }
      customAxios.post(api.usersPath, { user: params })
        .then(response => {
          this.$store.dispatch('saveSession', response.data);
          this.$router.push({ name: 'users' });
          this.$store.dispatch('showMessage', '登録しました');
        })
        .catch(error => {
          console.log(error.response);
          if (error.response.data.error === 'duplicate_name') {
            this.duplicateNameList.push(this.name);
            this.getForm.validate();
          }
        })
        .finally(() => { 
          this.loading = false;
        })
    },
  }
})
</script>
