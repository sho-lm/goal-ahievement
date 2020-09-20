<template lang="pug">
  .year-picker
    v-menu(
      v-model="menu"
      offset-y
      max-width="290px"
      min-width="290px"
      nudge-left="45"
    )
      template(v-slot:activator="{ on }")
        v-text-field.date-text(
          :value="selectedYear.text"
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
      .picker(
      )
        .picker-header {{ selectedYear.text }}
        .picker-body#yearList(
          ref="div"
        )
          ul#yearList2(
            ref="ul"
          )
            li(
              v-for="(y, i) in yearList"
              :key="y.value"
              @click="clickYear(y)"
              v-bind:class="{ active: y.active }"
            ) {{ y.text }}
</template>

<script lang="ts">
import Vue from 'vue';
import moment, { Moment } from 'moment';

moment.locale('ja');

interface SelectItem {
  key:    string
  value:  string
  text:   string
  active: boolean
}

const scroll = (element: any) => {
  console.log(element);
  element.scrollTop = 1000;
}

export default Vue.extend({
  props: {
    // date: { type: moment, default: moment() }
  },
  data() {
    return {
      date: moment(),
      menu: false
    }
  },
  mounted() {
    
    },
  watch: {
    menu(): void {
      if (this.menu) {
        this.scrollToSelected();
      }
    }
  },
  computed: {
    selectedYear(): SelectItem {
      const selected = this.yearItem(this.date.year());
      selected.active = true;

      return selected;
    },
    yearList(): Array<SelectItem> {
      const yearList = [];
      
      // 現在を真ん中
      yearList.push(this.selectedYear);

      const currentYear = Number(this.selectedYear.value);
      // 未来を上(配列では前)
      for (let i = 1; i <= 100 && currentYear - i >= 88; i++) {
        const yearItem = this.yearItem(currentYear - i);
        yearList.unshift(yearItem);
      }

      // 過去を下(配列では後)
      for (let i = 1; i <= 100 && currentYear + i <= 9899; i++) {
        const yearItem = this.yearItem(currentYear + i);
        yearList.push(yearItem);
      }
      return yearList;
    }
  },
  methods: {
    yearItem(year: string | number): SelectItem {
      return  {
        key:    year.toString(),
        value:  year.toString(),
        text:   `${year}年`,
        active: false
      };
    },
    clickYear(yearItem: SelectItem): void {
      this.date = moment(yearItem.value.toString());
    },
    scrollToSelected(): void {
      this.$nextTick(() => {
        let ul: any = this.$refs.div;
        ul.scrollTop = 1000;
        console.log(ul);
        
      });
    }
  },
})
</script>

<style lang="scss" scoped>
  .year-picker {
    display: grid;

    .date-text {
      /deep/ input:hover {
        cursor: pointer;
      }
    }
  }

  .picker-header {
    background: #1976d2;
    color: #fff;
    font-size: 34px;
    height: 74px;
    padding: 16px;
  }
  .picker-body {
    

    ul {
      height: 290px;
      overflow: auto;
      font-size: 16px;
      list-style: none;
      font-weight: 400;
      text-align: center;

      li {
        padding: 8px 0;
        // line-height: 24px;

        &:hover {
          cursor: pointer;
        }
      }

      .active {
        color: #1976d2 ;
        font-size: 26px;
        font-weight: 500;
        padding:  10px 0;
      }
    }
  }
</style>
