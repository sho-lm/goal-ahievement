<template lang="pug">
  .mandal-art-large
    mandal-art-small(
      v-for="n in 9"
      :key="n"
      :content="n + ''"
      :color="`#5${n}9`"
    )
</template>

<script lang="ts">
import Vue from 'vue'
import MandalArtSmall from '@/components/goals/MandalArtSmall.vue';

const sessionKey = 'userId';

export type DataType = {
}

export default Vue.extend({
  data(): DataType  {
    return {
    }
  },
  components: {
    MandalArtSmall,
  }
})
</script>

<style lang="scss" scoped>
  .mandal-art-large {

    display: grid;
    // grid-auto-rows: var(--size);
    grid-template-columns: repeat(3, 300px);
  }
</style>