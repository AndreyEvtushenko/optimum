import { Router } from 'express';
import { getMainPage, getFoodOnDate, 
  getFoodMatches, getFoodData} from '../controllers/main.js';

const router = Router();

router.get('/', getMainPage);
router.get('/api/date/:pickedDateString', getFoodOnDate);
router.get('/api/food/matches/:input', getFoodMatches);
router.get('/api/food/data/:food_id', getFoodData);

export default router;