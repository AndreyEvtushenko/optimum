import path from 'path';
//import availFood from '../models/testArrFood.js';
import queryPromise from '../models/getAvailFood.js';
import queryMatchPromise from '../models/getMatchingFood.js';

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
  const substr = req.params.foodNameInput;
  const matchingFood = await queryMatchPromise(substr);
  res.json(matchingFood);
}

export { getMainPage, getAvailFood, getMatchingFood };