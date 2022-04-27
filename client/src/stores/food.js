import { defineStore } from 'pinia';

export default defineStore('storeId', {
  state() {
    return {
      pickedDate: new Date(),
      dayStat: [],
      //used for total stat calculations
      foodAddedFlag: false
    }
  },
  
  getters: {
    getDayStatId() {
      const length = this.dayStat.length;
      if(length) {
        const last = length - 1;
        const lastDayStatId = this.dayStat[last].dayStatId;
        return lastDayStatId + 1;
      }
      return 0;
    },

    pickedDateString() {
      return this.pickedDate.toDateString();
    },
  },
});