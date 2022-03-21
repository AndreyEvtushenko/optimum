import { defineStore } from 'pinia';

export default defineStore('productsId', {
  state() {
    return {
      products: [],
      productFilter: '',
      editableProduct: {},
      editProductFlag: false,
      scrollToBottomFlag: false
    }
  },

  getters: {
    filteredProducts() {
      if(this.productFilter.length > 1) {
        return this.products.filter(product => {
          const name = product.name.toLowerCase();
          const filter = this.productFilter.toLocaleLowerCase();
          return name.includes(filter);
        });
      }
      return this.products;
    }
  }
});