import Vue from 'vue';
// import Vuex, { LocalContext, LocalGetters, RootState, RootGetters } from 'vuex'

export const state = () => ({
  counter: 0
})

export const mutations = {
  increment(state: any) {
    state.counter++;
  }
}
