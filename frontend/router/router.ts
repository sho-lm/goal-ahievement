import Vue from 'vue';
import VueRouter, { RouteConfig } from 'vue-router';
import store from '@/store/index';
import Login from '@/components/pages/Login.vue';
import SignUp from '@/components/pages/SignUp.vue';
import Users from '@/components/pages/Users.vue';
import Goals from '@/components/pages/Goals.vue';
import WorkRecords from '@/components/pages/WorkRecords.vue';
import Debug from '@/components/pages/Debug.vue';

Vue.use(VueRouter);
export const routes: Array<RouteConfig> = [
  {
    name: 'login',
    path: '/login',
    component: Login,
    meta: {
      icon: 'home',   // vuetify v-icon
      background: '#f9f9f9'  // background-color of main in App.vue
    }
  },
  {
    name: 'signUp',
    path: '/sign_up', // rails に合わせるのでスネークケース
    component: SignUp,
    meta: {
      icon: 'home',
      background: '#fff'
    }
  },
  {
    name: 'users',
    path: '/users',
    component: Users,
    meta: {
      icon: 'account_circle',
      background: '#fff'
    }
  },
  {
    name: 'goals',
    path: '/goals',
    component: Goals,
    meta: {
      icon: 'assignment',
      background: '#fff'
    }
  },
  {
    name: 'workRecords',
    path: '/work_records',
    component: WorkRecords,
    meta: {
      icon: 'work',
      background: '#fff'
    }
  },
  {
    name: 'debug',
    path: '/debug',
    component: Debug,
    meta: {
      icon: 'info',
      background: '#fff'
    }
  }
]
export const router = new VueRouter({
  mode: 'history',
  routes
})

router.beforeEach((to, from, next) => {
  if(to.name !== 'login'
    && to.name !== 'signUp'
    && !store.getters.isLoggedIn) {
    next({ name: 'login' });
  } else {
    next();
  }
});