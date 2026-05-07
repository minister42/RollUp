import { Request, Response } from 'express';
import { User } from '../models/User';
import { asyncHandler, AppError } from '../middleware/errorHandler';
import { generateAccessToken, generateRefreshToken, verifyRefreshToken } from '../utils/jwt';

// Sign Up
export const signUp = asyncHandler(async (req: Request, res: Response) => {
  const { email, password, displayName, role } = req.body;
  
  // Validate input
  if (!email || !password || !displayName || !role) {
    throw new AppError('All fields are required', 400);
  }
  
  // Check if user already exists
  const existingUser = await User.findOne({ email });
  if (existingUser) {
    throw new AppError('User with this email already exists', 409);
  }
  
  // Create new user
  const user = await User.create({
    email,
    password,
    displayName,
    role,
  });
  
  // Generate tokens
  const accessToken = generateAccessToken(user.id);
  const refreshToken = generateRefreshToken(user.id);
  
  // Save refresh token
  user.refreshToken = refreshToken;
  await user.save();
  
  res.status(201).json({
    success: true,
    data: {
      user: user.toJSON(),
      accessToken,
      refreshToken,
    },
  });
});

// Sign In
export const signIn = asyncHandler(async (req: Request, res: Response) => {
  const { email, password } = req.body;
  
  // Validate input
  if (!email || !password) {
    throw new AppError('Email and password are required', 400);
  }
  
  // Find user and include password
  const user = await User.findOne({ email }).select('+password');
  if (!user) {
    throw new AppError('Invalid email or password', 401);
  }
  
  // Check password
  const isPasswordValid = await user.comparePassword(password);
  if (!isPasswordValid) {
    throw new AppError('Invalid email or password', 401);
  }
  
  // Generate tokens
  const accessToken = generateAccessToken(user.id);
  const refreshToken = generateRefreshToken(user.id);
  
  // Save refresh token
  user.refreshToken = refreshToken;
  await user.save();
  
  res.status(200).json({
    success: true,
    data: {
      user: user.toJSON(),
      accessToken,
      refreshToken,
    },
  });
});

// Sign Out
export const signOut = asyncHandler(async (req: Request, res: Response) => {
  const userId = (req as any).userId;
  
  // Remove refresh token
  await User.findByIdAndUpdate(userId, { $unset: { refreshToken: 1 } });
  
  res.status(200).json({
    success: true,
    message: 'Signed out successfully',
  });
});

// Refresh Token
export const refreshToken = asyncHandler(async (req: Request, res: Response) => {
  const { refreshToken } = req.body;
  
  if (!refreshToken) {
    throw new AppError('Refresh token is required', 400);
  }
  
  try {
    // Verify refresh token
    const decoded = verifyRefreshToken(refreshToken);
    
    // Find user
    const user = await User.findById(decoded.userId).select('+refreshToken');
    if (!user) {
      throw new AppError('User not found', 404);
    }
    
    // Check if refresh token matches
    if (user.refreshToken !== refreshToken) {
      throw new AppError('Invalid refresh token', 401);
    }
    
    // Generate new tokens
    const newAccessToken = generateAccessToken(user.id);
    const newRefreshToken = generateRefreshToken(user.id);
    
    // Update refresh token
    user.refreshToken = newRefreshToken;
    await user.save();
    
    res.status(200).json({
      success: true,
      data: {
        user: user.toJSON(),
        accessToken: newAccessToken,
        refreshToken: newRefreshToken,
      },
    });
  } catch (error) {
    throw new AppError('Invalid or expired refresh token', 401);
  }
});
