<template lang="pug">
  .mandal-art-small
    goal-card_mandal(
      v-for="n in 9"
      :key="n"
      :content="content +  '-' + n"
      :color="color"
    )
</template>

<script lang="ts">
import Vue from 'vue';
import GoalCardMandal from '@/components/goals/GoalCardMandal.vue';

export default Vue.extend({
  data() {
    return {
    }
  },
  props: {
    content: { type: String, default: '0' },
    color:   { type: String, default: '0' },
  },
  components: {
    GoalCardMandal,
  }
})
</script>

<style lang="scss" scoped>
  .mandal-art-small {

    --size: 100px;

    display: grid;
    grid-auto-rows: var(--size);
    grid-template-columns: repeat(3, var(--size));
  }
</style>
