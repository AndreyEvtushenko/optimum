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

  console.log('Connected to the Optimum DB with id:', connection.threadId);
});

export {connection};

/* const optimum_db = {
  options: {
    host: 'localhost',
    port: 3306,
    user: 'optimum_sys',
    password: 'Let_me_in2',
    database: 'optimum'
  },
  connection,
  create() {
    this.connection = mysql.createConnection(options);
  },
  async connect() {
    this.create();
    await this.promisifyConnect();
    return this.connection;
  },
  promisifyConnect() {
    return new Promise((resolve, reject) => {
      this.connection.connect( error => {
        if(error) {
          console.log('Something bad happened:',
           err.stack);
          reject(error);
        }      
        console.log('Connected to the Optimum DB with id:', 
          this.connection.threadId);
        resolve();
      });
    });
  }
} */