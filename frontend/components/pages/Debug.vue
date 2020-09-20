<template lang="pug">
  .debug
    year-picker(
      :date.sync="date"
    )
    date-picker(
      :date="date"
    )
</template>

<script lang="ts">
import Vue from 'vue';
import YearPicker from '@/components/reports/YearPicker.vue';
import DatePicker from '@/components/common/DatePicker.vue';
import moment, { Moment } from 'moment';


export default Vue.extend({
  data()  {
    return {
      date: moment()
    }
  },
  components: {
    YearPicker,
    DatePicker
  },
})
</script>

<style lang="scss" scoped>
  .debug {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 30px;
    height: 50px;
  }
</style>