<template lang="pug">
  #goals
    div(v-if="$store.getters.isLoggedIn")
      section.new-goal
        p new goal
        label(for="content") content
        input(v-model="content")
        label(for="limit") limit
        input(v-model="limit", type="date")
        button(@click="postCreate") create

      section.update-goal(v-if="isEditMode")
        label(for="content") content
        input(v-model="contentCopy")
        label(for="limit") limit
        input(v-model="limitCopy", type="date")
        button(@click="patchUpdate") update
        button(@click="deleteDestroy") delete
        button(@click="cancelEditMode") cancel

      section.goals
        h3 goals data list
        .goal-item(v-for="goal in goalsList")
          div.normal-mode
            p content:  {{ goal.content }}
            p limit: {{ goal.limit }}
            button(@click="changeEditMode(goal, $event)") edit mode
    div(v-else)  
      p you need log in
</template>

<script lang="ts">
import Vue from 'vue';
import axios from 'axios';
import { Goal } from '~/models/goal';
import { api } from '~/config/api';

export type DataType = {
  goalsList: Array<Goal>
  content:      string
  limit:        string
  contentCopy:  string
  limitCopy:    string
  goalId:       string
  isEditMode:   boolean
}

export default Vue.extend({
  data(): DataType {
    return {
      goalsList:    [],
      content:      '',
      limit:        '',
      contentCopy:  '',
      limitCopy:    '',
      goalId:       '',
      isEditMode:   false
    }
  },
  computed: {
    userId(): string {
      return this.$store.getters.userId;
    }
  },
  mounted() {
    this.selectGoalList();
  },
  watch: {
    // computed の userId の返り値が変わったら、データを取得する(初期アクセスのデータ取得遅延)
    userId() {
      this.selectGoalList();
    }
  },
  methods: {
    changeEditMode(goal: any, event): void {
      this.contentCopy = goal.content;
      this.limitCopy = goal.limit; 
      this.goalId = goal.id;
      this.isEditMode = true;
    },
    cancelEditMode(): void {
      this.isEditMode = false;
    },
    selectGoalList(): void {
      axios.get(api.goalsPath(this.userId))
        .then(response => {
          this.goalsList = Goal.createIndexDataBy(response.data);
        })
        .catch(error => {
          console.log(error.response);
        })
    },
    postCreate(): void {
      const params = {
        content: this.content,
        limit:   this.limit
      };
      axios.post(api.goalsPath(this.userId), params)
        .then(response => {
          console.log('created goal');
          const goal = new Goal();
          goal.setGoalData(response.data);
          this.goalsList.push(goal);
        })
        .catch(error => {
          console.log(error.response);
        })
    },
    patchUpdate(): void {
      const params = {
        content: this.contentCopy,
        limit:   this.limitCopy
      };
      axios.patch(api.goalPath(this.userId, this.goalId), params)
        .then(response => {
          this.isEditMode = false;
          this.selectGoalList();
        })
        .catch(error => {
          console.log(error.response);
        })
    },
    deleteDestroy(): void {
      axios.delete(api.goalPath(this.userId, this.goalId))
        .then(response => {
          this.isEditMode = false;
          this.selectGoalList();
        })
        .catch(error => {
          console.log(error.response);
        })
    }
  }
})
</script>

<style lang="scss" scoped>
  .new-goal {
    display: grid;
    gap: 5px;
    border: 1px solid rgb(101, 200, 123);
    padding: 10px;
  }
  .update-goal {
    margin-top: 10px;
    display: grid;
    gap: 5px;
    border: 1px solid rgb(184, 230, 35);
    padding: 10px;
  }
  .goal-item {
    border-bottom: 1px solid rgb(119, 110, 240);
  }
</style>