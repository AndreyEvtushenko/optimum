<script setup>
import { ref, computed, watch, onUpdated } from 'vue';
import useStore from '../stores/products.js';
import request from '../libs/requests.js';

const store = useStore();
const showButtonText = ref('Show products');
const productFilterInputRef = ref(null);
const resultMessage = ref('');
const pseudos = ['Kcal', 'Prots', 'Fats', 'Carbs'];

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
  /* const list = document.getElementById('list-elem');
  if(list) {
    const scrollHeight = list.scrollHeight;
    list.scrollTop = scrollHeight;
  } */
  const scrollHeight = document.body.scrollHeight;
  scrollTo(0, scrollHeight);
}

function makeNutrValuesPer100(products) {
  for(let product of products) {
    for(let key in product) {
      if(key == 'id' || key == 'name')
        continue;
      const newKey = key.replace('_1', '');
      product[newKey] = +(product[key] * 100).toFixed(2);
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
  <div class="product-list-buttons">
    <button @click="getProducts">
      {{ showButtonText }}
    </button>
    <button @click="scrollToBottom">
      Scroll to bottom
    </button>
  </div>  
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
      <span class="nutr-value-header" 
        v-for="item in pseudos">
        {{ item }}
      </span>
    </div>
    <p v-if="filteredProductsListIsEmpty">
      No such products
    </p>
    <div class="list" v-else>
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
  .product-list-buttons {
    position: fixed;
    top: 235px;
    width: 800px;
    left: 50%;
    transform: translate(-50%, 0);
    padding-top: 10px;
    padding-bottom: 10px;
    padding-left: 20px;
    background-color: white;
  }
  .product-list-buttons button {
    height: 30px;
    width: 130px;
    margin-right: 5px;
  }
  .products {
    width: 800px;
    /* padding-top: 10px; */
    margin: 0 auto;
    padding-left: 20px;
    margin-bottom: 65px;
  }
  .products span {
    width: 60px;
  }
  .products .header {
    position: fixed;
    top: 285px;
    width: 800px;
    padding-top: 5px;
    padding-bottom: 7px;
    background-color: white;
  }
  .products .list {
    margin-top: 330px;
  }
  .products .header span {
    font-weight: bold;
  }
  span.product-name {
    width: 440px;
  }
  .product-name .filter {
    width: 420px;
  }
  .products .product {
    margin-top: 3px;
  }
  .list button {
    margin-right: 2px;
  }
</style>