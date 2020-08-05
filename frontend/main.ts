import Vue from 'vue';
import VueCompositionAPI from '@vue/composition-api'
import router from '~/router/router';
import VueAxios from 'vue-axios';
import axios from 'axios';
import store from '~/store/index';
import ElementUI from 'element-ui';
import locale from 'element-ui/lib/locale/lang/ja';
import 'element-ui/lib/theme-chalk/index.css';
import App from '~/App.vue';

Vue.use(VueCompositionAPI);
Vue.use(VueAxios, axios);
Vue.use(ElementUI, { locale });
Vue.config.devtools = true;

new Vue({
    el: '#app',
    router,
    store,
    components: { App },
    template: '<app />',
    created() {
        store.dispatch('restoreSession');
    }
});
