<script setup>
import { watch, reactive } from 'vue';
import useStore from '../stores/store.js';
import request from '../libs/requests.js';

const store = useStore();
const dayTotalStat = reactive({
  kcal: 0,
  proteins: 0,
  fats: 0,
  carbohydrates: 0
});
const pseudos = ['Weight', 'Kcal', 'Prots', 'Fats', 'Carbs'];
let foodDeletedFlag = false;

watch(
  () => store.foodAddedFlag,
  (newValue) => {
    if(!newValue) return;
    const date = store.pickedDateString;
    addToTotalStat();
    if(store.dayStat.length == 1)
      request.post(`/api/totalstat/${date}`, dayTotalStat);
    else
      request.patch(`/api/totalstat/${date}`, dayTotalStat);
    store.foodAddedFlag = false;
  }
);

watch(
  () => store.pickedDateString,
  (newDate, oldDate) => {
    if(newDate != oldDate) {
      clearTotalDayStat();
    }      
  }
);

watch(
  () => store.dayStat, async () => {
    if(store.dayStat.length && !foodDeletedFlag) {
      await getDayTotalStat();
    } else
      foodDeletedFlag = false;
  }
);

async function getDayTotalStat() {
  const date = store.pickedDateString;
  const receivedTotalStat = await request.get(`/api/totalstat/${date}`);
  if(receivedTotalStat.length) {
    //we receive array of objects, but there only one inside
    Object.assign(dayTotalStat, receivedTotalStat[0]);
    return true;
  }
  else return false;
}

function delEatenFood(food) {
  const date = store.pickedDateString;
  const dayStatId = food.dayStatId;
  const URL = `/api/daystat/${date}/${dayStatId}`;
  request.delete(URL);
  delFromDayStat(dayStatId);
  subFromTotalStat(food);
  if(store.dayStat.length)
    request.patch(`/api/totalstat/${date}`, dayTotalStat);
  else
    request.delete(`/api/totalstat/${date}`);
}

function delFromDayStat(dayStatId) {
  store.dayStat = store.dayStat.filter(
    food => food.dayStatId != dayStatId
  );
  foodDeletedFlag = true;
}

function clearTotalDayStat() {
  for(let key in dayTotalStat)
    dayTotalStat[key] = 0;
}

function roundTotalStat() {
  for(let key in dayTotalStat) {
    dayTotalStat[key] = +(dayTotalStat[key].toFixed(2));
  }
}

function addToTotalStat() {
  const dayStatLength = store.dayStat.length;
  const lastFood = store.dayStat[dayStatLength - 1];
  for(let key in dayTotalStat) {
    dayTotalStat[key] += lastFood[key];
  }
  roundTotalStat();
}

function subFromTotalStat(deletedFood) {
  for(let key in dayTotalStat) {
    dayTotalStat[key] -= deletedFood[key];
  }
  deletedFood = null;
  roundTotalStat();
}
</script>

<template>
  <p class="day-stat" v-if="!store.dayStat.length">
    No eaten food on this date
  </p>
  <div class="day-stat" v-if="store.dayStat.length">
    <div class="header">
      <span class="indent"></span>
      <span v-for="item in pseudos">{{ item }}</span>
    </div>
    <div class="food-item"
      v-for="food in store.dayStat">
      <span class="food-name">{{ food.name }}</span>
      <span>{{ food.weight }}</span>
      <span>{{ food.kcal }}</span>
      <span>{{ food.proteins }}</span>
      <span>{{ food.fats }}</span>
      <span>{{ food.carbohydrates }}</span>
      <button @click="delEatenFood(food)">Delete</button>
    </div>
    <hr>
    <div class="total-stat">      
      <span class="header">Total:</span>
      <span class="value" v-for="value in dayTotalStat">
        {{ value }}
      </span>
    </div>
  </div>  
</template>

<style>
  .day-stat {
    margin-top: 10px;
    padding-left: 20px;
    width: 800px;
    margin: 0 auto;
    margin-top: 226px;
    margin-bottom: 65px;
  }
  .day-stat span {
    width: 60px;
  }
  .day-stat span.indent, .day-stat span.food-name {
    width: 440px;
  }
  .day-stat .header {
    margin-bottom: 7px;
    font-weight: bold;
  }
  .food-item {
    margin: 2px;
  }
  .food-item span {
    font-size: 15px;
  }
  .total-stat span {
    font-size: 16px;
  }
  .total-stat .header {
    width: 500px;
  }
</style>