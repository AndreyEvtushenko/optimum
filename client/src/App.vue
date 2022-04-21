<script setup>
function changeActive(event) {
  event.target.classList.add('current');
}
</script>

<template>
  <nav @click="changeActive($event)">
    <router-link id="main-link" to="/">Main</router-link>
    <router-link id="prod-link" to="/products">Products</router-link>
    <router-link id="cook-link" to="/cooked">Cooked</router-link>
    <router-link id="tot-link" to="/total">Total</router-link>
  </nav>
  <router-view name="DatePicker"></router-view>
  <router-view></router-view>
  <router-view name="DayStat"></router-view>
  <router-view name="ProductList"></router-view>
  <router-view name="CookedList"></router-view>
  <footer>
    &copy Andrey Evtushenko, 2022
  </footer>
</template>

<style>
  body {
    width: 970px;
    margin: 0 auto;
  }
  body, input, button {
    font-family: 'Noto Sans', sans-serif;
  }
  nav {
    top: 0;
  }
  nav, footer {
    background-color: rgb(218, 248, 218);
    padding: 20px;
    position: fixed;    
    left: 50%;
    transform: translate(-50%, 0);
    width: 970px;
  }
  a {
    padding: 20px;
    text-decoration: none;
  }
  a:link, a:visited {
    color: rgb(34, 117, 25);
  }  
  a:hover {
    background-color: rgb(192, 236, 183);
  }
  a.current {
    background-color: rgb(168, 231, 160);
  }
  input {
    margin-right: 5px; 
    border: 2px solid rgb(218, 221, 217);
    padding: 5px;
    font-size: 15px;
  }
  input.name {
    width: 400px;
  }
  input.weight {
    width: 90px;
  }
  input:focus {
    outline: none;
    border: 2px solid rgb(168, 231, 160);
  }
  span {
    display: inline-block;
    font-size: 14px;
  }
  .header span {
    font-size: 16px;
  }
  ul {
    font-size: 14px;
    list-style-type: none;
  }
  .form-buttons {
    width: 600px;
    margin: 5px auto;
    text-align: center;
  }
  .form-buttons button, .day-stat button,
  .product-list-buttons button, .products button, 
  .ingridient button, .cooked-list button, select {
    border: 2px solid rgb(218, 221, 217);
    border-radius: 0;
    background-color: rgb(243, 243, 243);
    width: 52px;  
  }
  .form-buttons button {
    height: 38px;
    width: 100px;
    font-size: 16px;
    margin: 5px 5px;
  }  
  button:hover {
    background-color: rgb(218, 248, 218);
  }
  button:active {
    border: 2px solid rgb(168, 231, 160);
    background-color: rgb(168, 231, 160);
  }
  p {
    font-size: 14px;
  }
  footer {
    bottom: 0;
    font-size: 14px;
    color: rgb(34, 117, 25);
    text-align: right;
  }
</style>