<template lang="pug">
  .category-filter
    v-menu(
      v-model="menu"
      :close-on-content-click="false"
      offset-y
      max-width="290px"
      min-width="290px"
      nudge-left="55"
    )
      template(v-slot:activator="{ on }")
        v-text-field.category-text(
          value="目標をしぼる"
          v-on="on"
          dense
          hide-details
          readonly
        )
          template(v-slot:prepend-inner)
            v-btn(
              v-on="on"
              icon
            )
              v-icon filter_list
      .filter-area
        .filter-header
          v-btn.ml-1(
            @click="uncheckAll"
            icon
          )
            v-icon check_box_outline_blank
          v-btn.ml-3(
            @click="checkAll"
            icon
          )
            v-icon check_box
        ul
          li(
            v-for="goal in goalList"
            :key="goal.id"
            @click="goal.filterCheck = !goal.filterCheck"
            v-bind:class="{ inactive: !goal.filterCheck }"
          )
            filter-check-icon(
              :color="goal.color"
              :active="goal.filterCheck"
            )
            .filter-text {{ goal.content }}
          li.default(
            @click="defaultGoal.filterCheck = !defaultGoal.filterCheck"
            v-bind:class="{ inactive: !defaultGoal.filterCheck }"
          )
            filter-check-icon(
              :color="defaultGoal.color"
              :active="defaultGoal.filterCheck"
            )
            .filter-text {{ defaultGoal.content }}
</template>

<script lang="ts">
import Vue from 'vue';
import FilterCheckIcon from '@/components/reports/FilterCheckIcon.vue';
import { Goal } from '@/models/goal';

interface GoalFilter {
  id:           string
  content:      string
  color:        string
  filterCheck:  boolean
}

export type DataType = {
  menu:        boolean
  defaultGoal: GoalFilter
}

export default Vue.extend({
  data(): DataType {
    return {
      menu: false,
      defaultGoal: {
        id:           '0',
        content:      '設定なし',
        color:        '#bbb',
        filterCheck:  true
      }
    }
  },
  components: {
    FilterCheckIcon
  },
  mounted() {
    this.updateFilterList();
  },
  watch: {
    goalList(): void {
      this.updateFilterList();
    },
    menu(): void {
      if (!this.menu) {
        this.updateFilterList();
      }
    }
  },
  computed: {
    goalList(): Array<Goal> {
      return this.$store.getters.goalList;
    },
    filteredlList(): Array<string> {
      const filteredList = [];
      for (let goal of this.goalList) {
        if (goal.filterCheck) {
          filteredList.push(goal.id.toString());
        }
      }

      if (this.defaultGoal.filterCheck) {
        filteredList.push(this.defaultGoal.id);
      }
      
      return filteredList;
    }
  },
  methods: {
    uncheckAll(): void {
      for (let goal of this.goalList) {
        goal.filterCheck = false;
      }
      this.defaultGoal.filterCheck = false;
    },
    checkAll(): void {
      for (let goal of this.goalList) {
        goal.filterCheck = true;
      }
      this.defaultGoal.filterCheck = true;
    },
    updateFilterList(): void {
      this.$store.commit('setReportFilterList', this.filteredlList);
    }
  },
})
</script>

<style lang="scss" scoped>
  .category-filter {
    width: 180px;
    
    .category-text {
      /deep/ input:hover {
        cursor: pointer;
      }
    }
  }

  .filter-area {
    background: #fff;

    ul {
      list-style: none;
      padding: 0;

      li {
        display: grid;
        grid-template-columns: 40px 250px;

        &:hover {
          cursor: pointer;
        }

        .filter-text {
          margin: auto 0;
        }
      }

      .inactive {
        opacity: 0.5;
        text-decoration: line-through;
      }
    }
  }
</style>
