<template lang="pug">
  v-responsive.rounded-circle.d-inline-flex.align-center.justify-center.ma-4(
    v-bind:style="{ background: color }"
    height="32"
    width="32"
  )
</template>

<script lang="ts">
import Vue from 'vue';

export default Vue.extend({
  props: {
    color: { type: String, default: '#ddd' },
  },
})
</script>
