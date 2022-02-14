import path from 'path';
//import availFood from '../models/testArrFood.js';
import queryPromise from '../models/getAvailFood.js';

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

export { getMainPage, getAvailFood };