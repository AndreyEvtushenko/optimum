<script setup>
import { onMounted, watch } from 'vue';
import Datepicker from 'vue3-datepicker';
import request from '../libs/requests.js';
import useStore from '../stores/store.js';

const store = useStore();

onMounted(() => {
  getFoodOnDate();
});

watch(() => store.pickedDateString, 
  (newDate, oldDate) => {
    if(newDate != oldDate) {
      getFoodOnDate();
    }
  }
);

async function getFoodOnDate() {
  const date = store.pickedDateString;
  const url = `/api/daystat/${date}`;
  const retrievedDayStat = await request.get(url);
  store.dayStat = retrievedDayStat;
}
</script>

<template>
  <div class="date-picker">
    <Datepicker v-model="store.pickedDate"
      input-format="yyyy MMM dd"></Datepicker>
  </div>  
</template>

<style>
  .date-picker {
    position: fixed;
    top: 64px;
    padding-bottom: 8px;
    padding-top: 8px;
    padding-left: 20px;
    background-color: white;
    /* otherwise food-form overlaps picker */
    z-index: 1;
  }
</style>