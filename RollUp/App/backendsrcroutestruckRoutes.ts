import { Router } from 'express';
import {
  getAllTrucks,
  getTruck,
  createTruck,
  updateTruck,
  deleteTruck,
  getTrucksByOwner,
  searchTrucks,
} from '../controllers/truckController';
import { authenticate, optionalAuth } from '../middleware/auth';

const router = Router();

router.get('/', optionalAuth, getAllTrucks);
router.get('/search', optionalAuth, searchTrucks);
router.get('/owner/:ownerId', getTrucksByOwner);
router.get('/:truckId', getTruck);
router.post('/', authenticate, createTruck);
router.patch('/:truckId', authenticate, updateTruck);
router.delete('/:truckId', authenticate, deleteTruck);

export default router;
