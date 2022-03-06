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
  const url = `/api/daystat/${store.pickedDateString}`;
  store.dayStat = await request.get(url);
}
</script>

<template>
  <Datepicker v-model="store.pickedDate"
    input-format="yyyy MMM dd"></Datepicker>
</template>

<style>
</style>