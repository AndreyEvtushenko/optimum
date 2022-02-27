import path from 'path';
import queries from '../models/queries.js';

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

async function getFoodMatches(req, res) {
  const substr = req.params.input;
  const matchingFood = await queries.getFoodMatches(substr);
  res.json(matchingFood);
}

async function getFoodData(req, res) {
  const food_id = req.params.food_id;
  const foodData = await queries.getFoodData(food_id);
  res.json(foodData[0]);
}

function getFoodOnDate(req, res) {
  console.log(req.params);
  res.end();
}

export { getMainPage, getFoodOnDate, getFoodMatches, getFoodData };