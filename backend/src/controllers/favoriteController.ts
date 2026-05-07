import { Response } from 'express';
import { Favorite } from '../models/Favorite';
import { FoodTruck } from '../models/FoodTruck';
import { AuthRequest } from '../middleware/auth';
import { asyncHandler, AppError } from '../middleware/errorHandler';

// Get user favorites
export const getUserFavorites = asyncHandler(async (req: AuthRequest, res: Response) => {
  const { userId } = req.params;
  
  // Get favorite records
  const favorites = await Favorite.find({ userId }).populate('truckId');
  
  // Extract trucks from favorites
  const trucks = favorites
    .map(fav => fav.truckId)
    .filter(truck => truck !== null);
  
  res.status(200).json({
    success: true,
    data: trucks,
  });
});

// Add favorite
export const addFavorite = asyncHandler(async (req: AuthRequest, res: Response) => {
  const { userId, truckId } = req.params;
  const currentUserId = req.userId;
  
  // Check if user is adding their own favorite
  if (userId !== currentUserId) {
    throw new AppError('You can only manage your own favorites', 403);
  }
  
  // Check if truck exists
  const truck = await FoodTruck.findById(truckId);
  if (!truck) {
    throw new AppError('Truck not found', 404);
  }
  
  // Check if already favorited
  const existingFavorite = await Favorite.findOne({ userId, truckId });
  if (existingFavorite) {
    throw new AppError('Truck already in favorites', 409);
  }
  
  // Create favorite
  await Favorite.create({ userId, truckId });
  
  res.status(201).json({
    success: true,
    message: 'Truck added to favorites',
  });
});

// Remove favorite
export const removeFavorite = asyncHandler(async (req: AuthRequest, res: Response) => {
  const { userId, truckId } = req.params;
  const currentUserId = req.userId;
  
  // Check if user is removing their own favorite
  if (userId !== currentUserId) {
    throw new AppError('You can only manage your own favorites', 403);
  }
  
  // Find and delete favorite
  const favorite = await Favorite.findOneAndDelete({ userId, truckId });
  if (!favorite) {
    throw new AppError('Favorite not found', 404);
  }
  
  res.status(200).json({
    success: true,
    message: 'Truck removed from favorites',
  });
});
