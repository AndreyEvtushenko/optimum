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
//used for total stat recalculation optimization
let dateChangedFlag = false;

watch(
  () => store.dayStat.length,
  (newValue, oldValue) => {
    if(newValue - oldValue == 1) {
      addToTotalStat();
      sendDayTotalStat('patch');
    }   
  }
);
//used for total stat recalculation optimization
watch(
  () => store.pickedDateString,
  (newDate, oldDate) => {
    if(newDate != oldDate)
      dateChangedFlag = true;
  }
);

watch(
  () => store.dayStat, async () => {
    if(dateChangedFlag && store.dayStat.length) {
      const gotTotalStat = await getDayTotalStat();
      if(!gotTotalStat) {
        calcTotalStat();
        sendDayTotalStat('post');
      }
      dateChangedFlag = false;
    }
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
  /* const obj = { date };
  Object.assign(obj, dayTotalStat); */
  if(method == 'post')
    request.post(`/api/totalstat/${date}`, dayTotalStat);
  else
    request.patch(`/api/totalstat/${date}`, dayTotalStat);
}

function delEatenFood(food) {
  const date = store.pickedDateString;
  const dayStatId = food.day_stat_id;
  const URL = `/api/daystat/${date}/${dayStatId}`;
  request.delete(URL);
  store.delFoodFromDayStat(dayStatId);
  subFromTotalStat(food);
  sendDayTotalStat('patch');
}

function calcTotalStat() {
  clearTotalDayStat();  
  store.dayStat.forEach((food) => {
    for(let key in dayTotalStat) {
      dayTotalStat[key] += food[key];
    }
  });
  roundTotalStat();
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
  <div v-if="store.dayStat.length">
    <hr>
    <span class="total">Total:</span>
    <span class="value" v-for="value in dayTotalStat">
      {{ value }}
    </span>
  </div>
</template>

<style>
  .foodOnDate span {
    display: inline-block;
    width: 60px;
  }
  .foodOnDate .firstColumn {
    width: 400px;
  }
  span.total {
    display: inline-block;
    width: 460px;
  }
  span.value {
    display: inline-block;
    width: 60px;
  }
</style>