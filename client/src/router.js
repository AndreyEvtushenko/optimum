import { createRouter, createWebHistory } from 'vue-router';
import Main from './components/main.vue';
import ProductForm from './components/productform.vue';
import ProductList from './components/productlist.vue';
import DishForm from './components/dishform.vue';
import DishList from './components/dishlist.vue';

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
      path: '/dishes',
      components: {
        default: DishForm,
        DishList
      }
    }
  ]
});