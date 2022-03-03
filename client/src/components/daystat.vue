<script setup>
import { watch } from 'vue';
import useStore from '../stores/store.js';
import request from '../libs/requests.js';

const store = useStore();

watch(
  () => store.dayStat.length,
  () => {
    if(store.dayStat.length) return true;
    else return false;
  }
);

function delEatenFood(food) {
  const date = store.pickedDateString;
  const dayStatId = food.day_stat_id;
  const URL = `/api/daystat/${date}/${dayStatId}`;
  request.delete(URL);
  store.delFoodFromDayStat(dayStatId);
}
</script>

<template>
  <p v-if="!store.dayStat.length">
    No eaten food on this date
  </p>
  <div class="dateFoodItem" 
    v-for="food in store.dayStat">
    <span class="foodName">{{ food.name }}</span>
    <span>{{ food.weight }}</span>
    <span>{{ food.kcal }}</span>
    <span>{{ food.proteins }}</span>
    <span>{{ food.fats }}</span>
    <span>{{ food.carbohydrates }}</span>
    <button @click="delEatenFood(food)">Delete</button>
  </div>
</template>

<style>
    .dateFoodItem span {
    display: inline-block;
    width: 50px;
  }
  .dateFoodItem .foodName {
    width: 400px;
  }
</style>