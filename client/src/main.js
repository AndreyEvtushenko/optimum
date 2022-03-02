import { createApp } from 'vue';
import App from './App.vue';
import { createPinia } from 'pinia';

const vueApp = createApp(App);
vueApp.use(createPinia());
vueApp.mount('#app');