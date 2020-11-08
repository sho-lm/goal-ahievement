<template lang="pug">
  .chart
    .label(
      v-bind:class="{'type-day-label' : this.type === 'day' }"
    )
      bar-chart(
        v-if="loaded"
        :chartData="chartData"
      )
    .data(
      v-bind:class="{'type-day-data' : this.type === 'day' }"
    )
      bar-chart(
        v-if="loaded"
        :chartData="chartData"
        :xlabelDisplay="false"
      )
</template>

<script lang="ts">
import Vue from 'vue';
import BarChart from '@/components/reports/BarChart.vue';
import { customAxios } from '@/plugins/customAxios';
import { api } from '@/config/api';

export type DataType = {
  loaded:    boolean
  chartData: object
}

export default Vue.extend({
  props: {
    start:     { type: String,  default: '' },
    end:       { type: String,  default: '' },
    type:      { type: String,  default: 'day' },
  },
  data() {
    return {
      loaded: false,
      chartData: {},
    }
  },
  components: {
    BarChart
  },
  async mounted() {
    this.selectReportList();
  },
  computed: {
    userId(): string {
      return this.$store.getters.userId;
    },
    filterList(): Array<string> {
      return this.$store.getters.reportFilterList;
    }
  },
  watch: {
    start(): void {
      this.selectReportList();
    },
    filterList(): void {
      this.selectReportList();
    }
  },
  methods: {
    selectReportList(): void {
      this.loaded = false;
      const params = {
        start_date:  this.start,
        end_date:    this.end,
        type:        this.type,
        filter_list: this.filterList
      };
      customAxios.get(api.reportsPerDatePath(this.userId), { params: params })
        .then(response => {
          this.chartData = {
            labels:   response.data.labels,
            datasets: response.data.datasets
          }
          this.loaded = true;
        })
        .catch(error => {
          console.log(error.response);
        })
    },
  }
})
</script>

<style lang="scss" scoped>
  .chart {
    .label {
      height: 53px;
      overflow: hidden;
      position: relative;
      background: #fff;
      z-index: 3;
    }

    .type-day-label {
      margin-right: 17px;
    }

    .data {
      height: 478px;
      margin-top: -31px;
    }

    .type-day-data {
      overflow-y: scroll;
    }
  }
</style>
