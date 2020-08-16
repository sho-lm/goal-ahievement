<template lang="pug">
  v-container.users-page
    v-row(justify="center")
      v-card(
        flat
        width="90%"
        max-width="500"
      )
        v-card-title.justify-center プロフィール
        v-form(
          v-model="valid"
          ref="form"
        )
          label Name
          name-form(
            :name.sync="getUser.name"
            :readonly="readonly"
          )
          template(v-if="!readonly")
            label Password
            password-form(
              :password.sync="getUser.password"
              :updateMode="true"
            )
          v-card-text(
            align="center"
          )
            template(v-if="readonly")
              v-btn(
                @click="editMode"
                width="100%"
              ) 編集する
            template(v-else)
              v-btn.mb-5(
                @click="patchUpdate"
                :disabled="loading"
                color="primary"
                width="100%"
              ) 更新する
              v-btn.my-5(
                @click="cancelEdit"
                width="100%"
              ) キャンセル
              v-btn.mt-5(
                @click="deleteDestroy"
                color="red"
                width="100%"
              ) 削除
</template>

<script lang="ts">
import Vue from 'vue'
import axios from 'axios';
import { api } from '@/config/api';
import { User } from '@/models/user';
import NameForm from '@/components/users/NameForm.vue';
import PasswordForm from '@/components/users/PasswordForm.vue';
import { VForm } from '@/plugins/vuetify';

const deepCopy = (data: any) => JSON.parse(JSON.stringify(data));

export type DataType = {
  loading:  boolean
  readonly: boolean
  user:     User
  userCopy: User
  valid:    boolean
}

export default Vue.extend({
  data(): DataType {
    return {
      loading:  false,
      readonly: true,
      user:     this.$store.getters.user,
      userCopy: new User(),
      valid:    true,
    }
  },
  components: {
    NameForm,
    PasswordForm
  },
  computed: {
    getForm(): VForm {
      return (this.$refs as any).form;
    },
    getUser(): User {
      return this.readonly ? this.user : this.userCopy; // user は vuex から貰っているので、編集時はコピーを操作する
    }
  },
  methods: {
    editMode(): void {
      this.userCopy = deepCopy(this.user);
      this.readonly = false;
    },
    cancelEdit(): void {
      this.getForm.resetValidation();
      this.readonly = true;
    },
    patchUpdate() {
      if (!this.getForm.validate()) return;

      const params = {
        name:     this.userCopy.name,
        password: this.userCopy.password
      }
      axios.patch(api.userPath(this.$store.getters.userId), { user: params })
        .then(response => {
          console.log('update');
          this.$store.commit('setUser', response.data);
          this.readonly = true;
        })
        .catch(error => {
          console.log(error);
        })
    },
    deleteDestroy() {
      if (!confirm('削除してよろしいですか?')) return;

      axios.delete(api.userPath(this.$store.getters.userId))
        .then(response => {
          console.log('deleted');
          this.$store.dispatch('discardSession');
          this.$router.push({ name: 'login' });
        })
        .catch(error => {
          console.log(error);
        })
    }
  }
})
</script>
