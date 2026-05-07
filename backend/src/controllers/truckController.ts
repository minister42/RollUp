import { Response } from 'express';
import { FoodTruck } from '../models/FoodTruck';
import { AuthRequest } from '../middleware/auth';
import { AppError } from '../middleware/errorHandler';
import { UserRole } from '../models/User';

// Get all trucks
export const getAllTrucks = async (_req: AuthRequest, res: Response) => {
  const trucks = await FoodTruck.find().sort({ createdAt: -1 });
  
  res.status(200).json({
    success: true,
    data: trucks,
  });
};

// Get single truck
export const getTruck = async (req: AuthRequest, res: Response) => {
  const { truckId } = req.params;
  
  const truck = await FoodTruck.findById(truckId);
  if (!truck) {
    throw new AppError('Truck not found', 404);
  }
  
  res.status(200).json({
    success: true,
    data: truck,
  });
};

// Create truck
export const createTruck = async (req: AuthRequest, res: Response) => {
  const userId = req.userId;
  const user = req.user;
  
  // Check if user is a truck owner
  if (user?.role !== UserRole.TRUCK_OWNER) {
    throw new AppError('Only truck owners can create trucks', 403);
  }
  
  const {
    name,
    description,
    cuisine,
    logoURL,
    bannerURL,
    coordinate,
    cuisineType,
  } = req.body;
  
  // Validate required fields
  if (!name || !description) {
    throw new AppError('Name and description are required', 400);
  }
  
  // Create truck
  const truck = await FoodTruck.create({
    ownerId: userId,
    name,
    description,
    cuisineType: cuisineType || cuisine || 'Other',
    coordinate: coordinate || { latitude: 0, longitude: 0 },
    heroImageName: logoURL || bannerURL,
  });
  
  res.status(201).json({
    success: true,
    data: truck,
  });
};

// Update truck
export const updateTruck = async (req: AuthRequest, res: Response) => {
  const { truckId } = req.params;
  const userId = req.userId;
  
  // Find truck
  const truck = await FoodTruck.findById(truckId);
  if (!truck) {
    throw new AppError('Truck not found', 404);
  }
  
  // Check if user owns the truck
  if (truck.ownerId.toString() !== userId) {
    throw new AppError('You can only update your own trucks', 403);
  }
  
  const {
    name,
    description,
    cuisine,
    cuisineType,
    logoURL,
    bannerURL,
    isActive,
    isOpen,
    coordinate,
  } = req.body;
  
  // Build update object
  const updateData: any = {};
  if (name) updateData.name = name;
  if (description) updateData.description = description;
  if (cuisineType || cuisine) updateData.cuisineType = cuisineType || cuisine;
  if (logoURL || bannerURL) updateData.heroImageName = logoURL || bannerURL;
  if (typeof isActive !== 'undefined') updateData.isOpen = isActive;
  if (typeof isOpen !== 'undefined') updateData.isOpen = isOpen;
  if (coordinate) updateData.coordinate = coordinate;
  
  // Update truck
  const updatedTruck = await FoodTruck.findByIdAndUpdate(
    truckId,
    updateData,
    { new: true, runValidators: true }
  );
  
  res.status(200).json({
    success: true,
    data: updatedTruck,
  });
};

// Delete truck
export const deleteTruck = async (req: AuthRequest, res: Response) => {
  const { truckId } = req.params;
  const userId = req.userId;
  
  // Find truck
  const truck = await FoodTruck.findById(truckId);
  if (!truck) {
    throw new AppError('Truck not found', 404);
  }
  
  // Check if user owns the truck
  if (truck.ownerId.toString() !== userId) {
    throw new AppError('You can only delete your own trucks', 403);
  }
  
  await FoodTruck.findByIdAndDelete(truckId);
  
  res.status(200).json({
    success: true,
    message: 'Truck deleted successfully',
  });
};

// Get trucks by owner
export const getTrucksByOwner = async (req: AuthRequest, res: Response) => {
  const { ownerId } = req.params;
  
  const trucks = await FoodTruck.find({ ownerId }).sort({ createdAt: -1 });
  
  res.status(200).json({
    success: true,
    data: trucks,
  });
};

// Search trucks
export const searchTrucks = async (req: AuthRequest, res: Response) => {
  // `location` is read from req.query for future geospatial search;
  // currently unused but kept in the API contract.
  const { q: query } = req.query;
  
  const searchQuery: any = {};
  
  if (query) {
    searchQuery.$text = { $search: query as string };
  }
  
  // Note: Location-based search would require geospatial queries
  // This is a simple implementation
  
  const trucks = await FoodTruck.find(searchQuery).sort({ averageRating: -1 });
  
  res.status(200).json({
    success: true,
    data: trucks,
  });
};
