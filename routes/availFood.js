import { Router } from 'express';
import { getAvailFood, getMatchingFood } from '../controllers/main.js';

const router = Router();

router.get('/api/availFood', getAvailFood);
router.get('/api/matchingFood/:foodNameInput', 
  getMatchingFood);

export default router;