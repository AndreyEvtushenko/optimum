import express from 'express';
//import { connection } from './models/db_connect.js';
import mainRouter from './routes/main.js';
//import availFoodRouter from './routes/availFood.js';

const expressApp = express();
const port = 8080;

expressApp.use(express.json());
expressApp.use(express.static('static'));
expressApp.use(mainRouter);
//expressApp.use(availFoodRouter);

expressApp.listen(port, () => {
  console.log(`Optimum app is listening on port ${port}...`);
});