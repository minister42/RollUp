import { Router } from 'express';
import { signUp, signIn, signOut, refreshToken } from '../controllers/authController';
import { authenticate } from '../middleware/auth';
import { strictRateLimiter } from '../middleware/rateLimiter';

const router = Router();

router.post('/signup', strictRateLimiter, signUp);
router.post('/signin', strictRateLimiter, signIn);
router.post('/signout', authenticate, signOut);
router.post('/refresh', refreshToken);

export default router;
