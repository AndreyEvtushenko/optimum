import { createRouter, createWebHistory } from 'vue-router';
import Main from './components/main.vue';
import ProductForm from './components/productform.vue';
import ProductList from './components/productlist.vue';

export default createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: '/',
      component: Main
    },
    {
      path: '/products',
      components: {
        default: ProductForm,
        ProductList
      }
    }
  ]
});