<script setup>
import { onMounted, ref, computed, watch } from 'vue';
import Datepicker from 'vue3-datepicker';
import request from '../libs/requests.js';
import useStore from '../stores/store.js';

const store = useStore();

onMounted(() => {
  getFoodOnDate();
});

watch(
  () => store.pickedDateString, 
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
  <Datepicker v-model="store.pickedDate"
    input-format="yyyy MMM dd"></Datepicker>
</template>

<style>
</style>