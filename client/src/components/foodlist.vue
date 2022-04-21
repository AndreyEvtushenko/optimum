<script setup>
import { computed } from 'vue';

const props = defineProps(['foodList']);
const pseudos = ['Weight', 'Kcal', 'Prots', 'Fats', 'Carbs'];

const foodListPerWeight = computed(() => {
  //without this check will be undefined error
  if(props.foodList)
  return props.foodList.map(food => {
    const obj = {};
    for(let key in food) {
      if(key.includes('_1')) {
        const newKey = key.replace('_1', '');
        obj[newKey] = +(food[key] * food.weight).toFixed(2);
      } else {
        obj[key] = food[key];
      }
    }
    return obj;
  });
});
</script>

<template>
  <div class="food-list">
    <div class="food-list-header">
      <span class="food-name"></span>
      <span v-for="value in pseudos">{{ value }}</span>
    </div>
    <div class="food-item"
      v-for="food in foodListPerWeight">
      <span class="food-name">{{ food.name }}</span>
      <span>{{ food.weight }}</span>
      <span>{{ food.kcal }}</span>
      <span>{{ food.proteins }}</span>
      <span>{{ food.fats }}</span>
      <span>{{ food.carbohydrates }}</span>
    </div>
  </div>
</template>

<style>
  .food-list {
    width: 750px;
    margin-top: 3px;
    margin-left: 10px;
    padding-left: 5px;
    border-left: 2px solid rgb(218, 221, 217);
    border-bottom: 2px solid rgb(218, 221, 217);
    border-right: 2px solid rgb(218, 221, 217);
  }
  .food-list .food-list-header span {
    font-size: 15px;
    font-weight: bold;
  }
  .food-list span.food-name {
    width: 440px;
  }
</style>