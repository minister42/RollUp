import { Response } from 'express';
import { Review } from '../models/Review';
import { FoodTruck } from '../models/FoodTruck';
import { AuthRequest } from '../middleware/auth';
import { AppError } from '../middleware/errorHandler';

// Get truck reviews
export const getTruckReviews = async (req: AuthRequest, res: Response) => {
  const { truckId } = req.params;
  
  const reviews = await Review.find({ truckId }).sort({ createdAt: -1 });
  
  res.status(200).json({
    success: true,
    data: reviews,
  });
};

// Create review
export const createReview = async (req: AuthRequest, res: Response) => {
  const { truckId } = req.params;
  const userId = req.userId;
  const user = req.user;
  const { rating, comment } = req.body;
  
  // Validate input
  if (!rating || rating < 1 || rating > 5) {
    throw new AppError('Rating must be between 1 and 5', 400);
  }
  
  // Check if truck exists
  const truck = await FoodTruck.findById(truckId);
  if (!truck) {
    throw new AppError('Truck not found', 404);
  }
  
  // Check if user has already reviewed this truck
  const existingReview = await Review.findOne({ truckId, userId });
  if (existingReview) {
    throw new AppError('You have already reviewed this truck', 409);
  }
  
  // Create review
  const review = await Review.create({
    truckId,
    userId,
    userName: user?.displayName,
    userAvatarURL: user?.avatarURL,
    rating,
    comment,
  });
  
  res.status(201).json({
    success: true,
    data: review,
  });
};

// Update review
export const updateReview = async (req: AuthRequest, res: Response) => {
  const { reviewId } = req.params;
  const userId = req.userId;
  const { rating, comment } = req.body;
  
  // Find review
  const review = await Review.findById(reviewId);
  if (!review) {
    throw new AppError('Review not found', 404);
  }
  
  // Check if user owns the review
  if (review.userId.toString() !== userId) {
    throw new AppError('You can only update your own reviews', 403);
  }
  
  // Validate rating if provided
  if (rating && (rating < 1 || rating > 5)) {
    throw new AppError('Rating must be between 1 and 5', 400);
  }
  
  // Build update object
  const updateData: any = {};
  if (rating) updateData.rating = rating;
  if (comment !== undefined) updateData.comment = comment;
  
  // Update review
  const updatedReview = await Review.findByIdAndUpdate(
    reviewId,
    updateData,
    { new: true, runValidators: true }
  );
  
  res.status(200).json({
    success: true,
    data: updatedReview,
  });
};

// Delete review
export const deleteReview = async (req: AuthRequest, res: Response) => {
  const { reviewId } = req.params;
  const userId = req.userId;
  
  // Find review
  const review = await Review.findById(reviewId);
  if (!review) {
    throw new AppError('Review not found', 404);
  }
  
  // Check if user owns the review
  if (review.userId.toString() !== userId) {
    throw new AppError('You can only delete your own reviews', 403);
  }
  
  await Review.findByIdAndDelete(reviewId);
  
  res.status(200).json({
    success: true,
    message: 'Review deleted successfully',
  });
};
