async function getAvailFood(req, res) {
  const allAvailFood = await queryPromise();
  res.json(allAvailFood);
}

async function getMatchingFood(req, res) {
  const substr = req.params.nameInput;
  const matchingFood = await queryMatchPromise(substr);
  res.json(matchingFood);
}

async function getNutrients(req, res) {
  const food_id = req.params.food_id;
  const nutrients = await queryNutrientsPromise(food_id);
  res.json(nutrients);
}