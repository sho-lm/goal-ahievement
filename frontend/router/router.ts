import Vue from 'vue';
import VueRouter from 'vue-router';
import Login from '~/pages/sessions/Login.vue';
import Goals from '~/pages/goals/Goals.vue';
import WorkRecords from '~/pages/workRecords/WorkRecords.vue';
import UsersList from '~/pages/debug/UsersList.vue';

Vue.use(VueRouter);

export default new VueRouter({
  // mode: 'history',
  routes: [
    {
      name: 'login',
      path: '/login',
      component: Login
    },
    {
      name: 'goals',
      path: '/goals',
      component: Goals
    },
    {
      name: 'workRecords',
      path: '/workRecords',
      component: WorkRecords
    },
    {
      name: 'usersList',
      path: '/usersList',
      component: UsersList
    }
  ]
})