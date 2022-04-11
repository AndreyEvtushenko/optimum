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
router.delete('/api/totalstat/:date', ctrl.delDayTotalStat);
router.post('/api/product', ctrl.postProduct);
router.get('/api/products', ctrl.getProducts);
router.patch('/api/product/:id', ctrl.patchProduct);
router.delete('/api/product/:id', ctrl.delProduct);
router.post('/api/cooked', ctrl.postCookedAndIngrs);
router.get('/api/cooked/last/:count', ctrl.getLastCooked);
router.get('/api/cooked/matches/:input', ctrl.getCookedMatches);
router.get('/api/cooked/ingrs/:id', ctrl.getIngridients);
router.patch('/api/cooked/:id', ctrl.patchCooked);
router.patch('/api/cooked/whole/:id', ctrl.patchCookedAndIngrs);
router.delete('/api/cooked/:id', ctrl.delCooked);
router.get('/api/cooked/first/:count', ctrl.getFirstFromLastCooked);

export default router;