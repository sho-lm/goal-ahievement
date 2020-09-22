<template lang="pug">
  .reports
    .reports-header.page-header
      v-select.type-select(
        v-model="type"
        :items="typeList"
        dense
        hide-details
      )
      .date-select
        year-picker.picker(
          v-if="type === 'month'"
          :date.sync="date"
        )
        date-picker.picker(
          v-else
          :date.sync="date"
          showArrow
          :type="pickerType"
        )
      .category-select
        category-filter
    section
      reports-per-day(
        v-if="type === 'day'"
        :date.sync="date"
      )
      reports-per-month(
        v-else-if="type === 'month'"
        :date.sync="date"
      )
      reports-per-time(
        v-else
        :date.sync="date"
        :today="today"
      )
</template>

<script lang="ts">
import Vue from 'vue';
import ReportsPerDay from '@/components/reports/ReportsPerDay.vue';
import ReportsPerMonth from '@/components/reports/ReportsPerMonth.vue';
import ReportsPerTime from '@/components/reports/ReportsPerTime.vue';
import YearPicker from '@/components/reports/YearPicker.vue';
import DatePicker from '@/components/common/DatePicker.vue';
import CategoryFilter from '@/components/reports/CategoryFilter.vue';

import moment, { Moment } from 'moment';

export type DataType = {
  typeList: Array<object>
  today:    Moment
}

export default Vue.extend({
  data(): DataType {
    return {
      typeList: [
        { text: '1週間の記録', value: 'time'},
        { text: '1か月の記録', value: 'day'},
        { text: '1年間の記録',   value: 'month'} 
      ],
      today:    moment(),
    }
  },
  components: {
    ReportsPerTime,
    ReportsPerDay,
    ReportsPerMonth,
    DatePicker,
    YearPicker,
    CategoryFilter
  },
  computed: {
    date: {
      get(): Moment { return this.$store.getters.reportDate; },
      set(newValue: Moment): void {  this.$store.commit('setReportDate', newValue); }
    },
    type: {
      get(): string { return this.$store.getters.reportType; },
      set(newValue: string): void { this.$store.commit('setReportType', newValue); }
    },
    pickerType(): string {
      return this.type === 'day' ? 'month' : 'date';
    }
  }
})
</script>

<style lang="scss" scoped>
  .reports {
    position: relative;

    &-header {
      display: grid;
      grid-template-columns: 180px minmax(300px, 1fr) 180px;
      padding-top: 5px;
      height: 60px;

      .type-select {
        margin: auto 10px;
      }

      .date-select {
        margin-left: 10px;
      }
      
      .category-select {
        margin-right: 10px;
      }

    }

    section {
      z-index: 1;
      padding: 0 24px;
    }
  }
</style>
