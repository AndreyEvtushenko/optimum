import { defineStore } from 'pinia';

export default defineStore('productsId', {
  state() {
    return {
      products: [],
      editableProduct: {},
      editProductFlag: false
    }
  },
});