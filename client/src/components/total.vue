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
    <span>From: </span>
    <Datepicker v-model="fromDate"
      input-format="yyyy MMM dd"></Datepicker>
    <span>To: </span>
    <Datepicker v-model="toDate"
      input-format="yyyy MMM dd"></Datepicker>
  </div>
  <p v-if="noTotalStat">
    No data on this period
  </p>
  <div class="total-stat-list" v-else>
    <span class="date">Date</span>
    <span v-for="item in pseudos"> {{ item }}</span>
    <div v-for="stat in totalStatPeriod">
      <span class="date">{{ stat.date }}</span>
      <span>{{ stat.kcal }}</span>
      <span>{{ stat.proteins }}</span>
      <span>{{ stat.fats }}</span>
      <span>{{ stat.carbohydrates }}</span>
    </div>
  </div>

</template>

<style>
  .date-interval span {
    width: 20px;
  }
  span.date {
    width: 130px;
  }
  .total-stat-list span {
    margin: 5px;
  }
</style>