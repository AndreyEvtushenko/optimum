import { connection } from './bd_connect.js';

export default queryPromise;

function queryPromise() {  
  return new Promise((resolve, reject) => {
    const query = `SELECT food_id, food_name from food`;
    connection.query(query, (error, results, fields) => {
      if(error) {
        console.log('Something bad happened: ',
          error.stack);
        reject(error);
      }
      console.log('query is done');
      resolve(results);
    });
  });
}