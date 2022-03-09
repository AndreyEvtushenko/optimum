import { createApp } from 'vue';
import App from './App.vue';
import { createPinia } from 'pinia';
import router from './router.js';

const vueApp = createApp(App);
vueApp.use(createPinia());
vueApp.use(router);
vueApp.mount('#app');