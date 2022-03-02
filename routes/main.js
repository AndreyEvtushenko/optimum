import { Router } from 'express';
import ctrl from '../controllers/main.js';

const router = Router();

router.get('/', ctrl.getMainPage);
router.get('/api/daystat/:date', ctrl.getFoodOnDate);
router.get('/api/food/matches/:input', ctrl.getFoodMatches);
router.get('/api/food/data/:food_id', ctrl.getFoodData);
router.post('/api/daystat', ctrl.postEatenFood);

export default router;