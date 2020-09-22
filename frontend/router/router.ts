import Vue from 'vue';
import VueRouter, { RouteConfig } from 'vue-router';
import store from '@/store/index';
import Login from '@/components/pages/Login.vue';
import SignUp from '@/components/pages/SignUp.vue';
import Users from '@/components/pages/Users.vue';
import Goals from '@/components/pages/Goals.vue';
import WorkRecords from '@/components/pages/WorkRecords.vue';
import Reports from '@/components/pages/Reports.vue';
import Debug from '@/components/pages/Debug.vue';

Vue.use(VueRouter);
export const routes: Array<RouteConfig> = [
  {
    name: 'login',
    path: '/login',
    component: Login,
    // ログイン済みならユーザー画面を表示する
    meta: {
      icon: 'home',   // vuetify v-icon
      background: '#f9f9f9',  // background-color of main in App.vue
      requiresLogin: false,  // アクセスするにはログインが必要か
    },
    beforeEnter: (to, from, next) => {
      if (store.getters.auth.id && store.getters.auth.token) {
        next({ name: 'users' });
      } else {
        next();
      }
    },
  },
  {
    name: 'signUp',
    path: '/sign_up', // rails に合わせるのでスネークケース
    component: SignUp,
    meta: {
      icon: 'home',
      background: '#fff',
      requiresLogin: false,
    },
    beforeEnter: (to, from, next) => {
      if (store.getters.auth.id && store.getters.auth.token) {
        next({ name: 'users' });
      } else {
        next();
      }
    },
  },
  {
    name: 'users',
    path: '/users',
    component: Users,
    meta: {
      icon:           'account_circle',
      background:     '#fff',
      requiresLogin:  true,
      text:           'プロフィール'
    }
  },
  {
    name: 'goals',
    path: '/goals',
    component: Goals,
    meta: {
      icon:           'assignment',
      background:     '#fff',
      requiresLogin:  true,
      text:           '目標を決める'
    }
  },
  {
    name: 'workRecords',
    path: '/work_records',
    component: WorkRecords,
    meta: {
      icon:           'create',
      background:     '#fff',
      requiresLogin:  true,
      text:           '記録をつける'
    }
  },
  {
    name: 'reports',
    path: '/reports',
    component: Reports,
    meta: {
      icon:           'bar_chart',
      background:     '#fff',
      requiresLogin:  true,
      text:           'グラフで見る'
    }
  },
  {
    name: 'debug',
    path: '/debug',
    component: Debug,
    meta: {
      icon: 'info',
      background: '#fff',
      requiresLogin: true,
      text: 'debug'
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
    && !store.getters.auth.id
    && !store.getters.auth.token) {
    next({ name: 'login', query: { redirect: to.name } });
  } else {
    next();
  }
});
