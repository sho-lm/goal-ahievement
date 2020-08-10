import Vue from 'vue';
import VueRouter from 'vue-router';
import LoginPage from '@/components/LoginPage.vue';
import UsersPage from '@/components/UsersPage.vue';
import GoalsPage from '@/components/GoalsPage.vue';
import WorkRecordsPage from '@/components/WorkRecordsPage.vue';
import DebugPage from '@/components/DebugPage.vue';

Vue.use(VueRouter);
export default new VueRouter({
  mode: 'history',
  routes: [
    {
      name: 'login',
      path: '/login',
      component: LoginPage
    },
    {
      name: 'users',
      path: '/users',
      component: UsersPage
    },
    {
      name: 'goals',
      path: '/goals',
      component: GoalsPage
    },
    {
      name: 'workRecords',
      path: '/work_records',
      component: WorkRecordsPage
    },
    {
      name: 'debug',
      path: '/debug',
      component: DebugPage
    }
  ]
})