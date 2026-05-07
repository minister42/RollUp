import { Router } from 'express';
import {
  getCurrentUser,
  getUserById,
  updateUser,
  deleteUser,
} from '../controllers/userController';
import { authenticate } from '../middleware/auth';

const router = Router();

router.get('/me', authenticate, getCurrentUser);
router.get('/:userId', getUserById);
router.patch('/:userId', authenticate, updateUser);
router.delete('/:userId', authenticate, deleteUser);

export default router;
