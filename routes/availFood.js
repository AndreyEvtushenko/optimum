import { Router } from 'express';
import { getAvailFood } from '../controllers/main.js';

const router = Router();

router.get('/api/availFood', getAvailFood);

export default router;