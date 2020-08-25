<template lang="pug">
  v-card(
    :color="color"
  )
    v-card-title.justify-center.content(

    ) {{ content }}
</template>

<script lang="ts">
import Vue from 'vue';

export default Vue.extend({
  props: {
    content: { type: String, default: 'hello' },
    color:   { type: String, default: '#fff' },
  },
})
</script>

<style lang="scss" scoped>
  .content {
    height: 100%;
  }
</style>