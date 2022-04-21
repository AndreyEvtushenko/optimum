<script setup>
import { ref, watch, onMounted } from 'vue';
import Datepicker from 'vue3-datepicker';
import request from '../libs/requests.js';

const fromDate = ref(null);
const toDate = ref(new Date());
const totalStatPeriod = ref([]);
const noTotalStat = ref(false);
const pseudos = ['Kcal', 'Prots', 'Fats', 'Carbs'];

onMounted(() => {
  adjustFromDate();
  getTotalStat();

  const href = document.getElementById('tot-link');
  href.classList.add('current');
});

watch(fromDate, (newValue) => {
  if(newValue > toDate.value) {
    fromDate.value = toDate.value;
  }
});

watch(toDate, (newValue) => {
  if(newValue < fromDate.value) {
    fromDate.value = toDate.value;
  }
});

function adjustFromDate() {
  const fromDay = toDate.value.getDate() - 10;
  const adjustedFromDate = new Date();
  adjustedFromDate.setDate(fromDay);
  fromDate.value = adjustedFromDate;
}

async function getTotalStat() {
  const from = fromDate.value.toDateString();
  const to = toDate.value.toDateString();
  const URL = `/api/totalstat/${from}/${to}`;

  const result = await request.get(URL);
  checkGetTotalStatResult(result);
}

function checkGetTotalStatResult(result) {
  if(result.length > 0) {
    totalStatPeriod.value = result;
    convertTotalStatDate();
    noTotalStat.value = false;
  } else {
    noTotalStat.value = true;
  }
}

function convertTotalStatDate() {
  let dates = [];
  dates = totalStatPeriod.value.map(item => 
    new Date(Date.parse(item.date)).toDateString()
  );
  for(let index = 0; index < dates.length; index++) {
    totalStatPeriod.value[index].date = dates[index];
  }
}
</script>

<template>
  <div class="date-interval">
    <span class="interval-label">From: </span>
    <div class="from">      
      <Datepicker v-model="fromDate"
        input-format="yyyy MMM dd"></Datepicker>
    </div>
    <span class="interval-label">To: </span>
    <div class="to">      
      <Datepicker v-model="toDate"
        input-format="yyyy MMM dd"></Datepicker>
    </div>    
  </div>
  <p class="no-total-stat" v-if="noTotalStat">
    No data on this period
  </p>
  <div class="total-stat-list" v-else>
    <div class="header">
      <span class="date">Date</span>
      <span v-for="item in pseudos"> {{ item }}</span>
    </div>
    <div class="total-stat-item"
      v-for="stat in totalStatPeriod">
      <span class="date">{{ stat.date }}</span>
      <span>{{ stat.kcal }}</span>
      <span>{{ stat.proteins }}</span>
      <span>{{ stat.fats }}</span>
      <span>{{ stat.carbohydrates }}</span>
    </div>
  </div>
</template>

<style>
  .date-interval .from, .date-interval .to {
    display: inline-block;
    width: 350px;
    margin-bottom: 5px;
  }
  .date-interval {
    width: 400px;
    padding-top: 8px;
    padding-bottom: 8px;
    padding-left: 20px;
    position: fixed;
    top: 62px;
    background-color: white;
    z-index: 1;
  }
  span.interval-label {
    width: 40px;
    margin-right: 5px;
    text-align: right;
  }
  .no-total-stat {
    padding-left: 20px;
    position: fixed;
    top: 156px; 
  }
  .total-stat-list {
    margin-top: 180px;
    margin-bottom: 65px;
    padding-left: 20px;
    z-index: 0;
  }
  .total-stat-list span {
    font-size: 15px;
    width: 70px;
  }
  .total-stat-list .header {
    position: fixed;
    top: 156px;
    padding-bottom: 5px;
    background-color: white;
  }
  .total-stat-list .header span{
    font-size: 16px;
    font-weight: bold;
  }
  span.date {
    width: 135px;
  }
  .total-stat-item {
    margin-top: 5px;
  }  
</style>