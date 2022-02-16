import { connection } from './bd_connect.js';

export default queryPromise;

function queryPromise(food_id) {
  return new Promise((resolve, reject) => {
    const values = [food_id];
    const query = 'SELECT kcal_1, proteins_1, fats_1, carbohydrates_1 ' +
      'FROM food ' + 
      'WHERE food_id = ?';

    connection.query(query, values, (error, results, fields) => {
      if(error) {
        console.log('Something bad happened: ', error.stack);
        reject(error);
      }
      
    const nutrients = transformResults(results);
    resolve(nutrients);
    });
  });
}

function transformResults(results) {
  const nutrients = {};

  nutrients.kcal = results[0].kcal_1;
  nutrients.proteins = results[0].proteins_1;
  nutrients.fats = results[0].fats_1;
  nutrients.carbohydrates = results[0].carbohydrates_1;

  return nutrients;
}