<script setup>
import { onMounted, ref, computed, watch } from 'vue';
import Datepicker from 'vue3-datepicker';
import requests from '../libs/requests.js';
import useStore from '../stores/store.js';

//let pickedDate = ref(new Date());

const store = useStore();

/* onMounted(() => {
  requests.sendDate(pickedDateString.value);
});

watch(store.pickedDate, () => {
  requests.sendDate(pickedDateString.value);
}); */

const pickedDateString = computed(() => {
  return store.pickedDate.toDateString();
});
</script>

<template>
  <Datepicker v-model="store.pickedDate"
    input-format="yyyy MMM dd"></Datepicker>
</template>

<style>
</style>