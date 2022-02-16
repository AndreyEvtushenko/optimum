const rootComponent = {
  data() {
    return {
      availFood: [],
      nameInput: '',
      selectedFoodName: '',
      selectedFoodId: null,
      weightInput: null,
      weight: null,
      nutrients: {
        kcal: null,
        proteins: null,
        fats: null,
        carbohydrates: null,
      }
    }
  },
  watch: {
    selectedFoodId(newValue, oldValue) {
      if(newValue) {
        this.getNutrients(newValue);
        this.$refs.weightInput.focus();
      }
    }
  },
  computed: {
    noMatches() {
      if(this.availFood.length == 0 &&
        this.nameInput.length >= 2 &&
        !this.selectedFoodId) return true;
      else return false;
    },

    nutrientsPerWeight() {
      const nutrients = {};
      for(let key in this.nutrients) {
        nutrients[key] = (this.nutrients[key] *
          this.weight).toFixed(2);
      }
      return nutrients;
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
      if(this.nameInput.length >= 2) {
        const url = `/api/matchingFood/${this.nameInput}`;
        const res = await fetch(url);
        this.availFood = await res.json();
        return;
      }
      this.availFood = [];
    },

    async selectThisFood(food) {
      this.nameInput = food.food_name;
      this.selectedFoodName = food.food_name;
      this.selectedFoodId = food.food_id;
      this.availFood = [];
    },

    async getNutrients(food_id) {
      const url = `/api/food/${food_id}`;
      const res = await fetch(url);
      const nutrients = await res.json();
      Object.assign(this.nutrients, nutrients);
    },

    validateWeightInput() {
      let input = this.weightInput;
      input = parseFloat(input);
      if(isNaN(input)) {
        this.weightInput = null;
        this.weight = null;
        return;
      }
      this.weight = input;
    },

    clearFoodData() {
      if(this.selectedFoodId &&
        this.nameInput != this.selectedFoodName) {
        for(let prop in this.nutrients) {
          this.nutrients[prop] = null;
        }
        this.selectedFoodId = null;
        this.selectedFoodName = '';
      }
    }
  },
  mounted() {
    this.$refs.nameInput.focus();
  }
}

const vueApp = Vue.createApp(rootComponent);
vueApp.mount('#vueFoodWeight');