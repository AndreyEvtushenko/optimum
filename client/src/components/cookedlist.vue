<script setup>
import { reactive, ref, watch, computed, onMounted } from 'vue';
import useStore from '../stores/cooked.js';
import request from '../libs/requests.js';
import IngridientList from './foodlist.vue';

const store = useStore();
const howManyToShowList = reactive([
  { text: 'Show the last:', value: 0 },
  { text: '5', value: 5 },
  { text: '10', value: 10 },
  { text: '15', value: 15 },
  { text: '30', value: 30 },
]);
const pseudos = ['Kcal', 'Prots', 'Fats', 'Carbs', 'Date'];
const showIngridients = reactive([]);

const resultMessage = ref('');
watch(resultMessage, (newValue) => {
  if(newValue)
    setTimeout(() => resultMessage.value = '', 2000);
});

const cookedListIsEmpty = computed(() => {
  if(store.cookedList.length == 0)
    return true;
  return false;
});

watch(() => store.cookedList.length,
  (newValue, oldValue) => {
    if(newValue - oldValue == 1) {
      showIngridients.push(false);
    } else if(oldValue == 0) {
      store.cookedList.forEach(() => showIngridients.push(false));
    }
});

function deleteSuggestion() {
  if(howManyToShowList[0].value == 0) {
    howManyToShowList.shift();
  }
}

function showCooked(event) {
  const cookedCount = event.target.value;
  getLastCooked(cookedCount);
  checkRetrievedCookedList();
}

async function getLastCooked(count) {
  const URL = `/api/cooked/last/${count}`;
  store.cookedList = await request.get(URL);
}

function checkRetrievedCookedList() {
  if(cookedListIsEmpty.value) {
    resultMessage.value = 'Nothing to show';
  }
}

async function getIngridients(cooked) {
  if(cooked.ingridients) 
    return;
  const id = cooked.id;
  const URL = `/api/cooked/ingrs/${id}`;
  cooked.ingridients = await request.get(URL);
}

function toggleIngrsButton(index) {
  showIngridients[index] = true;
}

function hideIngridients(index) {
  showIngridients[index] = false;
}

async function editCooked(cooked) {
  await getIngridients(cooked);
  store.editableCooked = cooked;
  store.editCookedFlag = true;
}
</script>

<template>
  <select @change="showCooked($event)"
    @focus="deleteSuggestion">
    <option v-for="item in howManyToShowList"
      :key="item.value"
      :value="item.value">{{ item.text }}</option>
  </select>
  <p v-if="cookedListIsEmpty">
    {{ resultMessage }}
  </p>
  <div class="cooked-list" v-else>
    <div class="header">
      <span class="cooked-name"></span>
      <span v-for="value in pseudos">{{ value }}</span>
    </div>
    <div class="list">
      <div class="cooked-item"
        v-for="(cooked, index) in store.cookedList"
        :key="cooked.food_id">
        <span class="cooked-name">
          {{ cooked.name }}
        </span>
        <span>{{ cooked.kcal }}</span>
        <span>{{ cooked.proteins }}</span>
        <span>{{ cooked.fats }}</span>
        <span>{{ cooked.carbohydrates }}</span>
        <span>
          {{ new Date(Date.parse(cooked.date)).toDateString() }}
        </span>
        <button v-if="showIngridients[index]"
          @click="hideIngridients(index)">
          Hide
        </button>
        <button v-else
          @click="getIngridients(cooked), toggleIngrsButton(index)">
          Ingrs.
        </button>
        <button @click="editCooked(cooked)">
          Edit
        </button>
        <IngridientList v-if="showIngridients[index]"
          :foodList="cooked.ingridients"
        />
      </div>
    </div>
  </div>
</template>

<style>
  select {
    width: 120px;
  }
  .cooked-list {
    margin: 10px;
    background-color: rgb(244, 246, 247);
  }
  .cooked-list .header {
    padding: 5px 0;
  }
  span.cooked-name {
    width: 450px;
  }
  .cooked-list .list {
    height: 530px;
    overflow-x: auto;
  }
  .list .cooked-item {
    padding: 3px 0;
  }
</style>