import Vue from 'vue';
import VueCompositionAPI from '@vue/composition-api'
import { router } from '@/router/router';
import VueAxios from 'vue-axios';
import axios from 'axios';
import store from '@/store/index';
import App from '@/App.vue';

// for design
import { vuetify, VForm } from '@/plugins/vuetify';

Vue.use(VueCompositionAPI);
Vue.use(VueAxios, axios);
Vue.config.devtools = true;

new Vue({
    el: '#app',
    router,
    store,
    vuetify,
    components: { App },
    template: '<app />',
});
