<script setup>
import { ref, computed, watch } from 'vue';
import { validateWeightInput } from '../libs/common.js';
import request from '../libs/requests.js';

const weightInputRef = ref(null);

const props = defineProps([
  'chosenIds',
  'id', 
  'name', 
  'weight', 
  'nutrValues1', 
  'nutrValuesW',
  ]);
const emit = defineEmits([
  'update:id', 
  'update:name', 
  'update:weight',
  'update:nutrValues1',
  'update:nutrValuesW',
  'ingridientIsFull',
  'ingridientIsEmptied'
]);
const foodMatches = ref([]);

const nutrValuesPerWeight = computed(() => {
  if(!enoughDataProvided.value)
    return ['-', '-', '-', '-'];
  
  const nutrValuesW = [];
  const nutrValues1 = props.nutrValues1;
  const weight = props.weight;
  for(let key in nutrValues1) {
    nutrValuesW.push(+(nutrValues1[key] * weight).toFixed(2));
  }
  //it's a crutch. When props are defined from the outside,
  //watcher doesn't work
  emit('update:nutrValuesW', nutrValuesW);
  return nutrValuesW;
});

const enoughDataProvided = computed(() => {
  const nutrValues1 = props.nutrValues1;
  const weight = props.weight;

  if(nutrValues1)
    return 'kcal_1' in nutrValues1 && weight > 0 ? true : false;
  else
    return false;
});

const foodMatchesWithoutChosen = computed(() => {
  const filteredFoodMatches = [];
  for(let food of foodMatches.value) {
    if(props.chosenIds.includes(food.food_id))
      continue;
    filteredFoodMatches.push(food);
  }
  return filteredFoodMatches;
});

watch(enoughDataProvided, (newValue) => {
  if(newValue)
    emit('ingridientIsFull');
});

watch(nutrValuesPerWeight, (newValue) => {
  if(newValue.includes('-'))
    emit('update:nutrValuesW', null);
  else {
    emit('update:nutrValuesW', newValue);
  }
});

function showFoodMatches(event) {
  const filter = event.target.value;
  if(filter.length < 2) {
    foodMatches.value = [];
    return;
  } else {
    getFoodMatches(filter);
  }
}

async function getFoodMatches(filter) {
  const URL = `/api/food/matches/${filter}`;
  foodMatches.value = await request.get(URL);
}

function clearChosenFood() {
  if(props.id) {
    emit('update:id', null);
    emit('update:nutrValues1', null);
  }
}

function checkIfFormIsEmpty() {
  if(props.name == '' && props.weight == '' && props.id === null)
    emit('ingridientIsEmptied');
}
//weight input show incorrect value although prop has the correct one
function fixWeightInputValue(event) {
  weightInputRef.value.value = validateWeightInput(event);
}

function selectThisFood(food) {
  emit('update:name', food.food_name);
  emit('update:id', food.food_id);

  foodMatches.value = [];
  weightInputRef.value.focus();
  getSelectedFoodData(food.food_id);
}

async function getSelectedFoodData(id) {
  const nutrValues1 = await request.get(`/api/food/data/${id}`);
  emit('update:nutrValues1', nutrValues1);
}
</script>

<template>
  <input class="name" type="text"
    placeholder="name" maxlength="64"
    :value="name"
    @input="$emit('update:name', $event.target.value),
      showFoodMatches($event), clearChosenFood()"
    @focusout="checkIfFormIsEmpty">
  <input class="weight" type="text"
    ref="weightInputRef"
    placeholder="weight" maxlength="4"
    :value="weight"
    @input="$emit('update:weight', validateWeightInput($event)),
      fixWeightInputValue($event)"
    @focusout="checkIfFormIsEmpty">
  <span v-for="value in nutrValuesPerWeight">
    {{ value }}
  </span>
  <ul v-if="foodMatches.length">
    <li v-for="food in foodMatchesWithoutChosen"
      @click="selectThisFood(food)">
      {{ food.food_name }}
    </li>
  </ul>
</template>

<style>
</style>