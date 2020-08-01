import Vue from 'vue';
import VueRouter from 'vue-router';
import router from './router';
import VueAxios from 'vue-axios';
import axios from 'axios';
import ElementUI from 'element-ui';
import locale from 'element-ui/lib/locale/lang/ja';
import 'element-ui/lib/theme-chalk/index.css';
import App from './App.vue';

Vue.config.devtools = true;
Vue.use(VueRouter);
Vue.use(VueAxios, axios);
Vue.use(ElementUI, { locale });

new Vue({
    el: '#app',
    router: router,
    components: { App },
    template: '<app />',
});
