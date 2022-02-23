import { Router } from 'express';
import { getMainPage, getFoodOnDate} from '../controllers/main.js';

const router = Router();

router.get('/', getMainPage);
router.get('/api/date/:pickedDateString', getFoodOnDate);

export default router;