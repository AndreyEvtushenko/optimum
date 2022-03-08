<script setup>
import { ref, onMounted, computed, reactive } from 'vue';
import request from '../libs/requests.js';
import useStore from '../stores/store.js';

const store = useStore();

const foodNameInputRef = ref(null);
const weightInputRef = ref(null);
let foodNameInput = ref('');
let weightInput = ref('');
let foodMatches = ref([]);
const pickedFood = reactive({
  id: null,
  name: null,
  weight: null,
  kcal_1: null,
  proteins_1: null,
  fats_1: null,
  carbohydrates_1: null
});

const noMatches = computed(() => {
  if(foodMatches.value.length == 0 &&
    foodNameInput.value.length > 1 &&
    !pickedFood.id)
    return true;
  else
    return false;
});

const foodValuePerWeight = computed(() => {
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
});

onMounted(() => {
  foodNameInputRef.value.focus();
});
//handlers
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
  pickedFood.id = food.food_id;
  pickedFood.name = food.food_name;
  foodNameInput.value = food.food_name;
  foodMatches.value = [];
  weightInputRef.value.focus();
  getPickedFoodData(food.food_id);
  validateWeightInput();
}

function submitSpecifiedFood() {
  sendEatenFood();
  addFoodToDayStat();
  
  clearFoodData();
  clearInput();

  foodNameInputRef.value.focus();
}

async function getPickedFoodData(id) {
  const data = await request.get(`/api/food/data/${id}`);
  Object.assign(pickedFood, data);
}

function sendEatenFood() {
  const eatenFood = {
    date: store.pickedDateString,
    dayStatId: store.getDayStatId,
    foodId: pickedFood.id,
    weight: pickedFood.weight
  }
  request.post('/api/daystat', eatenFood);
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
  <input type="text"
    ref="foodNameInputRef"
    placeholder="food name"
    @input="clearFoodData(), getFoodMatches()"
    v-model="foodNameInput">
  <input type="text"
    ref="weightInputRef"
    placeholder="food weight"
    @input="validateWeightInput"
    v-model="weightInput">
  <p v-for="(value, key) in foodValuePerWeight">
    {{ key }}: {{ value }}
  </p>
  <button @click="submitSpecifiedFood">
    Submit
  </button>
  <p v-if="noMatches">No matches found</p>
  <ul v-if="foodMatches.length > 0">
    <li v-for="food in foodMatches"
      @click="selectThisFood(food)">
      {{ food.food_name }}
    </li>
  </ul>
</template>

<style>
</style>