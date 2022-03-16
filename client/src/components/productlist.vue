<script setup>
import { computed } from 'vue';
import useStore from '../stores/products.js';
import request from '../libs/requests.js';

const store = useStore();

const productListNotEmpty = computed(() => {
  if(store.products.length)
    return true;
  return false;
});

async function getProducts() {
  const products = await request.get('/api/products');
  store.products = makeNutrValuesPer100(products);
}

function makeNutrValuesPer100(products) {
  for(let product of products) {
    for(let key in product) {
      if(key == 'id' || key == 'name')
        continue;
      const newKey = key.replace('_1', '');
      product[newKey] = (product[key] * 100).toFixed(2);
      delete product[key];
    }
  }
  return products;
}

function editProduct(product) {
  store.editableProduct = product;
  store.editProductFlag = true;
}
</script>

<template>
  <button @click="getProducts">
    Show products
  </button>
  <div class="products"
    v-if="productListNotEmpty">
    <div class="header">
      <span class="product-name"></span>
      <span>Kcal</span>
      <span>Prots.</span>
      <span>Fats</span>
      <span>Carbs.</span>
    </div>
    <div class="list">
      <div class="product"
        v-for="product in store.products"
        :key="product.food_id">
        <span class="product-name">
          {{ product.name }}
        </span>
        <span>{{ product.kcal }}</span>
        <span>{{ product.proteins }}</span>
        <span>{{ product.fats }}</span>
        <span>{{ product.carbohydrates }}</span>
        <button @click="editProduct(product)">
          Edit
        </button>
        <button>Delete</button>
      </div>
    </div>
  </div>
</template>

<style>
  .products {
    margin: 10px;
  }
  .products span {
    display: inline-block;
    width: 60px;
  }
  .products .header {
    padding: 5px 0;
  }
  span.product-name {
    width: 450px;
  }
  .products .list {
    height: 550px;
    overflow-x: auto;
  }
  .list .product {
    padding: 3px 0;
  }
</style>