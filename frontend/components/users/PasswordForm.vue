<template lang="pug">
  v-text-field(
    @click:append="show = !show"
    v-model="setPassword"
    :append-icon="show ? 'visibility' : 'visibility_off'"
    :counter="20"
    dense
    outlined
    required
    :rules="rules"
    solo
    :type="show ? 'text' : 'password'"
    validate-on-blur
  )
</template>

<script lang="ts">
import Vue from 'vue'
import { User } from '@/models/user';


export type DataType = {
  rules: Array<(v: string) => boolean | string>
  show:  boolean
}

export default Vue.extend({
  props: {
    password: {
      type: String,
      default: '',
    }
  },
  data(): DataType {
    return {
      rules: User.getPasswordRules(),
      show:  false,
    }
  },
  computed: {
    setPassword: {
      get(this): string { return this.password },
      set(newVal: string) { return this.$emit('update:password', newVal) } 
    }
  }
})
</script>

<style lang="scss" scoped>

</style>