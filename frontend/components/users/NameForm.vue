<template lang="pug">
  v-text-field(
    v-model="setName"
    :counter="20"
    dense
    outlined
    required
    :rules="rules"
    solo
    validate-on-blur
  )
</template>

<script lang="ts">
import Vue, { VueConstructor } from 'vue';
import { User } from '@/models/user';
import { VuetifyIconComponent } from 'vuetify/types/services/icons';

export type DataType = {
  rules: Array<(v: string) => boolean | string>
}

export default Vue.extend({
  props: {
    name: {
      type: String,
      default: '',
    }
  },
  data(): DataType {
    return {
      rules: User.getNameRules(),
    }
  },
  computed: {
    setName: {
      get(this) { return this.name },
      set(newVal: string) { return this.$emit('update:name', newVal) } 
    }
  }
})
</script>

<style lang="scss" scoped>

</style>