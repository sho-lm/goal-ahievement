<template lang="pug">
  per-date-template.bar-chart(
    :start="start"
    :end="end"
    type="month"
  )
</template>

<script lang="ts">
import Vue from 'vue';
import PerDateTemplate from '@/components/reports/PerDateTemplate.vue';
import YearPicker from '@/components/reports/YearPicker.vue';
import moment, { Moment } from 'moment';

export default Vue.extend({
  props: {
    date: { type: moment, default: moment() }
  },
  data() {
    return {
      options: {

      }
    }
  },
  components: {
    PerDateTemplate,
    YearPicker
  },
  computed: {
    setDate: {
      get(): Moment { return this.date },
      set(newValue: any): void { this.$emit('update:date', newValue); }
    },
    start(): string {
      const startOfYear = moment(this.date).startOf('y');
      return this.formatMoment(startOfYear);
    },
    end(): string {
      const endOfYear = moment(this.date).endOf('y');
      return this.formatMoment(endOfYear);
    },
  },
  methods: {
    formatMoment(moment: Moment): string {
      return moment.format('YYYY-MM');
    },
  }
})
</script>

<style lang="scss" scoped>
  .bar-chart /deep/ canvas {
    height: 420px !important;
  }
</style>
