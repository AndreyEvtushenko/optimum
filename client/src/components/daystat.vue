<script setup>
import { watch } from 'vue';
import useStore from '../stores/store.js';

const store = useStore();

watch(
  () => store.dayStat.length,
  () => {
    if(store.dayStat.length) return true;
    else return false;
  }
);
</script>

<template>
  <p v-if="!store.dayStat.length">No eaten food on this date</p>
  <div class="dateFoodItem" 
    v-for="food in store.dayStat">
    <span class="foodName">{{ food.name }}</span>
    <span>{{ food.weight }}</span>
    <span>{{ food.kcal }}</span>
    <span>{{ food.proteins }}</span>
    <span>{{ food.fats }}</span>
    <span>{{ food.carbohydrates }}</span>
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