<template lang="pug">
  .year-picker
    v-btn.fast-prev(
      icon
      @click="prev(10)"
    )
      v-icon.left chevron_left
      v-icon.right chevron_left
    v-btn.ma-auto(
      icon
      @click="prev(1)"
    )
      v-icon chevron_left
    v-text-field.year-text(
      :value="date.format('YYYY年')"
      dense
      hide-details
      readonly
    )
      template(v-slot:prepend-inner)
        .calendar-icon
          v-icon today
    v-btn.ma-auto(
      icon
      @click="next(1)"
    )
      v-icon chevron_right
    v-btn.fast-next(
      icon
      @click="next(10)"
    )
      v-icon.left chevron_right
      v-icon.right chevron_right
</template>

<script lang="ts">
import Vue from 'vue';
import moment, { Moment } from 'moment';

moment.locale('ja');

export default Vue.extend({
  props: {
    date: { type: moment, default: moment() }
  },
  methods: {
    emit(date: Moment): void {
      this.$emit('update:date', date);
    },
    prev(steps: number): void {
      const prev = moment(this.date);
      prev.subtract(steps, 'y');
      this.emit(prev);
    },
    next(steps: number): void {
      const next = moment(this.date)
      next.add(steps, 'y');
      this.emit(next);
    },
  }
})
</script>

<style lang="scss" scoped>
  .year-picker {
    display: grid;
    grid-template-columns: 30px 50px 120px 50px 30px;
    height: 100%;

    .calendar-icon {
      width: 36px;
      height: 36px;
      display: inline-block;

      /deep/ .v-icon {
        margin: 6px;
      }
    }

    .fast-prev {
      position: relative;
      margin: auto;

      .left {
        position: absolute;
        left: 0;
      }
      .right {
        position: absolute;
        left: 10px;
      }
    }

    .fast-next {
      position: relative;
      margin: auto;

      .right {
        position: absolute;
        right: 0;
      }

      .left {
        position: absolute;
        right: 10px;
      }
    }
  }
</style>
