export default function(f) {
  return function(...args) {
    return new Promise((resolve, reject) => {
      function callback(error, results) {
        if(error) {
          console.log('Something bad happened: ');
          reject(error);
        } else {
          console.log('Query completed successfully');
          resolve(results);
        }
      }
      args.push(callback);
      f(...args);
    });
  }
}