import { Router } from 'express';
import { getMainPage } from '../controllers/main.js';

const router = Router();

router.get('/', getMainPage);

export default router;