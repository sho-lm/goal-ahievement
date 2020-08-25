<template lang="pug">
  v-container
    goal-card(
      :content.sync="content"
      :color.sync="color"
    )
</template>

<script lang="ts">
import Vue from 'vue'
import axios from 'axios';
import { api } from '@/config/api';
import GoalCard from '@/components/goals/GoalCard.vue';

const sessionKey = 'userId';

export type DataType = {
}

export default Vue.extend({
  data()  {
    return {
      readonly: false,
      content: 'hey',
      color: '#48cc9180',
    }
  },
  components: {
    GoalCard
  },
})
</script>
