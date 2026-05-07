import { Response } from 'express';
import { User } from '../models/User';
import { AuthRequest } from '../middleware/auth';
import { AppError } from '../middleware/errorHandler';

// Get current user
export const getCurrentUser = async (req: AuthRequest, res: Response) => {
  const userId = req.userId;
  
  const user = await User.findById(userId);
  if (!user) {
    throw new AppError('User not found', 404);
  }
  
  res.status(200).json({
    success: true,
    data: user,
  });
};

// Get user by ID
export const getUserById = async (req: AuthRequest, res: Response) => {
  const { userId } = req.params;
  
  const user = await User.findById(userId);
  if (!user) {
    throw new AppError('User not found', 404);
  }
  
  res.status(200).json({
    success: true,
    data: user,
  });
};

// Update user profile
export const updateUser = async (req: AuthRequest, res: Response) => {
  const { userId } = req.params;
  const currentUserId = req.userId;
  
  // Check if user is updating their own profile
  if (userId !== currentUserId) {
    throw new AppError('You can only update your own profile', 403);
  }
  
  const { displayName, avatarURL, email } = req.body;
  
  // Build update object
  const updateData: any = {};
  if (displayName) updateData.displayName = displayName;
  if (avatarURL !== undefined) updateData.avatarURL = avatarURL;
  if (email) updateData.email = email;
  
  // Update user
  const user = await User.findByIdAndUpdate(
    userId,
    updateData,
    { new: true, runValidators: true }
  );
  
  if (!user) {
    throw new AppError('User not found', 404);
  }
  
  res.status(200).json({
    success: true,
    data: user,
  });
};

// Delete user account
export const deleteUser = async (req: AuthRequest, res: Response) => {
  const { userId } = req.params;
  const currentUserId = req.userId;
  
  // Check if user is deleting their own account
  if (userId !== currentUserId) {
    throw new AppError('You can only delete your own account', 403);
  }
  
  const user = await User.findByIdAndDelete(userId);
  if (!user) {
    throw new AppError('User not found', 404);
  }
  
  res.status(200).json({
    success: true,
    message: 'Account deleted successfully',
  });
};
