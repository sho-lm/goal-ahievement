<template lang="pug">
  vue-timepicker(
    v-model="setWorkTime"
    auto-scroll
    format="H時間m分"
    hour-label="時間"
    minute-label="分"
    placeholder="勉強時間"
  )
</template>

<script lang="ts">
import Vue from 'vue';
import moment, { Moment } from 'moment';
import VueTimepicker from 'vue2-timepicker/src/vue-timepicker.vue';

const regexp = /(\d{1,2})時間(\d{1,2})分/;

export default Vue.extend({
  props: {
    workTime:       { type: Number,  default: 0 },
    startTime:      { type: String,  default: '' },
    endTime:        { type: String,  default: '' },
    workTimeValid:　{ type: Boolean, default: true },
    startTimeValid: { type: Boolean, default: true }
  },
  components: {
    VueTimepicker
  },
  watch: {
    startTime(): void {
      this.changeWorkTimeByCalc();
    },
    endTime(): void {
      this.changeWorkTimeByCalc();
    },
  },
  computed: {
    setWorkTime: {
      get(): string {
        if (!this.workTime) {
          return '';
        }

        const h = Math.trunc(this.workTime / 60);
        const m = this.workTime % 60;
        return `${h}時間${m}分`;
      },
      set(newValue: string): void {
        this.$emit('update:workTimeValid', true);

        if (!newValue) {
          this.$emit('update:workTime', '');
          return;
        }
        
        const stringTime = regexp.exec(newValue);
        if (stringTime === null) return;

        const [, h, m] = stringTime;
        const time = Number(h) * 60 + Number(m);
        this.$emit('update:workTime', time.toString());

        // 開始・終了時刻から算出する時間と等しいか
        const calcTime = this.calcWorkTime();
        if (isNaN(calcTime)) return;

        if (time !== calcTime) {
          this.$emit('update:workTimeValid', false);
        }
      }
    },
  },
  methods: {
    convertTimeToMinute(timeString: string) {
      // 未入力の場合
      if (!timeString) {
        return NaN;
      }

      let [h, m] = timeString.split(':');
      const hour = Number(h);
      const minute = Number(m);

      // 時間 or 分 が未入力の場合
      if (isNaN(hour) || isNaN(minute)) {
        return NaN;
      }

      // 00:00 を基準として、分単位での経過時間
      return hour * 60 + minute;
    },
    calcWorkTime(): number {
      const start = this.convertTimeToMinute(this.startTime);
      const end = this.convertTimeToMinute(this.endTime);

      // 未入力の場合
      if (isNaN(start) || isNaN(end)) {
        return NaN;
      }

      return end - start;
    },
    changeWorkTimeByCalc(): void {
      const workTime = this.calcWorkTime();
      this.$emit('update:startTimeValid', true);
      
      // 未入力の場合
      if (isNaN(workTime)) return;

      // 負数 の場合は入力がおかしい
      if (workTime < 0) {
        this.$emit('update:startTimeValid', false);
        return;
      }

      this.$emit('update:workTime', workTime.toString());
    }
  }
})
</script>