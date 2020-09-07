import axios from 'axios';
import { api } from '@/config/api'
import { Goal } from '@/models/goal';


export const goals = {
  state: {
    goalList: [ new Goal() ],
  },
  getters: {
    goalList: (state: any): Array<Goal> => state.goalList,
  },
  mutations: {
    setGoalList(state: any, goalListDate: Array<any>): void {
      state.goalList = Goal.createIndexDataBy(goalListDate);
    },
    updateGoal(state: any, updatedGoal: Goal ): void {
      const targetGoal = state.goalList.find(
        (goal: Goal) => goal.id == updatedGoal.id); 
      targetGoal.content = updatedGoal.content;
      targetGoal.color = updatedGoal.color;
      targetGoal.is_finished = updatedGoal.is_finished;
    },
    addGoal(state: any, newGoal: Goal): void {
      state.goalList.unshift(newGoal);
    }
  },
  actions: {
    selectGoalList(context: any): void {
      axios.get(api.goalsPath(context.getters.userId))
        .then(response => {
          context.commit('setGoalList', response.data);
        })
        .catch(error => {
          console.log(error.response);
        })
    },
  }
}
