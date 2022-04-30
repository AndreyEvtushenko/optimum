import express from 'express';
import mainRouter from './routes/main.js';

const expressApp = express();
const PORT = process.env.PORT || 8080;

expressApp.use(express.json());
expressApp.use(express.static('views'));
expressApp.use(mainRouter);

expressApp.listen(PORT, () => {
  console.log(`Optimum app is listening on port ${PORT}...`);
});