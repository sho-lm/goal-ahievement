<template lang="pug">
  v-menu(
    v-model="menu"
    :close-on-content-click="false"
    offset-y
    max-width="290px"
    min-width="290px"
  )
    template(v-slot:activator="{ on }")
      v-text-field.date-text(
        :value="date.format('YYYY年M月D日(ddd)')"
        v-on="on"
        dense
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
    v-date-picker(
      v-model="pickerDate"
      :day-format="dayFormat"
      locale="ja"
    )
</template>

<script lang="ts">
import Vue from 'vue';
import moment, { Moment } from 'moment';

moment.locale("ja");

export default Vue.extend({
  props: {
    date: { type: moment , default: moment() }
  },
  data() {
    return {
      menu: false,
    }
  },
  computed: {
    pickerDate: {
      get(): string { return this.date.format('YYYY-MM-DD'); },
      set(newValue: string): void {
        
        const newDate = moment(newValue);
        if (newDate.isValid()) {
          this.$emit('update:date', newDate);
          this.menu = false;
        }
      }
    }
  },
  methods: {
    dayFormat(dateString: string): string {
      return moment(dateString).format('D');
    },
  }
})
</script>

<style lang="scss" scoped>
  .date-text {

    /deep/ input:hover {
      cursor: pointer;
    }
  }
</style>