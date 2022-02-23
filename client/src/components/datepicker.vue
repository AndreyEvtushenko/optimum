<script setup>
import { onMounted, ref, computed, watch } from 'vue';
import Datepicker from 'vue3-datepicker';
import requests from '../libs/requests.js';

let pickedDate = ref(new Date());

onMounted(() => {
  requests.sendDate(pickedDateString.value);
});

watch(pickedDate, () => {
  requests.sendDate(pickedDateString.value);
});

const pickedDateString = computed(() => {
  return pickedDate.value.toDateString();
});
</script>

<template>
  <Datepicker v-model="pickedDate"
    input-format="yyyy MMM dd"></Datepicker>
</template>

<style>
</style>