<script setup>
import { reactive, ref, watch, computed, onMounted } from 'vue';
import useStore from '../stores/cooked.js';
import request from '../libs/requests.js';
import { validateWeightInput } from '../libs/common.js';
import { getCookedObjForSending, getIngrsForSending, nutrValues100 } 
  from '../libs/cookedform.js';
import editCookedAndIngrs from '../libs/editcookedandingrs.js';
import IngridientForm from './ingridientform.vue';

const store = useStore();
const cooked = reactive({
  id: '',
  name: '',
  weight: '',
  nutrValues1: [],
  date: new Date().toDateString()
});
// ingridients item props:
// { id, listId, name, weight, nutrValues1: Object, nutrValuesW: Array }
const ingridients = reactive(new Set());

const pseudos = ['Kcal', 'Prots', 'Fats', 'Carbs'];
const showDeleteButton = [false];
const submitButtonText = ref('Submit');
const clearButtonText = ref('Clean');
//base value for ingridients list ids
let index = 0;

const resultMessage = ref('');
watch(resultMessage, (newValue) => {
  if(newValue)
    setTimeout(() => resultMessage.value = '', 2000);
});

onMounted(() => {
  addNewIngrToSet();
});

const ingridientsIds = computed(() => {
  const chosenIds = [];
  for(let ingridient of ingridients) {
    if(ingridient.id && ingridient.id !== null) {
      chosenIds.push(ingridient.id);
    }
  }
  return chosenIds;
});

const newFormCanBeAdded = computed(() => {
  if(ingridientsCapReached.value) 
    return false;
  for(let ingridient of ingridients) {
    if(ingridient.name == '' || ingridient.weight == '') {
      return false;
    } else if(!ingridient.id) {
      return false;
    }
  }
  return true;
});

const ingridientsCapReached = computed(() => {
  if(ingridients.size == 20)
    return true;
  return false;
});

const cookedNutrValues1 = computed(() => {
  const nutrValuesSum = getNutrValuesSum();

  if(nutrValuesAreZero(nutrValuesSum) || cooked.weight == '') {
    return false;
  }
  
  return nutrValuesSum.map(item => +(item /= cooked.weight).toFixed(4));
});

const cookedNutrValues100 = computed(() => {
  if(!cookedNutrValues1.value)
    return ['-', '-', '-', '-'];
  return nutrValues100(cookedNutrValues1.value);
});

watch(() => ingridients.size,
  (newValue, oldValue) => {
    if(newValue > oldValue && newValue != 1)
      showDeleteButton.unshift(true);
    else if (newValue < oldValue)
      showDeleteButton.shift();
});

watch(cookedNutrValues1, (newValue) => {
  if(!newValue) {
    cooked.nutrValues1 = [];
  } else {
    cooked.nutrValues1 = newValue;
  }
});

watch(() => store.editCookedFlag,
  (newValue) => {
    if(!newValue) {
      submitButtonText.value = 'Submit';
      clearButtonText.value = 'Clean';
      return;
    }
    fillFormForEditing();
    submitButtonText.value = 'Save changes';
    clearButtonText.value = 'Cancel';
});

watch(() => store.baseCookedFlag,
  (newValue) => {
    if(newValue) {
      fillFormForEditing(true);
      store.baseCookedFlag = false;
    }
});

function addNewIngrToSet() {
  ingridients.add({
    listId: index++
  });
}

function getNutrValuesSum() {
  const nutrValuesSum = [0, 0, 0, 0];
  for(let ingridient of ingridients) {
    if(!ingridient.nutrValuesW) {
      continue;
    }
    for(let index = 0; index < 4; index++) {
      nutrValuesSum[index] += ingridient.nutrValuesW[index];
    }
  }
  return nutrValuesSum;
}

function nutrValuesAreZero(nutrValues) {
  let zero = false;
  for(let value of nutrValues) {
    if(value == 0) {
      zero = true;
    }
  }
  return zero;
}

function fillFormForEditing(useAsBase = false) {
  if(!useAsBase) {
    cooked.id = store.editableCooked.id;
  }  
  cooked.name = store.editableCooked.name;
  cooked.weight = store.editableCooked.weight;

  fillIngrsForEditing();
}

function fillIngrsForEditing() {
  ingridients.clear();
  for(let editable of store.editableCooked.ingridients) {
    ingridients.add({
      listId: index++,
      id: editable.id,
      name: editable.name,
      weight: editable.weight,
      nutrValues1: getNutrValuesForEditing(editable)
    });
  }
  addNewIngrToSet();
}

function getNutrValuesForEditing(editable) {
  return {
    kcal_1: editable.kcal_1,
    proteins_1: editable.proteins_1,
    fats_1: editable.fats_1,
    carbohydrates_1: editable.carbohydrates_1,
  };
}

function addNewForm() {
  if(ingridientsCapReached.value) {
    resultMessage.value = 'Ingridients cap reached';
    return;
  }
  if(newFormCanBeAdded.value) {
    addNewIngrToSet();
  }
}

function delIngridient(ingridient) {
  ingridients.delete(ingridient)
}

async function submitCooked() {
  if(!cookedNutrValuesAreCorrect())
    return;
  if(!cookedCanBeSubmitted())
    return;
    
  if(store.editCookedFlag) {
    const result = await editCookedAndIngrs(store.editableCooked, 
      cooked, ingridients);    
    checkUpdateResult(result)
  } else {
    const result = await sendCooked();
    checkSendingResult(result);
  }
}

function cookedNutrValuesAreCorrect() {
  if(cookedNutrValues100.value[0] > 1000) {
    resultMessage.value = 'Too many calories. Check your data';
    return false;
  }
  if(cookedNutrValues100.value[1] > 100) {
    resultMessage.value = 'Too many proteins. Check your data';
    return false;
  }
  if(cookedNutrValues100.value[2] > 100) {
    resultMessage.value = 'Too many fats. Check your data';
    return false;
  }
  if(cookedNutrValues100.value[3] > 100) {
    resultMessage.value = 'Too many carbohydrates. Check your data';
    return false;
  }
  return true;
}

function cookedCanBeSubmitted() {
  if(cooked.name != '' && cooked.weight != 0 && ingridients.size > 1) {
    return true;
  } else {
    resultMessage.value = 'Not enough data';
    return false;
  }
}

function checkUpdateResult(result) {
  resultMessage.value = result;
  if(result == 'Changes were saved') {
    cleanForm();
    store.editCookedFlag = false;
  }
}

function sendCooked() {
  const URL = '/api/cooked';
  const ingrsForSending = getIngrsForSending(ingridients);
  const cookedForSending = getCookedObjForSending(cooked);
  cookedForSending.ingridients = ingrsForSending;

  return request.post(URL, cookedForSending);
}

function checkSendingResult(result) {
  if(result === false) {
    resultMessage.value = 'Cooked wasn\'t added';
  } else {
    resultMessage.value = 'Cooked is added';
    cooked.id = result;
    cleanForm();
  }
}

function cleanForm() {
  cooked.id = '';
  cooked.name = '';
  cooked.weight = '';
  cooked.nutrValues1 = [];
  ingridients.clear();
  addNewIngrToSet();
}

function cancelOperation() {
  store.editCookedFlag = false;
  cleanForm();
}
</script>

<template>
  <input class="name" type="text"
    ref="cookedNameInputRef"
    placeholder="cooked thing name"
    maxlength="64"
    v-model="cooked.name">
  <input class="weight" type="text"
    placeholder="cooked weight"
    maxlength="4"
    @input="cooked.weight = validateWeightInput($event)"
    v-model="cooked.weight">
  <p>Ingridients:</p>
  <div class="ingridients">
    <div class="header">
      <span class="indent"></span>
      <span v-for="value in pseudos">{{ value }}</span>
    </div>
    <div v-for="(ingridient, index) in ingridients"
      :key="ingridient.listId">
      <IngridientForm
        :chosenIds="ingridientsIds"
        v-model:id="ingridient.id"
        v-model:name="ingridient.name"
        v-model:weight="ingridient.weight"
        v-model:nutrValues1="ingridient.nutrValues1"
        v-model:nutrValuesW="ingridient.nutrValuesW"
        @ingridientIsFull="addNewForm"
        @ingridientIsEmptied="delIngridient(ingridient)"
      />
      <button v-if="showDeleteButton[index] || ingridient.id"
        @click="delIngridient(ingridient)">
        Delete
      </button>
    </div>
  </div>
  <hr>
  <span class="indent">Nutritional value (per 100g):</span>
  <span v-for="value in cookedNutrValues100">
    {{ value }}
  </span>
  <button @click="submitCooked">
    {{ submitButtonText }}
  </button>
  <button @click="cancelOperation">
    {{ clearButtonText }}
  </button>
  <p class="result-message">
    {{ resultMessage }}
  </p>
  <hr>
</template>

<style>
  input.name {
    width: 400px;
    margin: 5px;
  }
  input.weight {
    width: 90px;
    margin: 5px;
  }
  span {
    display: inline-block;
    width: 60px;
  }
  .indent {
    width: 525px;
  }
  ul {
    list-style-type: none;
  }
</style>