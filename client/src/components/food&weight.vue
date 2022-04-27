<script setup>
import { ref, onMounted, computed, reactive } from 'vue';
import request from '../libs/requests.js';
import useStore from '../stores/store.js';

const store = useStore();

const foodNameInputRef = ref(null);
const weightInputRef = ref(null);
const foodNameInput = ref('');
const weightInput = ref('');
const foodMatches = ref([]);
const pickedFood = reactive({
  id: null,
  name: null,
  weight: null,
  kcal_1: null,
  proteins_1: null,
  fats_1: null,
  carbohydrates_1: null
});
const pseudos = ['Kcal', 'Prots', 'Fats', 'Carbs'];

onMounted(() => {
  foodNameInputRef.value.focus();

  const href = document.getElementById('main-link');
  href.classList.add('current');
});

const noMatches = computed(() => {
  if(foodMatches.value.length == 0 &&
    foodNameInput.value.length > 1 &&
    !pickedFood.id)
    return true;
  else
    return false;
});

const foodMatchesToShow = computed(() => {
  return foodMatches.value.map(item => getFoodObjToShow(item));
});

const foodValuePerWeight = computed(() => {
  if(!enoughDataProvided.value)
    return ['-', '-', '-', '-'];
  return getNutrValusToShow();
});

const enoughDataProvided = computed(() => {
  return pickedFood.id && pickedFood.weight > 0 ? true : false;
});

function getFoodObjToShow(item) {
    const obj = {
      id: item.id
    }
    if(item.date) {
      const date = new Date(Date.parse(item.date)).toDateString();
      obj.foodNameDate = `${item.name} [ ${date} ]`;
      obj.name = item.name;
    } else {
      obj.foodNameDate = item.name;
      obj.name = item.name;
    }
    return obj;
}

function getNutrValusToShow() {
  return {
    kcal: +(pickedFood.kcal_1 * pickedFood.weight)
      .toFixed(2),
    proteins: +(pickedFood.proteins_1 * pickedFood.weight)
      .toFixed(2),
    fats: +(pickedFood.fats_1 * pickedFood.weight)
      .toFixed(2),
    carbohydrates: +(pickedFood.carbohydrates_1 * pickedFood.weight)
      .toFixed(2),
  }
}

function clearFoodData() {
  if(pickedFood.id) {
    for(let value in pickedFood)
      pickedFood[value] = null;
  }
}

async function getFoodMatches() {
  if(foodNameInput.value.length < 2) {
    foodMatches.value = [];
    return;
  } else {
    const input = foodNameInput.value;
    foodMatches.value = await request.get(`/api/food/matches/${input}`);
  }
}

function validateWeightInput() {
  let input = weightInput.value;
  input = parseFloat(input);
  if(isNaN(input)) {
    weightInput.value = null;
    pickedFood.weight = null;
    return;
  }
  pickedFood.weight = input;
}

function selectThisFood(food) {
  pickedFood.id = food.id;
  pickedFood.name = food.name;
  foodNameInput.value = food.name;
  foodMatches.value = [];
  weightInputRef.value.focus();
  getPickedFoodData(food.id);
  validateWeightInput();
}

async function getPickedFoodData(id) {
  const data = await request.get(`/api/food/data/${id}`);
  Object.assign(pickedFood, data);
}

async function submitSpecifiedFood() {
  if(!enoughDataProvided.value)
    return;
  const sendResult = await sendEatenFood();
  if(!sendResult)
    return;

  addFoodToDayStat();  
  clearFoodData();
  clearInput();
  foodNameInputRef.value.focus();
}

async function sendEatenFood() {
  const eatenFood = {
    date: store.pickedDateString,
    dayStatId: store.getDayStatId,
    foodId: pickedFood.id,
    weight: pickedFood.weight
  }
  const result = await request.post('/api/daystat', eatenFood);
  return result;
}

function addFoodToDayStat() {
  const dayStatFoodItem = {
    dayStatId: store.getDayStatId,
    name: pickedFood.name,
    weight: pickedFood.weight,
  }
  Object.assign(dayStatFoodItem, foodValuePerWeight.value);
  store.dayStat.push(dayStatFoodItem);
  store.foodAddedFlag = true;
}

function clearInput() {
  foodNameInput.value = '';
  weightInput.value = '';
}
</script>

<template>
  <div class="food-form">
    <div class="header">
      <span class="indent"></span>
      <span v-for="item in pseudos">{{ item }}</span>
    </div>   
    <input class="name" type="text"
      ref="foodNameInputRef"
      placeholder="food name"
      maxlength="64"
      @input="clearFoodData(), getFoodMatches()"
      v-model="foodNameInput">
    <input class="weight" type="text"
      ref="weightInputRef"
      placeholder="food weight"
      maxlength="4"
      @input="validateWeightInput"
      v-model="weightInput">
    <span v-for="value in foodValuePerWeight">
      {{ value }}
    </span>
    <p class="matches" v-if="noMatches">No matches found</p>
    <ul class="matches" v-if="foodMatches.length > 0">
      <li v-for="food in foodMatchesToShow"
        @click="selectThisFood(food)">
        {{ food.foodNameDate }}
      </li>
    </ul>
    <div class="form-buttons">
      <button @click="submitSpecifiedFood">
        Submit
      </button>
    </div>
  </div>
</template>

<style>
  .food-form {
    width: 770px;
    position: fixed;
    top: 112px;    
    left: 50%;
    transform: translate(-50%, 0);
    background-color: white;
    /* otherwise food-form overlaps date-picker */
    z-index: 0;
  }
  .matches {
    padding-left: 0;
    margin-top: -2px;
    border: 2px solid rgb(218, 221, 217);
    background-color: white;
    cursor: pointer;
    width: 500px;
    position: absolute;
  }  
  .matches li {
    margin: 1px;
    padding: 2px;
  }
  .matches li:hover {
    background-color: rgb(209, 238, 207);
  }
  .food-form span {
    width: 60px;
  }
  .food-form span.indent {
    width: 528px;
  }
</style>