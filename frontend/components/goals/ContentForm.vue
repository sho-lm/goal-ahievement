<template lang="pug">
  v-text-field(
    v-model.trim="setContent"
    :counter="20"
    
    required
    :rules="rules"
    validate-on-blur
  )
</template>

<script lang="ts">
import Vue, { VueConstructor } from 'vue';
import { Goal } from '@/models/goal';
import { VuetifyIconComponent } from 'vuetify/types/services/icons';

export type DataType = {
  rules:   Array<(v: string) => boolean | string>
}

export default Vue.extend({
  props: {
    content: { type: String, default: '' },
  },
  data(): DataType {
    return {
      rules:   Goal.getContentRules(),
    }
  },
  computed: {
    setContent: {
      get(this) { return this.content },
      set(newVal: string) { return this.$emit('update:content', newVal) } 
    }
  }
})
</script>
