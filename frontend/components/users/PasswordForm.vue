<template lang="pug">
  v-text-field(
    v-model.trim="setPassword"
    :counter="20"
    dense
    outlined
    :placeholder="placeholder"
    required
    :rules="rules"
    solo
    type="password"
    validate-on-blur
  )
</template>

<script lang="ts">
import Vue from 'vue'
import { User } from '@/models/user';


export type DataType = {
  rules:       Array<(v: string) => boolean | string>
}

export default Vue.extend({
  props: {
    password:   { type: String,   default: '' },
    updateMode: { type: Boolean,  default: false },   // 更新のときはパスワードは必須ではない
  },
  data(): DataType {
    return {
      rules: this.updateMode ? User.getPasswordUpdateRules() : User.getPasswordRules(),
    }
  },
  computed: {
    placeholder(): string {
      return this.updateMode ? '変更する場合は入力してください' : '';
    },
    setPassword: {
      get(this): string { return this.password },
      set(newVal: string) { return this.$emit('update:password', newVal) } 
    }
  }
})
</script>
