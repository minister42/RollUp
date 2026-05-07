import { Router } from 'express';
import authRoutes from './authRoutes';
import userRoutes from './userRoutes';
import truckRoutes from './truckRoutes';
import reviewRoutes from './reviewRoutes';
import favoriteRoutes from './favoriteRoutes';

const router = Router();

// Mount routes
router.use('/auth', authRoutes);
router.use('/users', userRoutes);
router.use('/trucks', truckRoutes);
router.use('/', reviewRoutes); // Reviews routes include their own paths
router.use('/', favoriteRoutes); // Favorites routes include their own paths

export default router;
