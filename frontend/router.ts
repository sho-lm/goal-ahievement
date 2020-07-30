import VueRouter from 'vue-router';
import Users from './pages/users/Users.vue'
import Goals from './pages/goals/Goals.vue';
import WorkRecords from './pages/workRecords/WorkRecords.vue';

export default new VueRouter({
  // mode: 'history',
  routes: [
    {
      name: 'home',
      path: '/home',
    },
    {
      name: 'users',
      path: '/users',
      component: Users
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
    }
  ]
})