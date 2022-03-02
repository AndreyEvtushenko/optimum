import db from './connection.js';

export default {
  queryText: '',
  values: [],

  getFoodMatches(input) {
    this.values = ['%' + input + '%'];
    this.queryText = 'SELECT food_id, food_name ' +
      'FROM food ' + 
      'WHERE food_name LIKE ?';
    return new Promise(this.executor.bind(this));
  },

  getFoodData(food_id) {
    this.values = [food_id];
    this.queryText = 'SELECT kcal_1, proteins_1, fats_1, carbohydrates_1 ' +
      'FROM food ' + 
      'WHERE food_id = ?';
    return new Promise(this.executor.bind(this));
  },

  insertEatenFood(providedFoodData) {
    this.values = Object.values(providedFoodData);
    console.log(this.values);
    this.queryText = 'INSERT INTO day_stat ' +
      'SET ' +
      'date = str_to_date(?, "%W %M %d %Y"), ' +
      'user_id = 1, ' + 
      'day_stat_id = ?, ' +
      'food_id = ?, ' +
      'weight = ?';
    return new Promise(this.executor.bind(this));
  },

  executor(resolve, reject) {
    db.query(this.queryText, this.values, (error, results) => {
      if(error) {
        console.log('Something bad happened: ', error.stack);
        reject(error);
      }
      console.log('Query completed successfully');
      resolve(results);
    });
  }
}