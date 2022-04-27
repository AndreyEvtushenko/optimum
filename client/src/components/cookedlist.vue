<script setup>
import { reactive, ref, watch, computed, nextTick } from 'vue';
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
let howManyToShowValue;
const pseudos = ['Kcal', 'Prots', 'Fats', 'Carbs'];
// ref is used due to array replacement during deletion
const showIngridients = ref([]);
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
    if(newValue > howManyToShowValue && howManyToShowValue != 0) {
      store.cookedList.shift();
      showIngridients.value.shift();
    }
    if(newValue - oldValue == 1) {
      showIngridients.value.push(false);
    } else if(oldValue == 0) {
      store.cookedList.forEach(() => showIngridients.value.push(false));
    }
});

watch(() => store.cookedFormHeight, (newValue) => {
  const settings = document.querySelector('.cooked-list-settings');
  settings.style.top = newValue + 62 + 'px';
  setListMarginTop(newValue);
});

watch(cookedListIsEmpty, async (newValue) => {
  if(!newValue) {
    await nextTick();
    setListMarginTop(store.cookedFormHeight);
  }
});

function setListMarginTop(cookedFormHeight) {
  const header = document.querySelector('.cooked-list .header');
  if(header) {
    header.style.top = cookedFormHeight + 62 + 37 + 'px';
    const list = document.querySelector('.cooked-list');
    list.style.marginTop = cookedFormHeight + 62 + 37 + 34 + 'px';
  }
}

function deleteSuggestion() {
  if(howManyToShowList[0].value == 0) {
    howManyToShowList.shift();
  }
}

function showLastCooked(event) {
  howManyToShowValue = event.target.value;
  getLastCooked(howManyToShowValue);
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

function showCookedMatches(event) {
  const filter = event.target.value;
  if(filter.length < 2) {
    store.cookedList = [];
    howManyToShowValue = 0;
  } else {
    getCookedMatches(filter);
  }
}

async function getCookedMatches(filter) {
  const URL = `/api/cooked/matches/${filter}`;
  store.cookedList = await request.get(URL);
  checkRetrievedCookedList();
}

async function getIngridients(cooked) {
  if(cooked.ingridients) 
    return;
  const id = cooked.id;
  const URL = `/api/cooked/ingrs/${id}`;
  cooked.ingridients = await request.get(URL);
}

function toggleIngrsButton(index) {
  showIngridients.value[index] = true;
}

function hideIngridients(index) {
  showIngridients.value[index] = false;
}

async function editCooked(cooked) {
  await getIngridients(cooked);
  store.editableCooked = cooked;
  store.editCookedFlag = true;
}

async function deleteCooked(cooked, index) {
  if(!confirm('Do you really want delete it?'))
    return;
  const id = cooked.id;
  const URL = `/api/cooked/${id}`;
  const result = await request.delete(URL);

  processDeleteResult(result, cooked, index);
}

function processDeleteResult(result, cooked, index) {
  if(result == 'ER_ROW_IS_REFERENCED') {
    alert('Can\'t be deleted due to presence ' + 
    'as ingridient or in eaten food');
  // number of affected Rows
  } else if (result == 1) {
    deleteFromCookedList(cooked, index);
    getOneMoreCooked();
  }
}

function deleteFromCookedList(deletedCooked, deletedIndex) {
  showIngridients.value = showIngridients.value.filter(
    (item, index) => index != deletedIndex
  );
  store.cookedList = store.cookedList.filter(
    cooked => cooked != deletedCooked
  );
}

async function getOneMoreCooked() {
  if(howManyToShowValue == 0)
    return;
  const count = howManyToShowValue;
  const URL = `/api/cooked/first/${count}`;
  const result = await request.get(URL);
  store.cookedList.unshift(result);
}

async function useAsBase(cooked) {
  await getIngridients(cooked);
  store.editableCooked = cooked;
  store.baseCookedFlag = true;
}
</script>

<template>
  <div class="cooked-list-settings">
    <select @change="showLastCooked($event)"
      @focus="deleteSuggestion">
      <option v-for="item in howManyToShowList"
        :key="item.value"
        :value="item.value">{{ item.text }}</option>
    </select>
    <span>or</span>
    <input class="search" type="text"
      placeholder="search..."
      maxlength=64
      @input="showCookedMatches($event)">
  </div>
  <p class="cooked-search-result" v-if="cookedListIsEmpty">
    {{ resultMessage }}
  </p>
  <div class="cooked-list" v-else>
    <div class="header">
      <span class="cooked-name"></span>
      <span class="cooked-date">Date</span>
      <span v-for="value in pseudos">{{ value }}</span>
    </div>
    <div class="list">
      <div class="cooked-item"
        v-for="(cooked, index) in store.cookedList"
        :key="cooked.food_id">
        <span class="cooked-name">
          {{ cooked.name }}
        </span>
        <span class="cooked-date">
          {{ new Date(Date.parse(cooked.date)).toDateString() }}
        </span>
        <span>{{ cooked.kcal }}</span>
        <span>{{ cooked.proteins }}</span>
        <span>{{ cooked.fats }}</span>
        <span>{{ cooked.carbohydrates }}</span>        
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
        <button @click="deleteCooked(cooked, index)">
          Delete
        </button>
        <button @click="useAsBase(cooked)">
          Base
        </button>
        <IngridientList v-if="showIngridients[index]"
          :foodList="cooked.ingridients"
        />
      </div>
    </div>
  </div>
</template>

<style>
  .cooked-list-settings {
    position: fixed;
    top: 351px;
    padding-top: 5px;
    padding-bottom: 5px;
    background-color: white;
    z-index: 0;
  }
  .cooked-list-settings, .cooked-list {
    width: 970px;
  }
  .cooked-list-settings span {
    width: 25px;
  }
  .cooked-search-result {
    margin-top: 400px;
  }
  .cooked-list .header {
    position: fixed;
    top: 388px;
    padding-top: 5px;
    padding-bottom: 5px;
    width: 970px;
    background-color: white;
    /* cooked list settings and header overlap food matches */
    z-index: 0;
  }
  .cooked-list .header span {
    font-size: 16px;
  }
  .cooked-list {
    margin-top: 422px;
    margin-bottom: 65px;
  }
  .cooked-list span {
    font-size: 15px;
    width: 60px;
  }
  .cooked-list-settings span {
    text-align: center;
  }
  select {
    width: 120px;
    height: 30px;
  }
  option {
    border: 2px solid rgb(218, 221, 217);
    background-color: white;
    border-radius: 0;
  }
  .search {
    width: 430px;
  }
  .cooked-list .header {
    margin-top: 7px;
    margin-bottom: 7px;
    font-weight: bold;
  }
  span.cooked-name {
    width: 440px;
  }
  span.cooked-date {
    margin-right: 10px;
  }
  .list .cooked-item {
    padding: 3px 0;
  }
</style>