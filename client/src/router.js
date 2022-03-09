import { createRouter, createWebHistory } from 'vue-router';
import Main from './components/main.vue';
import Addproduct from './components/addproduct.vue';

export default createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: '/',
      component: Main
    },
    {
      path: '/addproduct',
      component: Addproduct
    }
  ]
});