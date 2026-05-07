import jwt, { SignOptions } from 'jsonwebtoken';

// `expiresIn` was loosely typed as `string | number` through @types/jsonwebtoken
// 9.0.5; in 9.0.7+ it narrowed to `number | StringValue` (a template-literal
// type from the `ms` package). Process env values are bare strings, so we cast
// at the boundary.
type ExpiresIn = SignOptions['expiresIn'];

export const generateAccessToken = (userId: string): string => {
  const jwtSecret = process.env.JWT_SECRET || 'your-secret-key';
  const expiresIn = (process.env.JWT_EXPIRES_IN || '1h') as ExpiresIn;

  return jwt.sign({ userId }, jwtSecret, { expiresIn });
};

export const generateRefreshToken = (userId: string): string => {
  const jwtRefreshSecret = process.env.JWT_REFRESH_SECRET || 'your-refresh-secret';
  const expiresIn = (process.env.JWT_REFRESH_EXPIRES_IN || '7d') as ExpiresIn;

  return jwt.sign({ userId }, jwtRefreshSecret, { expiresIn });
};

export const verifyRefreshToken = (token: string): { userId: string } => {
  const jwtRefreshSecret = process.env.JWT_REFRESH_SECRET || 'your-refresh-secret';
  return jwt.verify(token, jwtRefreshSecret) as { userId: string };
};
