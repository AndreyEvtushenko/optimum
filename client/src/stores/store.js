import { defineStore } from 'pinia';
import request from '../libs/requests.js';

export default defineStore('storeId', {
  state() {
    return {
      pickedDate: new Date(),
      foodId: null,
      name: null,
      weight: null,
      kcal: null,
      proteins: null,
      fats: null,
      carbohydrates: null,
      dayStat: []
    }
  },
  
  getters: {
    dayStatId() {
      return this.dayStat.length;
    }
  },

  actions: {
    sendEatenFood() {
      //order is important
      const obj = {
        pickedDate: this.pickedDate.toDateString(),
        dayStatId: this.dayStatId,
        foodId: this.foodId,
        weight: this.weight
      }
      request.post('/api/daystat', obj);
      this.addFoodToDayStat();
    },

    addFoodToDayStat() {
      this.dayStat.push({
        name: this.name,
        weight: this.weight,
        kcal: this.kcal,
        proteins: this.proteins,
        fats: this.fats,
        carbohydrates: this.carbohydrates
      });
    }
  }
});