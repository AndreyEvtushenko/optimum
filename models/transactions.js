import db from './connection.js';
import promisify from '../libs/promisify.js';

export default {
  cookedAssignedId: null,
  cooked: [],
  ingridients: [],

  cookedQuery: 'INSERT INTO food ' +
    'SET ' +
    'food_name = ?, ' +
    'weight = ?, ' +
    'is_dish = 1, ' +
    'date = str_to_date(?, "%W %M %d %Y"), ' +
    'kcal_1 = ?, ' +
    'proteins_1 = ?, ' +
    'fats_1 = ?, ' +
    'carbohydrates_1 = ?',

  ingridientQuery: 'INSERT INTO ingridients ' +
    'SET ' +
    'ingridient_id = ?, ' +
    'weight = ?, ' +
    'dish_id = ?',

  async insertCookedAndIngrs(cooked) {
    this.processReceivedData(cooked);

    const started = await this.startTransaction();
    if(!started)
      return false;

    const cookedInserted = await this.insertCooked();
    if(!cookedInserted)
      return false;

    this.addCookedIdToIngrs();

    const ingridientsInserted = await this.insertIngridients();
    if(!ingridientsInserted)
      return false;

    const commited = await this.commit();
    if(!commited)
      return false;

    return this.cookedAssignedId;
  },

  processReceivedData(cooked) {
    this.ingridients = cooked.ingridients;
    delete cooked.ingridients;
    this.cooked = Object.values(cooked);
  },

  async startTransaction() {
    try {
      const transaction = promisify(db.beginTransaction.bind(db))
      await transaction();
      return true;
    } catch(error) {
      console.log(error);
      return false;
    }
  },

  async insertCooked() {
    try {
      const query = promisify(db.query.bind(db));
      const result = await query(this.cookedQuery, this.cooked);
      this.cookedAssignedId = result.insertId;
      return true;
    } catch(error) {
      console.log(error);
      await this.rollback();
      return false;
    }
  },

  rollback() {
    return new Promise(resolve => {
      db.rollback(() => resolve(true));
    });
  },

  addCookedIdToIngrs() {
    this.ingridients = this.ingridients.map(item => {
      const arr = Object.values(item);
      arr.push(this.cookedAssignedId);
      return arr;
    });
  },

  async insertIngridients() {
    try {
      const query = promisify(db.query.bind(db));
      for(let ingridient of this.ingridients) {
        await query(this.ingridientQuery, ingridient);
      }
      return true;
    } catch (error) {
      console.log(error);
      await this.rollback();
      return false;
    }
  },

  async commit() {
    try {
      const commit = promisify(db.commit.bind(db));
      await commit();
      return true;
    } catch (error) {
      console.log(error);
      await this.rollback();
      return false;
    }
  }
}