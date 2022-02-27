import mysql from 'mysql';

const connection = mysql.createConnection({
  host: 'localhost',
  port: 3306,
  user: 'optimum_sys',
  password: 'Let_me_in2',
  database: 'optimum'
});

connection.connect( err => {
  if(err) {
    console.log('Something bad happened: ' + err.stack);
    return;
  }

  console.log('Connected to the Optimum DB with id:', 
    connection.threadId);
});

export default connection;