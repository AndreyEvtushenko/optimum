import { connection } from './bd_connect.js';

export default queryPromise;

function queryPromise(substr) {
  return new Promise((resolve, reject) => {
    const pattern = '%' + substr + '%';
    const values = [pattern];
    const query = 'SELECT food_id, food_name ' +
      'FROM food ' + 
      'WHERE food_name LIKE ?';
    connection.query(query, values, (error, results, fields) => {
      if(error) {
        console.log('Something bad happened: ', error.stack);
        reject(error);
      }
      console.log('query is done');
      resolve(results);
    });
  });
}