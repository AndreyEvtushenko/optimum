import { Router } from 'express';
import ctrl from '../controllers/main.js';

const router = Router();

router.get('/', ctrl.getMainPage);
router.get('/api/daystat/:date', ctrl.getFoodOnDate);
router.get('/api/food/matches/:input', ctrl.getFoodMatches);
router.get('/api/food/data/:food_id', ctrl.getFoodData);
router.post('/api/daystat', ctrl.postEatenFood);
router.delete('/api/daystat/:date/:day_stat_id', ctrl.delEatenFood);
router.get('/api/totalstat/:date', ctrl.getDayTotalStat);
router.post('/api/totalstat/:date', ctrl.postDayTotalStat);
router.patch('/api/totalstat/:date', ctrl.patchDayTotalStat);

export default router;