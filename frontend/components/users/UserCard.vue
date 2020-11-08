<template lang="pug">
  v-card.pa-1(
    flat
  )
    v-form(
      v-model="valid"
      ref="form"
    )
      name-form(
        :name.sync="user.name"
        :duplicateNameList="duplicateNameList"
      )
      password-form(
        :password.sync="user.password"
        :updateMode="true"
      )
      .button-area
        v-btn.update-button(
          @click="updateUser"
          :disabled="loading"
          small
          color="primary"
        ) 更新
</template>

<script lang="ts">
import Vue from 'vue';
import { customAxios } from '@/plugins/customAxios';
import { api } from '@/config/api';
import { User } from '@/models/user';
import NameForm from '@/components/users/NameForm.vue';
import PasswordForm from '@/components/users/PasswordForm.vue';
import { VForm } from '@/plugins/vuetify';

const deepCopy = (data: any) => JSON.parse(JSON.stringify(data));

export type DataType = {
  loading:  boolean
  valid:    boolean
  duplicateNameList: Array<String>
}

export default Vue.extend({
  props: {
    user: { type: Object as () => User, default: () => new User() }
  },
  data(): DataType {
    return {
      loading:           false,
      valid:             true,
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
    },
  },
  methods: {
    updateUser(): void {
      if (!this.getForm.validate()) return;

      this.loading = true;

      const params = {
        name:     this.user.name,
        password: this.user.password
      }
      customAxios.patch(api.userPath(this.$store.getters.userId), { user: params })
        .then(response => {
          this.$store.commit('setUser', response.data);
          this.$emit('updateDone');
        })
        .catch(error => {
          console.log(error.response);
          if (error.response.data.error === 'duplicate_name') {
            this.duplicateNameList.push(this.user.name);
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

<style lang="scss" scoped>
  .button-area {
    display: grid;
    grid-template-columns: 1fr 64px;

    .update-button {
      grid-area: 1/2/2/3;
      margin-top: 20px;
    }
  }
</style>
