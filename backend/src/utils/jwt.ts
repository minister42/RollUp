import jwt from 'jsonwebtoken';

export const generateAccessToken = (userId: string): string => {
  const jwtSecret = process.env.JWT_SECRET || 'your-secret-key';
  const expiresIn = process.env.JWT_EXPIRES_IN || '1h';
  
  return jwt.sign({ userId }, jwtSecret, { expiresIn });
};

export const generateRefreshToken = (userId: string): string => {
  const jwtRefreshSecret = process.env.JWT_REFRESH_SECRET || 'your-refresh-secret';
  const expiresIn = process.env.JWT_REFRESH_EXPIRES_IN || '7d';
  
  return jwt.sign({ userId }, jwtRefreshSecret, { expiresIn });
};

export const verifyRefreshToken = (token: string): { userId: string } => {
  const jwtRefreshSecret = process.env.JWT_REFRESH_SECRET || 'your-refresh-secret';
  return jwt.verify(token, jwtRefreshSecret) as { userId: string };
};
