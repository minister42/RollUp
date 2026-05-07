import { Router } from 'express';
import {
  getTruckReviews,
  createReview,
  updateReview,
  deleteReview,
} from '../controllers/reviewController';
import { authenticate, optionalAuth } from '../middleware/auth';

const router = Router();

// Reviews for a specific truck
router.get('/trucks/:truckId/reviews', optionalAuth, getTruckReviews);
router.post('/trucks/:truckId/reviews', authenticate, createReview);

// Individual review operations
router.patch('/reviews/:reviewId', authenticate, updateReview);
router.delete('/reviews/:reviewId', authenticate, deleteReview);

export default router;
