<template lang="pug">
  .login-page
    v-row(justify="center")
      v-card.my-5(
        width="360"
        color="transparent"
      )
        v-form.login-form.pa-5(
          v-model="valid"
          ref="form"
        )
          name-form(:name.sync="name")
          password-form(:password.sync="password")
          v-card-text(
            align="center"
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
import { customAxios } from '@/plugins/customAxios';
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
      
      this.loading = true;
      const params = {
        name: this.name,
        password:   this.password
      }
      
      customAxios.post(api.loginPath, params)
        .then(response => {
          this.$store.dispatch('saveSession', response.data);

          // nullチェックはしているが型エラーになるためany型で宣言
          const redirectTo: any = this.$route.query.redirect ? this.$route.query.redirect : 'users';
          this.$router.push({ name: redirectTo });

          this.$store.dispatch('selectGoalList');
          this.$store.dispatch('showMessage', 'ログインしました');
        })
        .catch(error => {
          console.log(error.response);
          if (error.response.status === 400) {
            this.$store.dispatch('showAlertMessage', '名前かパスワードが間違っています');
            } else {
              this.$store.dispatch('showAlertMessage', 'ログインに失敗しました');
          }
        })

      this.loading = false;
    },
  }
})
</script>

<style lang="scss" scoped>
  .login-form {
    background: #fff;
    width: 360px;
  }
</style>
