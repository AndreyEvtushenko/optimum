import { defineStore } from 'pinia';

export default defineStore('cookedId', {
  state() {
    return {
      cookedFormHeight: 289,
      editableCooked: {},
      editCookedFlag: false,
      baseCookedFlag: false,
      // cookedList item props:
      // { id, name, weight, date: String, kcal, proteins,
      // fats, carbohydrates, ingridients: Array }
      // cookedList item ingridient props:
      // { id, name, weight, kcal_1, proteins_1, fats_1, 
      // carbohydrates_1 }
      cookedList: []
    }
  },

  getters: {
  }
});