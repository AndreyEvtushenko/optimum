<script setup>
import { ref, onMounted, computed, reactive, watch } from 'vue';
import request from '../libs/requests.js';

const productNameInputRef = ref(null);
const productNameInput = ref('');
const productAddedFlag = ref(false);
const notEnoughInfoFlag = ref(false);
const energyValueInputs = reactive({
  kcal: '',
  proteins: '',
  fats: '',
  carbohydrates: ''
});
const pseudos = ['Kcal', 'Prots', 'Fats', 'Carbs'];

onMounted(() => {
  productNameInputRef.value.focus();
});

watch(productAddedFlag, (newValue) => {
  if(newValue)
    setTimeout(() => productAddedFlag.value = false, 2000);
});

watch(notEnoughInfoFlag, (newValue) => {
  if(newValue)
    setTimeout(() => notEnoughInfoFlag.value = false, 2000);
});

const product = computed(() => {
  const obj = {
    name: productNameInput.value,
  }
  for(let key in energyValueInputs) {
    obj[key + '_1'] = energyValueInputs[key] / 100;
  }
  return obj;
});

function validateInput(key, prevInput) {
  let input = energyValueInputs[key];
  input = processInputLength(key, input, prevInput);

  if(isNaN(parseFloat(input))) {
    energyValueInputs[key] = '';
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
  energyValueInputs[key] = input;
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
  if(!providedInfoIsEnought())
    return;
  const URL = '/api/product';
  productAddedFlag.value = await request.post(URL, product.value);
  clearInput();
}

function providedInfoIsEnought() {
  if(productNameInput.value == '' || 
    product.value.kcal_1 == 0) {
      notEnoughInfoFlag.value = true;
      return false;
    }
  return true;
}

function clearInput() {
  productNameInput.value = '';
  for(let key in energyValueInputs)
    energyValueInputs[key] = '';
}
</script>

<template>
  <input class="product-name" type="text"
    ref="productNameInputRef"
    placeholder="product name"
    v-model="productNameInput"
    @input="process">
  <div class="energy-value-input"
    v-for="(value, key, index) in energyValueInputs">
    <p>{{ pseudos[index] }}:</p>
    <input type="text"
      @input="validateInput(key, value)"
      v-model="energyValueInputs[key]">
  </div>
  <button @click="submitProduct">
    Submit
  </button>
  <p v-if="productAddedFlag">
    Product was added
  </p>
  <p v-if="notEnoughInfoFlag">
    Not enough information provided
  </p>
  <hr>
</template>

<style>
  input.product-name {
    width: 400px;
    margin: 5px;
  }
  .energy-value-input p {
    display: inline-block;
    width: 50px;
    margin: 5px;
  }
  .energy-value-input input {
    width: 50px;
  }
</style>