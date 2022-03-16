<script setup>
//import Main from './components/main.vue';
</script>

<template>
  <nav>
    <router-link to="/">Main</router-link>
    <router-link to="/products">Products</router-link>
  </nav>
  <router-view></router-view>
  <router-view name="ProductList"></router-view>
</template>

<style>
  nav {
    background-color: rgb(218, 248, 218);
    padding: 20px;
  }
  a {
    padding: 20px;
  }
  a:hover {
    background-color: rgb(168, 231, 160);
  }
</style>