import path from 'path';
//import availFood from '../models/testArrFood.js';
import queryPromise from '../models/getAvailFood.js';
import queryMatchPromise from '../models/getMatchingFood.js';
import queryNutrientsPromise from '../models/getNutrients.js';

const appPath = path.resolve();

function getMainPage(req, res) {
  const options = {
      root: appPath,
      headers: {
          'Content-Type': 'text/html'
      }
  };

  res.sendFile('/views/index.html', options);
}

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

function getFoodOnDate(req, res) {
  console.log(req.params);
  res.end();
}

export { getMainPage, getAvailFood, getMatchingFood, 
  getNutrients, getFoodOnDate };