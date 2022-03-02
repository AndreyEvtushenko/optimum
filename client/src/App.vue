<script setup>
import Datepicker from './components/datepicker.vue';
import FoodWeight from './components/food&weight.vue';
import DayStat from './components/daystat.vue';
</script>

<template>
  <div class="datepicker">
    <Datepicker />
  </div>
  <div class="foodWeight">
    <FoodWeight />
  </div>
  <div class="dayStat">
    <DayStat />
  </div>
</template>

<style>
  .datepicker {
    padding: 20px;
    background-color: greenyellow;
  }
  .foodWeight {
    padding: 20px;
    background-color: rgb(147, 207, 147);
  }
</style>