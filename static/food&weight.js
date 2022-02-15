const rootComponent = {
  data() {
    return {
      availFood: [],
      nameInput: '',
      noMatches: false,
      selectedFoodId: null,
      weightInput: null,
      nutrients: {
        kcal_weight: null,
        proteins_weight: null,
        fats_weight: null,
        carbohydrates_weight: null,
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
        if(this.availFood.length == 0) this.noMatches = true;
        else this.noMatches = false;
        return;
      }
      this.availFood = [];
    },

    async selectThisFood(food) {
      this.nameInput = food.food_name;
      this.selectedFoodId = food.food_id;
      this.availFood = [];
    },

    async getNutrients(food_id) {
      const url = `/api/food/${food_id}`;
      const res = await fetch(url);
      const nutrients = await res.json();
      Object.assign(this.nutrients, nutrients);
    }
  },
  mounted() {
    this.$refs.nameInput.focus();
  }
}

const vueApp = Vue.createApp(rootComponent);
vueApp.mount('#vueFoodWeight');