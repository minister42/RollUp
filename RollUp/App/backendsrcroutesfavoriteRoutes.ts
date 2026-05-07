import { Router } from 'express';
import {
  getUserFavorites,
  addFavorite,
  removeFavorite,
} from '../controllers/favoriteController';
import { authenticate } from '../middleware/auth';

const router = Router();

router.get('/users/:userId/favorites', authenticate, getUserFavorites);
router.post('/users/:userId/favorites/:truckId', authenticate, addFavorite);
router.delete('/users/:userId/favorites/:truckId', authenticate, removeFavorite);

export default router;
