import Vue from 'vue';
import Vuex from 'vuex';
import createPersistedState from "vuex-persistedstate";
import { auth } from '@/store/modules/auth';
import { goals } from '@/store/modules/goals';
import { reports } from '@/store/modules/reports';
import { snackbar } from '@/store/modules/snackbar';
import axios from 'axios';
import { api } from '@/config/api'
import { User } from '@/models/user';

Vue.use(Vuex);

export default new Vuex.Store({
  modules: {
    auth,
    goals,
    reports,
    snackbar,
  },
  state: {
    user: new User(),
    isLoggedIn: false,
  },
  getters: {
    user: (state): User => state.user,
    isLoggedIn: (state): boolean => state.isLoggedIn,
  },
  mutations: {
    setUser(state, userData): void {
      state.user.setUserData(userData);
    },
    isLoggedIn(state, isLoggedIn: boolean): void {
      state.isLoggedIn = isLoggedIn;
    }
  },
  actions: {
    restoreSession(context): void {
      axios.post(api.authPath, context.getters.auth)
        .then(response => {
          context.dispatch('saveSession', response.data);
          console.log('authenticated');
          context.dispatch('selectGoalList');
        })
        .catch(error => {
          console.log(error);
        })
    },
    saveSession(context, userData): void {
      context.commit('setUser', userData);
      const auth = {
        id: context.getters.user.id,
        token: context.getters.user.token
      }
      context.commit('setAuth', auth);
      context.commit('isLoggedIn', true);
    },
    discardSession(context): void {
      context.commit('setUser', {});
      context.dispatch('discardAuth');
      context.commit('isLoggedIn', false);
    },
  },
  plugins: [createPersistedState({
    key: 'goal-achievement',
    paths: ['auth'],
    rehydrated: (store: any): void => store.dispatch('restoreSession'),
  }),
  ]
})
