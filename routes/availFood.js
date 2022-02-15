import { Router } from 'express';
import { getAvailFood, getMatchingFood, getNutrients } from '../controllers/main.js';

const router = Router();

router.get('/api/availFood', getAvailFood);
router.get('/api/matchingFood/:nameInput', 
  getMatchingFood);
router.get('/api/food/:food_id', getNutrients);

export default router;