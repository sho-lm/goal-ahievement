<template lang="pug">
  v-menu(
    v-model="menu"
    :close-on-content-click="false"
    offset-y
    max-width="160px"
    min-width="160px"
  )
    template(v-slot:activator="{ on }")
      v-text-field.time-text(
        :value="timeText"
        v-on="on"
        dense
        placeholder="勉強時間"
        hide-details
        readonly
      )
        template(v-slot:prepend-inner)
          v-btn(
            v-on="on"
            icon
            color="primary"
          )
            v-icon today
    .dropdown
      .select-list
        ul.hours
          li.hint {{ hourText || 'HH' }}
          li(
            v-for="(h, i) in hourList"
            :key="h.value"
            @click="clickHour(i)"
            v-bind:class="{ active: h.active }"
          ) {{ h.text }}
        ul.minutes
          li.hint {{ minuteText || 'mm' }}
          li(
            v-for="(m, i) in minuteList"
            :key="m.value"
            @click="clickMinute(i)"
            v-bind:class="{ active: m.active }"
          ) {{ m.text }}
      
</template>

<script lang="ts">
import Vue from 'vue';
import VueTimepicker from 'vue2-timepicker/src/vue-timepicker.vue';

interface TimeList {
  key:    string
  value:  string
  text:   string
  active: boolean
}

const getHourList = (): Array<TimeList> => {
  const hourList: TimeList[] = [];
  for (let i = 0; i < 24; i++) {
    const li = {
      key:    `h-${i}`,
      value:  ('0' + i).slice(-2),
      text:   i.toString(),
      active: false
    };
    hourList.push(li);
  }
  return hourList;
}

const getMinuteList = (): Array<TimeList> => {
  const minuteList: TimeList[] = [];
  for (let i = 0; i < 60; i++) {
    const li = {
      key:    `m-${i}`,
      value:  ('0' + i).slice(-2),
      text:   i.toString(),
      active: false
    };
    minuteList.push(li);
  }
  return minuteList;
}

export type DataType = {
  menu:       boolean
  hour:       string
  minute:     string
  hourList:   Array<TimeList>
  minuteList: Array<TimeList>
};

export default Vue.extend({
  props: {
    time: { type: String, default: '' },
    hourText: { type: String, default: ''},
    minuteText: { type: String, default: ''},
  },
  data(): DataType {
    return {
      menu:       false,
      hour:       '',
      minute:     '',
      hourList:   getHourList(),
      minuteList: getMinuteList(),
    }
  },
  components: {
    VueTimepicker
  },
  computed: {
    timeText(): string {
      let timeText = '';
      const h = Number(this.hour);
      const m = Number(this.minute);
      if (h) {
        timeText += h + this.hourText;
      }
      if (m) {
        timeText += m + this.minuteText;
      }
      return timeText;
    }
  },
  methods: {
    clickHour(index: number) {
      this.hourList.forEach(e => {
        e.active = false;
      });

      const clickedHour = this.hourList[index];
      clickedHour.active = true;
      this.hour = clickedHour.value;
    },
    clickMinute(index: number) {
      this.minuteList.forEach(e => {
        e.active = false;
      });

      const clickMinute = this.minuteList[index];
      clickMinute.active = true;
      this.minute = clickMinute.value;
    }
  }
})
</script>

<style lang="scss" scoped>
  .select-list {
    display: grid;
    grid-template-columns: 1fr 1fr;
    width: 10em;
    height: 10em;
    overflow: hidden;

    ul {
      margin: 0;
      padding: 0;
      overflow-x: hidden;
      overflow-y: auto;
      list-style: none;


      li {
        text-align: center;
        padding: 0.3em 0;

        &:not(.hint):hover {
          cursor: pointer;
        }
      }

      .hint {
        color: #a5a5a5;
        cursor: default;
        font-size: 0.8em;
      }

      .active {
        background: #41B883;
        color: #fff;
      }
    }
  }
</style>