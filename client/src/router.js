import { createRouter, createWebHistory } from 'vue-router';
import DatePicker from './components/datepicker.vue';
import FoodWeight from './components/food&weight.vue';
import DayStat from './components/daystat.vue';
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
      components: {
        default: FoodWeight,
        DatePicker,
        DayStat
      }
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