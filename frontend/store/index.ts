import Vue from 'vue';
import Vuex from 'vuex';
import axios from 'axios';
import { api } from '@/config/api'
import { User } from '@/models/user';

Vue.use(Vuex);

interface AuthParams  {
  id:     string
  token:  string
}

interface LoginParams {
  account_id: string
  password:   string
}

const keyUserId = 'userId';
const keyUserToken = 'userToken';

export default new Vuex.Store({
  state: {
    user: new User(),
    isLoggedIn: false
  },
  getters: {
    user: (state): User => state.user,
    userId: (state): string => state.user.id,
    userToken: (state): string => state.user.token,
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
    login(context, params: LoginParams): void {
      axios.post(api.loginPath, params)
        .then(response => {
          context.dispatch('saveSession', response.data);
          console.log('log in');
        })
        .catch(error => {
          console.log(error);
        })
    },
    logout(context) {
      axios.delete(api.logoutPath)
        .then(response => {
          context.dispatch('discardSession');
          console.log('log out');
        })
        .catch(error => {
          console.log(error);
        })
    },
    restoreSession(context): void {
      const userId = localStorage.getItem(keyUserId);
      const userToken = localStorage.getItem(keyUserToken);
      if (userId && userToken) {
        const params = {
          id: userId,
          token: userToken
        }
        axios.post(api.authPath, params)
        .then(response => {
          context.dispatch('saveSession', response.data);
          console.log('authenticated');
        })
        .catch(error => {
          console.log(error);
        })
      }
    },
    saveSession(context, userData): void {
      context.commit('setUser', userData);
      localStorage.setItem(keyUserId, context.getters.userId);
      localStorage.setItem(keyUserToken, context.getters.userToken);
      context.commit('isLoggedIn', true);
    },
    discardSession(context): void {
      localStorage.removeItem(keyUserId);
      localStorage.removeItem(keyUserToken);
      context.commit('isLoggedIn', false);
      context.commit('setUser', {});
    },
  },
})
