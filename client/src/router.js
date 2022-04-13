import { createRouter, createWebHistory } from 'vue-router';
import Main from './components/main.vue';
import ProductForm from './components/productform.vue';
import ProductList from './components/productlist.vue';
import CookedList from './components/cookedlist.vue';
import CookedForm from './components/cookedform.vue';
import Total from './components/total.vue';

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
    },
    {
      path: '/cooked',
      components: {
        default: CookedForm,
        CookedList
      }
    },
    {
      path: '/total',
      component: Total
    }
  ]
});