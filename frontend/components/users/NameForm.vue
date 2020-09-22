<template lang="pug">
  div
    label Name
    v-text-field(
      v-model.trim="setName"
      :counter="20"
      dense
      outlined
      required
      :rules="rules"
      type="tel"
      validate-on-blur
    )
</template>

<script lang="ts">
import Vue, { PropType } from 'vue';
import { User } from '@/models/user';
import { VuetifyIconComponent } from 'vuetify/types/services/icons';

export default Vue.extend({
  props: {
    name:              { type: String,   default: '' },
    readonly:          { type: Boolean,  default: false },
    duplicateNameList: { type: Array as PropType<string[]>, default: () => []}
  },
  computed: {
    rules(): Array<(v: string) => boolean | string> {
      const rules = User.getNameRules();
      rules.push(this.duplicateNameRule);
      return rules;
    },
    duplicateNameRule(): (v: string) => boolean | string {
      return (v: string) => (v && !this.isNameDuplicated(v)) || 'すでに使われている名前です';
    },
    setName: {
      get(this) { return this.name },
      set(newVal: string) { return this.$emit('update:name', newVal) } 
    }
  },
  methods: {
    isNameDuplicated(name: string): boolean {
      return this.duplicateNameList.includes(name);
    }
  }
})
</script>
