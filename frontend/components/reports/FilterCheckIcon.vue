<template lang="pug">
  v-responsive.rounded-circle.d-inline-flex.align-center.justify-center.ma-4(
    v-bind:style="{ background: background }"
    height="10"
    width="10"
  )
</template>

<script lang="ts">
import Vue from 'vue';

export default Vue.extend({
  props: {
    color:  { type: String, default: '#ddd' },
    active: { type: Boolean, default: false }
  },
  computed: {
    background(): string {
      return this.active ? this.color : '';
    }
  }
})
</script>
