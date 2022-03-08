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

watch(
  () => store.foodAddedFlag,
  (newValue) => {
    if(!newValue) return;
    console.log('adding')
    addToTotalStat();
    if(store.dayStat.length == 1)
      sendDayTotalStat('post');
    else
      sendDayTotalStat('patch');
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
    console.log('dayStat changed')
    if(store.dayStat.length && !store.foodDeletedFlag) {
      console.log('working')
      const gotTotalStat = await getDayTotalStat();
      console.log(gotTotalStat)
    } else
      store.foodDeletedFlag = false;
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

function sendDayTotalStat(method) {
  const date = store.pickedDateString;
  if(method == 'post')
    request.post(`/api/totalstat/${date}`, dayTotalStat);
  else
    request.patch(`/api/totalstat/${date}`, dayTotalStat);
}

function delEatenFood(food) {
  console.log('deleting')
  const date = store.pickedDateString;
  const dayStatId = food.day_stat_id;
  const URL = `/api/daystat/${date}/${dayStatId}`;
  request.delete(URL);
  store.delFoodFromDayStat(dayStatId);
  subFromTotalStat(food);
  if(store.dayStat.length)
    sendDayTotalStat('patch');
  else
    request.delete(`/api/totalstat/${date}`);
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
  <p v-if="!store.dayStat.length">
    No eaten food on this date
  </p>
  <div v-if="store.dayStat.length">
    <div class="foodOnDate">
      <span class="firstColumn"></span>
      <span>Weight</span>
      <span>Kcal</span>
      <span>Prots.</span>
      <span>Fats</span>
      <span>Carbs.</span>
    </div>
    <div class="foodOnDate"
      v-for="food in store.dayStat">
      <span class="firstColumn">{{ food.name }}</span>
      <span>{{ food.weight }}</span>
      <span>{{ food.kcal }}</span>
      <span>{{ food.proteins }}</span>
      <span>{{ food.fats }}</span>
      <span>{{ food.carbohydrates }}</span>
      <button @click="delEatenFood(food)">Delete</button>
    </div>
    <div class="totalStat">
      <hr>
      <span class="header">Total:</span>
      <span class="value" v-for="value in dayTotalStat">
        {{ value }}
      </span>
    </div>
  </div>  
</template>

<style>
  .foodOnDate span, .totalStat span {
    display: inline-block;
    width: 60px;
  }
  .foodOnDate .firstColumn {
    width: 400px;
  }
  .totalStat .header {
    width: 460px;
  }
</style>