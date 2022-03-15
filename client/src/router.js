import { createRouter, createWebHistory } from 'vue-router';
import Main from './components/main.vue';
import AddProduct from './components/addproduct.vue';
import ProductList from './components/productlist.vue';

export default createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: '/',
      component: Main
    },
    {
      path: '/addproduct',
      components: {
        default: AddProduct,
        ProductList
      }
    }
  ]
});