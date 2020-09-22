<script lang="ts">
import Vue from 'vue';
import { HorizontalBar, mixins } from 'vue-chartjs';
import { ChartData, ChartOptions } from 'chart.js';

const { reactiveProp } = mixins;

export default Vue.extend({
  extends: HorizontalBar,
  mixins: [reactiveProp],
  props: {
    chartData:     { type: Object as () => ChartData,    default: null },
    options:       { type: Object as () => ChartOptions, default: null },
    xlabelDisplay: { type: Boolean,                      default: true }
  },
  data() {
    return {
      defaultOptions: {
        responsive: true,
        maintainAspectRatio: false,
        title: {
          display: false,
        },
        scales: {
          yAxes: [{
            stacked: true,
            ticks: {
              beginAtZero: true
            },
            scaleLabel: {
              display: false,
            }
          }],
          xAxes: [{
            stacked: true,
            position: 'top',
            ticks: {
              beginAtZero: true,
            },
            scaleLabel: {
              display: this.xlabelDisplay,
              labelString: '(時間)'
            }
          }]
        },
        legend: {
          display: false
        }
      }
    }
  },
  mounted(): void {
    // this に renderChart メソッドがあると認識されずにエラーが出るのを回避
    (this as any).renderChart(this.chartData, this.mergedOptions);
  },
  computed: {
    mergedOptions(): object {
      return Object.assign(this.defaultOptions, this.options);
    }
  }
})
</script>
