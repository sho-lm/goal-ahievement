import Vue from 'vue';
import VueCompositionAPI from '@vue/composition-api'
import router from '~/router/router';
import VueAxios from 'vue-axios';
import axios from 'axios';
import store from '~/store/index';
import App from '~/App.vue';

// for design
import { MdButton, MdContent, MdTabs } from 'vue-material/dist/components'
import 'vue-material/dist/vue-material.min.css'
import 'vue-material/dist/theme/default.css'

Vue.use(VueCompositionAPI);
Vue.use(VueAxios, axios);
Vue.use(MdButton);
Vue.use(MdContent);
Vue.use(MdTabs);
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
