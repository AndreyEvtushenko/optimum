const rootComponent = {
  data() {
    return {
      availFood: [],
      foodNameInput: '',
      noMatches: false,
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
      if(this.foodNameInput.length >= 2) {
        const url = `/api/matchingFood/${this.foodNameInput}`;
        const res = await fetch(url);
        this.availFood = await res.json();
        if(this.availFood.length == 0) this.noMatches = true;
        else this.noMatches = false;
        console.log(this.availFood);
        return;
      }
      this.availFood = [];
    }
  },
}

const vueApp = Vue.createApp(rootComponent);
vueApp.mount('#vueFoodWeight');