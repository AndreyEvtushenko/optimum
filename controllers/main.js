import path from 'path';
import queries from '../models/queries.js';
import transactions from '../models/transactions.js';

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

  async getFoodOnDate(req, res) {
    const date = req.params.date;
    const foodOnDate = await queries.getFoodOnDate(date);
    //stored procedure returns array with result array and 
    //object with additional info
    res.json(foodOnDate[0]);
  },

  async postEatenFood(req, res) {
    const eatenFood = req.body;
    await queries.insertEatenFood(eatenFood);
    res.end();
  },

  async delEatenFood(req, res) {
    const date = req.params.date;
    const day_stat_id = req.params.day_stat_id;
    await queries.delEatenFood(date, day_stat_id);
    res.end();
  },

  async getDayTotalStat(req, res) {
    const date = req.params.date;
    const dayTotalStat = await queries.getDayTotalStat(date);
    //stored procedure returns array with result array and 
    //object with additional info
    res.json(dayTotalStat[0]); 
  },

  async postDayTotalStat(req, res) {
    const dayTotalStat = req.body;
    const date = req.params.date;
    await queries.insertDayTotalStat(dayTotalStat, date);
    res.end();
  },

  async patchDayTotalStat(req, res) {
    const dayTotalStat = req.body;
    const date = req.params.date;
    await queries.updateDayTotalStat(dayTotalStat, date);
    res.end();
  },

  async delDayTotalStat(req, res) {
    const date = req.params.date;
    await queries.delDayTotalStat(date);
    res.end();
  },

  async postProduct(req, res) {
    const product = req.body;
    const result = await queries.insertProduct(product);
    res.json(result.insertId);
  },

  async getProducts(req, res) {
    const products = await queries.getProducts();
    res.json(products);
  },

  async patchProduct(req, res) {
    const productId = req.params.id;
    const newValues = req.body;
    await queries.updateProduct(newValues, productId);
    res.end();
  },

  async delProduct(req, res) {
    const productId = req.params.id;
    try {
      const result = await queries.delProduct(productId);
      res.json(result.affectedRows);
    } catch(error) {
      console.log(error.code);
      res.json(error.code);
    }
  },

  async postCookedAndIngrs(req, res) {
    const cooked = req.body;
    const result = await transactions.insertCookedAndIngrs(cooked);
    res.json(result);
  },

  async getLastCooked(req, res) {
    const count = req.params.count;
    const result = await queries.getLastCooked(count);
    res.json(result[0]);
  },

  async getIngridients(req, res) {
    const cookedId = req.params.id;
    const result = await queries.getIngridients(cookedId);
    res.json(result[0]);
  },

  async patchCooked(req, res) {
    const cookedId = req.params.id;
    const newValues = req.body;
    const result = await queries.updateCooked(newValues, cookedId);
    res.json(result.changedRows);
  },

  async patchCookedAndIngrs(req, res) {
    const cookedId = req.params.id;
    const newValues = req.body;
    const result = await transactions
      .updateCookedAndIngrs(newValues, cookedId);
    res.json(result);
  },

  async delCooked(req, res) {
    const cookedId = req.params.id;
    try {
      const result = await queries.delCooked(cookedId);
      res.json(result.affectedRows);
    } catch(error) {
      console.log(error.code);
      res.json(error.code);
    }
  },

  async getFirstFromLastCooked(req, res) {
    const count = req.params.count;
    const result = await queries.getFirstFromLastCooked(count);
    res.json(result[0][0]);
  },  
}