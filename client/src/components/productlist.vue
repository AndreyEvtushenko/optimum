<script setup>
import { ref, computed, watch, onUpdated } from 'vue';
import useStore from '../stores/products.js';
import request from '../libs/requests.js';

const store = useStore();
const showButtonText = ref('Show products');
const productFilterInputRef = ref(null);
const resultMessage = ref('');

const productListIsEmpty = computed(() => {
  if(store.products.length)
    return false;
  return true;
});

const filteredProductsListIsEmpty = computed(() => {
  if(store.filteredProducts.length)
    return false;
  return true;
});

watch(productListIsEmpty, (newValue) => {
  if(!newValue)
    showButtonText.value = 'Reload';   
  else
    showButtonText.value = 'Show products';
});

watch(productFilterInputRef, (newValue) => {
  if(newValue)
    productFilterInputRef.value.focus();
});

watch(() => store.productFilter.length,
  (newValue) => {
    if(newValue > 1 && store.filteredProducts.length == 0)
      resultMessage.value = 'No such product';
});

watch(resultMessage, (newValue) => {
  if(newValue)
    setTimeout(() => resultMessage.value = '', 2000);
});

//we need scroll to bottom after vue will update DOM
//because only then there will be right ScrollHeight value
onUpdated(() => {
  if(store.scrollToBottomFlag)
    scrollToBottom();
    store.scrollToBottomFlag = false;
});

async function getProducts() {
  const products = await request.get('/api/products');
  if(products.length) {
    store.products = makeNutrValuesPer100(products);
  } else {
    resultMessage.value = 'There are no products';
  }
}

function scrollToBottom() {
  const list = document.getElementById('list-elem');
  if(list) {
    const scrollHeight = list.scrollHeight;
    list.scrollTop = scrollHeight;
  }
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

async function deleteProduct(product) {
  if(!confirm('Do you really want delete it?'))
    return;
  const id = product.id;
  const URL = `/api/product/${id}`;
  const result = await request.delete(URL);
  
  if(result == 'ER_ROW_IS_REFERENCED') {
    alert('Can\'t be deleted due to presence ' + 
    'as ingridient or in eaten food');
  // number of affected Rows
  } else if (result == 1) {
    deleteFromList(product);
  }
}

function deleteFromList(deletedProduct) {
  store.products = store.products.filter(
    product => product != deletedProduct
  );
}
</script>

<template>
  <button @click="getProducts">
    {{ showButtonText }}
  </button>
  <button @click="scrollToBottom">
    Scroll to bottom
  </button>
  <p v-if="productListIsEmpty">
    {{ resultMessage }}
  </p>
  <div class="products" v-else>
    <div class="header">
      <span class="product-name">
        <input class="filter" type="text"
          ref="productFilterInputRef"
          placeholder="filter..."
          v-model="store.productFilter">
      </span>
      <span>Kcal</span>
      <span>Prots.</span>
      <span>Fats</span>
      <span>Carbs.</span>
    </div>
    <p v-if="filteredProductsListIsEmpty">
      No such products
    </p>
    <div id="list-elem" class="list" v-else>
      <div class="product"
        v-for="product in store.filteredProducts"
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
        <button @click="deleteProduct(product)">
          Delete
        </button>
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
  .product-name .filter {
    width: 430px;
  }
  .products .list {
    height: 550px;
    overflow-x: auto;
  }
  .list .product {
    padding: 3px 0;
  }
</style>