<template lang="pug">
  v-container
    .grid
      time-picker(
        hourText="時間"
        minuteText="分"
      )
      vue-timepicker
      time-picker
</template>

<script lang="ts">
import Vue from 'vue'
import TimePicker from '@/components/workRecords/TimePicker.vue';
import VueTimepicker from 'vue2-timepicker/src/vue-timepicker.vue';

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
    TimePicker,
    VueTimepicker
  },
})
</script>

<style lang="scss" scoped>
  .grid {
    display: grid;
    grid-template-columns: 1fr 1fr 1fr;
  }
</style>
