<template lang="pug">
  v-text-field(
    v-model.trim="setName"
    :counter="counter"
    dense
    :flat="readonly"
    outlined
    :readonly="readonly"
    required
    :rules="rules"
    solo
    type="tel"
    validate-on-blur
  )
</template>

<script lang="ts">
import Vue, { VueConstructor } from 'vue';
import { User } from '@/models/user';
import { VuetifyIconComponent } from 'vuetify/types/services/icons';

export type DataType = {
  rules:   Array<(v: string) => boolean | string>
}

export default Vue.extend({
  props: {
    name:     { type: String,   default: '' },
    readonly: { type: Boolean,  default: false },
  },
  data(): DataType {
    return {
      rules:   User.getNameRules(),
    }
  },
  computed: {
    counter(): number | undefined {
      return this.readonly ? undefined : 20;
    },
    setName: {
      get(this) { return this.name },
      set(newVal: string) { return this.$emit('update:name', newVal) } 
    }
  }
})
</script>
