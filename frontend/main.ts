import Vue from 'vue';
import router from './router/router';
import VueAxios from 'vue-axios';
import axios from 'axios';
import ElementUI from 'element-ui';
import locale from 'element-ui/lib/locale/lang/ja';
import 'element-ui/lib/theme-chalk/index.css';
import App from './App.vue';

Vue.config.devtools = false;
Vue.use(VueAxios, axios);
Vue.use(ElementUI, { locale });

new Vue({
    el: '#app',
    router,
    components: { App },
    template: '<app />',
});
