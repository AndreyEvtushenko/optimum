<script setup>
import { ref, onMounted, computed, reactive, watch } from 'vue';
import useStore from '../stores/products.js';
import request from '../libs/requests.js';

const store = useStore();

const productNameInputRef = ref(null);
const productNameInput = ref('');
const nutrValueInputs = reactive({
  kcal: '',
  proteins: '',
  fats: '',
  carbohydrates: ''
});
let productChanges = {};
const pseudos = ['Kcal', 'Prots', 'Fats', 'Carbs'];
const submitButtonText = ref('Submit');
const clearButtonText = ref('Clean');
const resultMessage = ref('');

onMounted(() => {
  productNameInputRef.value.focus();

  const href = document.getElementById('prod-link');
  href.classList.add('current');

  store.editProductFlag = false;
});

watch(() => resultMessage.value, 
  (newValue) => {
  if(newValue)
    setTimeout(() => resultMessage.value = '', 2000);
});

watch(() => store.editProductFlag,
  (newValue) => {
    if(!newValue) {
      submitButtonText.value = 'Submit';
      clearButtonText.value = 'Clean';
      return;
    }
    fillInputsForEdit();
    submitButtonText.value = 'Save';
    clearButtonText.value = 'Cancel';
});

const product = computed(() => {
  const obj = {
    name: productNameInput.value,
    date: new Date().toDateString()
  }
  for(let key in nutrValueInputs) {
    obj[key + '_1'] = nutrValueInputs[key] / 100;
  }
  return obj;
});

function fillInputsForEdit() {
  productNameInput.value = store.editableProduct.name;
  for(let key in nutrValueInputs) {
    nutrValueInputs[key] = store.editableProduct[key];
  }
}

function validateNutrInput(key, prevInput) {
  let input = nutrValueInputs[key];
  input = processInputLength(key, input, prevInput);

  if(isNaN(parseFloat(input))) {
    nutrValueInputs[key] = '';
    return;
  }
  //case 123..
  if(checkTwoDots(input))
    input = prevInput;
  //case 12.
  if(lastSymbolDot(input)) {
    input = processLastSymbolDot(input, prevInput);
  } else {
    input = processLastSymbolNotDot(input);
  }

  input = processMaxValue(key, input);
  nutrValueInputs[key] = input;
}

function processInputLength(key, input, prevInput) {
  if(key == 'kcal' && input.length > 6) {
    //we will need length property in further
    prevInput = prevInput.toString();
    return prevInput;
  } else if(key != 'kcal' && input.length > 5) {
    prevInput = prevInput.toString();
    return prevInput;
  } else
    return input;
}

function checkTwoDots(input) {
  let dotCount = 0;
  let dotPos = -1;
  while((dotPos = input.indexOf('.', dotPos + 1)) != -1) {
    dotCount++;
  }
  if(dotCount > 1)
    return true;
  return false;
}

function lastSymbolDot(input) {
  const last = input.length - 1;
  if(input[last] == '.')
    return true;
  return false;
}

function processLastSymbolDot(input, prevInput) {
  prevInput = prevInput.toString();
  //prevent 12.3. case when using backspace
  if(prevInput.length < input.length)
    input = parseFloat(prevInput);
  else
    input = parseFloat(input);
    //case 100. when exceeding max value
    if(input < 100)
      input += '.';
  return input;
}

function processLastSymbolNotDot(input) {
  //process case 12.a
  let initial = input.length;
  input = parseFloat(input);
  let parsed = input.toString().length;
  if(initial - parsed > 1)
    input += '.';
  return input;
}

function processMaxValue(key, input) {
  if(key == 'kcal' && input > 999.99) {
    return 999.99;
  } else if(key != 'kcal' && input > 100) {
    return 100;
  } else
    return input;
}

async function submitProduct() {
  if(!providedInfoIsEnough())
    return;
  if(store.editProductFlag) {
    editProduct();
  } else {
    addProduct();
  }  
}

function providedInfoIsEnough() {
  if(productNameInput.value == '' || 
    product.value.kcal_1 == 0) {
      resultMessage.value = 'Not enough information provided';
      return false;
    }
  return true;
}

async function editProduct() {
  //productChanges is filled here
  if(!detectProductChanges()) {
    resultMessage.value = 'No changes were made';
    return;
  }
  const success = await sendEditedProduct();
  if(success) {
    resultMessage.value = 'Changes saved';
    updateProductList();
    cleanEdit();
    clearInput();
  } else {
    resultMessage.value = 'Changes weren\'t saved';
  }
}

function detectProductChanges() {
  let anyChanges = false;
  if(productNameInput.value != store.editableProduct.name) {
    anyChanges = true;
    productChanges.name = productNameInput.value;
  }
  for(let key in nutrValueInputs) {
    if(nutrValueInputs[key] != store.editableProduct[key]) {
      anyChanges = true;
      productChanges[key] = nutrValueInputs[key].toFixed(2);
    }    
  }
  return anyChanges;
}

function sendEditedProduct() {
  const id = store.editableProduct.id;
  const URL = `/api/product/${id}`;
  return request.patch(URL, product.value);
}

function updateProductList() {
  Object.assign(store.editableProduct, productChanges);
}

function cleanEdit() {
  productChanges = {};
  store.editableProduct = {};
  store.editProductFlag = false;
}

function clearInput() {
  productNameInput.value = '';
  for(let key in nutrValueInputs)
    nutrValueInputs[key] = '';
}

async function addProduct() {
  const product_id = await sendNewProduct();
  if(product_id > 0) {
    resultMessage.value = 'Product was added';
    addProductToList(product_id);
    clearInput();
  } else {
    resultMessage.value = 'Product wasn\'t added';
  }
}

function sendNewProduct() {
  const URL = '/api/product';
  return request.post(URL, product.value);
}

function addProductToList(product_id) {
  const productItem = prepareProductListItem(product_id);
  store.products.push(productItem);
  store.scrollToBottomFlag = true;
}

function prepareProductListItem(product_id) {
  const productItem = {
    id: product_id,
    name: productNameInput.value
  }
  for(let key in nutrValueInputs) {
    productItem[key] = (+nutrValueInputs[key]).toFixed(2);
  }
  return productItem;
}

function cancelOperation() {
  if(store.editProductFlag) {
    cleanEdit();
  }
  clearInput();
}
</script>

<template>
  <div class="product-form">
    <div class="header">
      <span class="indent"></span>
      <span class="nutr-value-header" 
        v-for="item in pseudos">
        {{ item }}
      </span>
    </div>
    <input class="name" type="text"
      ref="productNameInputRef"
      placeholder="product name"
      maxlength="64"
      v-model="productNameInput">
    <input class="nutr-value-input" type="text"
      v-for="(value, key) in nutrValueInputs"
      @input="validateNutrInput(key, value)"
      v-model="nutrValueInputs[key]">
    <div class="form-buttons">
      <button @click="submitProduct">
        {{ submitButtonText }}
      </button>
      <button @click="cancelOperation">
        {{ clearButtonText }}
      </button>
    </div>
    <p class="result-message">
      {{ resultMessage }}
    </p>
    <hr>
  </div>
</template>

<style>
  .product-form {
    width: 800px;
    position: fixed;
    top: 62px;
    padding-top: 8px;
    padding-left: 26px;
    padding-right: 26px;
    left: 50%;
    transform: translate(-50%, 0);
    background-color: white;
  }
  .product-form .indent {
    width: 425px;
    margin-left: 30px;
  }
  .nutr-value-header {
    width: 79px;
  }
  .product-form .name {
    margin-left: 30px;
  }
  .nutr-value-input {
    width: 60px;
  }  
  .result-message {
    height: 20px;
  }
</style>