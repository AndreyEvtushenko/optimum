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
      dayStat: [],
      //used for total stat calculations
      foodAddedFlag: false,
      foodDeletedFlag: false
    }
  },
  
  getters: {
    dayStatId() {
      const length = this.dayStat.length;
      if(length) {
        const lastDayStatId = this.dayStat[length - 1].day_stat_id;
        return lastDayStatId + 1;
      }
      return 0;
    },

    pickedDateString() {
      return this.pickedDate.toDateString();
    },
  },

  actions: {
    sendEatenFood() {
      //order is important
      const obj = {
        pickedDate: this.pickedDateString,
        dayStatId: this.dayStatId,
        foodId: this.foodId,
        weight: this.weight
      }
      request.post('/api/daystat', obj);
      this.addFoodToDayStat();
    },

    addFoodToDayStat() {
      this.dayStat.push({
        day_stat_id: this.dayStatId,
        name: this.name,
        weight: this.weight,
        kcal: this.kcal,
        proteins: this.proteins,
        fats: this.fats,
        carbohydrates: this.carbohydrates
      });
      this.foodAddedFlag = true;
    },

    delFoodFromDayStat(dayStatId) {
      this.dayStat = this.dayStat.filter(
        food => food.day_stat_id != dayStatId
      );
      this.foodDeletedFlag = true;
    },
  }
});