<script setup>
import Datepicker from './datepicker.vue';
import FoodWeight from './food&weight.vue';
import DayStat from './daystat.vue';
</script>

<template>
  <div class="datepicker">
    <Datepicker />
  </div>
  <div class="provideFoodWeight">
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
  .provideFoodWeight {
    padding: 20px;
    background-color: rgb(147, 207, 147);
  }
  .dayStat {
    padding: 20px;
    background-color: rgb(199, 238, 204);
  }
</style>