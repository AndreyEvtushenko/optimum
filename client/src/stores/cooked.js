import { defineStore } from 'pinia';

export default defineStore('cookedId', {
  state() {
    return {
      ingridients: new Set(),
      cookedList: []
    }
  },

  getters: {
  }
});