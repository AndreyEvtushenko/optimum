import express from 'express';

const expressApp = express();
const port = 3000;

expressApp.use(express.json());
expressApp.use(express.static('static'));

expressApp.listen(port, () => {
    console.log(`Optimum app is listening on port ${port}...`);
});