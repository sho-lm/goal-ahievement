<template lang="pug">
  v-sheet.mt-5(
    height=500
  )
    v-calendar.calendar(
      ref="calendar"
      :v-model="formatMoment(today)"
      type="custom-daily"
      :events="events"
      :event-color="getEventColor"
      color="blue lighten-3"
      locale="ja"
      :start="formatMoment(start)"
      :end="formatMoment(end)"
    )
</template>

<script lang="ts">
import Vue from 'vue';
import { customAxios } from '@/plugins/customAxios';
import { api } from '@/config/api';
import DatePicker from '@/components/common/DatePicker.vue';
import moment, { Moment } from 'moment';

interface Event {
  name:  string
  start: string
  end:   string
  color: string
}

export type DataType = {
  events: Array<Event>
}

export default Vue.extend({
  props: {
    date:  { type: moment, default: moment() },
    today: { type: moment, default: moment() },
  },
  data(): DataType  {
    return {
      events: [],
    }
  },
  components: {
    DatePicker
  },
  computed: {
    userId(): string {
      return this.$store.getters.userId;
    },
    start: {
      get(): Moment { return this.date },
      set(newValue: Moment): void { this.$emit('update:date', newValue); }
    },
    end(): Moment {
      return moment(this.date).add(6, 'd');
    },
    filterList(): Array<string> {
      return this.$store.getters.reportFilterList;
    }
  },
  async mounted() {
    this.selectReportList();

    // this.$refs.calendar に scrollToTime メソッドがあると認識されずにエラーが出るのを回避するためにキャストしている
    (this.$refs.calendar as any).scrollToTime('08:00');
  },
  watch: {
    start() {
      this.selectReportList();
    },
    filterList() {
      this.selectReportList();
    }
  },
  methods: {
    formatMoment(moment: Moment): string {
      return moment.format('YYYY-MM-DD');
    },
    getEventColor (event: Event): string {
      return event.color
    },
    selectReportList(): void {
      const params = {
        start_date:  this.formatMoment(this.start),
        end_date:    this.formatMoment(this.end),
        filter_list: this.filterList
      };
      
      customAxios.get(api.reportsPerTimePath(this.userId), { params: params })
        .then(response => {
          // 前回のデータを削除
          this.events = [];

          // 日時の値が正しいものはグラフに表示する
          for (let i = 0, len = response.data.length; i < len; i++) {
            const d = response.data[i];
            
            if (this.isValidDate(d.start) && this.isValidDate(d.end)) {
              this.events.push(d);
            }
          }
        })
        .catch(error => {
          console.log(error.response);
        })
    },
    isValidDate(dateString: string): boolean {
      // YYYY-MM-DD HH:mm 形式であるか
      if (!dateString || dateString.length !== 16) {
        return false;
      }

      // 日時の値として正しいか
      const date = moment(dateString);
      return date.isValid();
    }
  },
})
</script>

<style lang="scss" scoped>
  .date-select {
    display: grid;
    grid-template-columns: 300px;
    height: 50px;

    .back-to-today {
      margin: auto auto auto 30px;
      color: rgb(102, 102, 230);

      &:hover {
        cursor: pointer;
      }
    }
  }

  .calendar {
    border-top: none !important;

    /deep/ .v-calendar-daily__head {
      border-top: 1px solid #e0e0e0;
    }

    /deep/ .v-calendar-daily__intervals-body {
      border-bottom: 1px solid #e0e0e0;
    }
  }
</style>
