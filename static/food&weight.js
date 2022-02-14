const rootComponent = {
  data() {
    return {
      availFood: [],
      foodNameInput: '',
    }
  },
  methods: {
    async showAvailFood() {
      if(!this.availFood.length) {
        const res = await fetch('/api/availFood');
        this.availFood = await res.json();
        console.log(this.availFood);
        return;
      }
    },

    async getMatchingFood() {

    }
  },
}

const vueApp = Vue.createApp(rootComponent);
vueApp.mount('#vueFoodWeight');