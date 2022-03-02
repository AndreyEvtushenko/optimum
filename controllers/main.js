import path from 'path';
import queries from '../models/queries.js';

const appPath = path.resolve();

export default {
  getMainPage(req, res) {
    const options = {
        root: appPath,
        headers: {
            'Content-Type': 'text/html'
        }
    };

    res.sendFile('/views/index.html', options);
  },

  async getFoodMatches(req, res) {
    const substr = req.params.input;
    const matchingFood = await queries.getFoodMatches(substr);
    res.json(matchingFood);
  },

  async getFoodData(req, res) {
    const food_id = req.params.food_id;
    const foodData = await queries.getFoodData(food_id);
    res.json(foodData[0]);
  },

  getFoodOnDate(req, res) {
    console.log(req.params);
    res.end();
  },

  async postEatenFood(req, res) {
    const eatenFood = req.body;
    await queries.insertEatenFood(eatenFood);
    res.end();
  }
}