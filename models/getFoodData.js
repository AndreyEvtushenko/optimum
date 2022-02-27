import { connection } from './bd_connect.js';

export default queryFoodData;

function queryFoodData(food_id) {
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
      
      resolve(results[0]);
    });
  });
}