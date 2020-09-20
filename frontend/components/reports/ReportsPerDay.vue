<template lang="pug">
  per-date-template.bar-chart(
    :start="start"
    :end="end"
    type="day"
  )
</template>

<script lang="ts">
import Vue from 'vue';
import PerDateTemplate from '@/components/reports/PerDateTemplate.vue';
import DatePicker from '@/components/common/DatePicker.vue';
import moment, { Moment } from 'moment';

export default Vue.extend({
  props: {
    date: { type: moment, default: moment() }
  },
  components: {
    PerDateTemplate,
    DatePicker
  },
  computed: {
    setDate: {
      get(): Moment { return this.date },
      set(newValue: any): void { this.$emit('update:date', newValue); }
    },
    start(): string {
      const startOfMonth = moment(this.date).startOf('M');
      return this.formatMoment(startOfMonth);
    },
    end(): string {
      const endOfMonth = moment(this.date).endOf('M');
      return this.formatMoment(endOfMonth);
    },
  },
  methods: {
    formatMoment(moment: Moment): string {
      return moment.format('YYYY-MM-DD');
    },
  }
})
</script>

<style lang="scss" scoped>
  .bar-chart /deep/ canvas {
    height: 1000px !important;
  }
</style>
