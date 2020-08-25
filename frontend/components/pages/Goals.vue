<template lang="pug">
  div
    .goals-header.page-header
      .page-title 目標一覧
      v-select.filter-select(
        v-model="selected"
        :items="filterSelectors"
        dense
        hide-details
      )

      .delete-mode-area(v-if="deleteMode")
        v-btn.all-uncheck-button(
          @click="uncheckAll"
          icon
        )
          v-icon check_box_outline_blank
        v-btn.all-check-button(
          @click="checkAll"
          color="red"
          icon
        )
          v-icon check_box
        v-btn.delete-button(
          @click="deleteGoals"
          color="red"
          icon
        )
          v-icon delete
      v-btn.delete-mode-button(
        @click="changeDeleteMode"
        icon
      )
        v-icon(
          large
        ) {{ deleteModeIcon }}
      v-btn.add-mode-button(
        color="primary"
        @click="createMode = !createMode"
        icon
      )
        v-icon(
          large
        )  {{ createModeIcon }}
      v-divider.divider
      template(v-if="createMode")
        .new-goal
          p 新規作成
          goal-card(
            :propsContent="newGoal.content"
            :propsColor="newGoal.color"
            :propsIsFinished="newGoal.is_finished"
            :createMode.sync="createMode"
          )
        v-divider.divider-create-mode
    section.pa-6
      .goal-item(
        v-for="goal in goalList"
        :key="goal.id"
        v-if="goaiItemFilter(goal)"
        :style="{ 'grid-template-columns': `${checkboxWidth}px 1fr` }"
      )
        v-checkbox.mt-5(
          v-model="goal.deleteCheckBox"
          dense
          color="red"
        )
        goal-card.mb-1(
          :id="goal.id.toString()"
          :propsContent="goal.content"
          :propsColor="goal.color"
          :propsIsFinished="goal.is_finished"
          :createMode="false"
        )
</template>

<script lang="ts">
import Vue from 'vue';
import axios from 'axios';
import { api } from '@/config/api';
import { Goal } from '@/models/goal';
import GoalCard from '@/components/goals/GoalCard.vue';

const SELECTOR_VALUE = {
  FINISHED:     'finished',
  NOT_FINISHED: 'not finished',
  ALL:          'all',
} as const;
type SELECTOR_VALUE = typeof SELECTOR_VALUE[keyof typeof SELECTOR_VALUE]; // 型を定義

interface Selector {
  value: SELECTOR_VALUE
  text:  string
}

export type DataType = {
  deleteMode:      boolean
  createMode:      boolean
  newGoal:         Goal
  selected:        SELECTOR_VALUE
  filterSelectors: Array<Selector>
}

export default Vue.extend({
  data(): DataType {
    return {
      deleteMode:      false,
      createMode:      false,
      newGoal:         new Goal(),
      selected:        SELECTOR_VALUE.NOT_FINISHED,
      filterSelectors: [
        { value: SELECTOR_VALUE.FINISHED,     text: '完了済み' },
        { value: SELECTOR_VALUE.NOT_FINISHED, text: '未完了' },
        { value: SELECTOR_VALUE.ALL,          text: '全て' },
      ]
    }
  },
  components: {
    GoalCard,
  },
  computed: {
    goalList(): Array<Goal> {
      return this.$store.getters.goalList;
    },
    checkboxWidth(): number {
      return this.deleteMode ? 40 : 0;
    },
    deleteList(): Array<Goal> {
      return this.$store.getters.goalList.filter((goal: Goal) => goal.deleteCheckBox);
    },
    deleteModeIcon(): string {
      return this.deleteMode ? 'undo' : 'remove_circle';
    },
    createModeIcon(): string {
      return this.createMode ? 'undo' : 'add_circle';
    },
    goaiItemFilter: function() {
      const self = this;
      return (goal: Goal): boolean => {
        
        if (self.selected === SELECTOR_VALUE.ALL) return true;

        return self.selected === SELECTOR_VALUE.FINISHED ? goal.is_finished : !goal.is_finished;
      }
    }
  },
  methods: {
    changeDeleteMode(): void {
      this.deleteMode = !this.deleteMode;
      if (!this.deleteMode) {
        this.uncheckAll();
      }
    },
    uncheckAll(): void {
      for (let goal of this.goalList) {
        goal.deleteCheckBox = false;
      }
    },
    checkAll(): void {
      for (let goal of this.goalList) {
        goal.deleteCheckBox = true;
      }
    },
    deleteGoals(): void {
      const deleteIdList = [];
      for (let goal of this.deleteList) {
        deleteIdList.push(goal.id);
      }
      const params = {
        ids: deleteIdList
      }
      axios.delete(api.goalMultiplePath(this.$store.getters.userId), { params })
        .then(response => {
          this.$store.commit('setGoalList', response.data);
        })
        .catch(error => {
          console.log(error.response);
        })
    }
  }
})
</script>

<style lang="scss" scoped>
  .goals-header {
    display: grid;
    grid-template-columns: 130px 130px 1fr 300px 100px 100px;

    .page-title {
      grid-area: 1/1/2/2;
      margin: 15px 10px;
      font-weight: bold;
    }

    .filter-select {
      grid-area: 1/2/2/3;
      margin: auto 0;
    }

    .delete-mode-area {
      border: 1px solid rgba(0, 0, 0, 0.2);
      border-radius: 20px;
      display: grid;
      grid-area: 1/4/2/5;
      height: 40px;
      margin: auto 30px;

      .all-uncheck-button {
        grid-area: 1/2/2/3;
      }
      .all-check-button {
        grid-area: 1/3/2/4;
      }
      .delete-button {
        grid-area: 1/4/2/5;
      }
    }

    .delete-mode-button {
      grid-area: 1/5/2/6;
      margin: auto 0;
    }
    .add-mode-button {
      grid-area: 1/6/2/7;
      margin: auto 0;
    }
    .divider {
      grid-area:2/1/2/7;
    }
    .new-goal {
      grid-area: 2/1/3/7;
      padding: 24px;
    }
    .divider-create-mode {
      grid-area: 3/1/3/7;
    }
  }

  .goal-item {
    display: grid;
  }
</style>