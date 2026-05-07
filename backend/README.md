# Food Truck Backend API

A complete REST API backend for the Food Truck mobile application built with Node.js, Express, TypeScript, and MongoDB.

## 🚀 Features

- **Authentication**: JWT-based authentication with access and refresh tokens
- **User Management**: User registration, profile management, role-based access
- **Truck Management**: CRUD operations for food trucks
- **Reviews**: Create, read, update, and delete truck reviews
- **Favorites**: Manage user's favorite trucks
- **Security**: Helmet, CORS, rate limiting, bcrypt password hashing
- **Validation**: Request validation and error handling
- **TypeScript**: Fully typed for better development experience

## 📋 Prerequisites

- Node.js (v20 or higher — LTS)
- MongoDB (v5 or higher) - local or MongoDB Atlas
- npm or yarn

## 🛠️ Installation

### 1. Clone and Install Dependencies

```bash
cd backend
npm install
```

### 2. Environment Setup

Create a `.env` file in the backend directory:

```bash
cp .env.example .env
```

Edit `.env` and configure your settings:

```env
NODE_ENV=development
PORT=3000

# MongoDB - use one of these:
# Local MongoDB:
MONGODB_URI=mongodb://localhost:27017/foodtruck-app

# MongoDB Atlas (production):
# MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/foodtruck-app

# JWT Secrets (CHANGE THESE!)
JWT_SECRET=your-super-secret-jwt-key-change-this-in-production
JWT_REFRESH_SECRET=your-refresh-token-secret-change-this
JWT_EXPIRES_IN=1h
JWT_REFRESH_EXPIRES_IN=7d

# CORS
ALLOWED_ORIGINS=http://localhost:3000,http://localhost:8080

# Rate Limiting
RATE_LIMIT_WINDOW_MS=900000
RATE_LIMIT_MAX_REQUESTS=100

API_VERSION=v1
```

### 3. Start MongoDB

**Local MongoDB:**
```bash
mongod
```

**MongoDB Atlas:**
- Create a cluster at [mongodb.com/cloud/atlas](https://www.mongodb.com/cloud/atlas)
- Get your connection string
- Add it to `.env` as `MONGODB_URI`

### 4. Run the Server

**Development mode (with auto-reload):**
```bash
npm run dev
```

**Production build:**
```bash
npm run build
npm start
```

The server will start on `http://localhost:3000`

## 📚 API Endpoints

Base URL: `http://localhost:3000/v1`

### Authentication

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| POST | `/auth/signup` | Register new user | No |
| POST | `/auth/signin` | Sign in user | No |
| POST | `/auth/signout` | Sign out user | Yes |
| POST | `/auth/refresh` | Refresh access token | No |

### Users

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| GET | `/users/me` | Get current user | Yes |
| GET | `/users/:userId` | Get user by ID | No |
| PATCH | `/users/:userId` | Update user profile | Yes (own profile) |
| DELETE | `/users/:userId` | Delete user account | Yes (own account) |

### Trucks

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| GET | `/trucks` | Get all trucks | No |
| GET | `/trucks/:truckId` | Get single truck | No |
| POST | `/trucks` | Create truck | Yes (truck owner) |
| PATCH | `/trucks/:truckId` | Update truck | Yes (owner) |
| DELETE | `/trucks/:truckId` | Delete truck | Yes (owner) |
| GET | `/trucks/owner/:ownerId` | Get trucks by owner | No |
| GET | `/trucks/search?q=query` | Search trucks | No |

### Reviews

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| GET | `/trucks/:truckId/reviews` | Get truck reviews | No |
| POST | `/trucks/:truckId/reviews` | Create review | Yes |
| PATCH | `/reviews/:reviewId` | Update review | Yes (owner) |
| DELETE | `/reviews/:reviewId` | Delete review | Yes (owner) |

### Favorites

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| GET | `/users/:userId/favorites` | Get user favorites | Yes |
| POST | `/users/:userId/favorites/:truckId` | Add favorite | Yes |
| DELETE | `/users/:userId/favorites/:truckId` | Remove favorite | Yes |

## 📝 Example API Calls

### Sign Up

```bash
curl -X POST http://localhost:3000/v1/auth/signup \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user@example.com",
    "password": "password123",
    "displayName": "John Doe",
    "role": "eater"
  }'
```

Response:
```json
{
  "success": true,
  "data": {
    "user": {
      "id": "...",
      "email": "user@example.com",
      "displayName": "John Doe",
      "role": "eater",
      "createdAt": "...",
      "updatedAt": "..."
    },
    "accessToken": "eyJhbGc...",
    "refreshToken": "eyJhbGc..."
  }
}
```

### Sign In

```bash
curl -X POST http://localhost:3000/v1/auth/signin \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user@example.com",
    "password": "password123"
  }'
```

### Get All Trucks

```bash
curl http://localhost:3000/v1/trucks
```

### Create Truck (Authenticated)

```bash
curl -X POST http://localhost:3000/v1/trucks \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -d '{
    "name": "Taco Paradise",
    "description": "Authentic Mexican street tacos",
    "cuisineType": "Mexican",
    "coordinate": {
      "latitude": 37.7749,
      "longitude": -122.4194
    }
  }'
```

### Create Review (Authenticated)

```bash
curl -X POST http://localhost:3000/v1/trucks/TRUCK_ID/reviews \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -d '{
    "rating": 5,
    "comment": "Amazing tacos!"
  }'
```

## 🏗️ Project Structure

```
backend/
├── src/
│   ├── config/
│   │   └── database.ts          # MongoDB connection
│   ├── controllers/
│   │   ├── authController.ts    # Authentication logic
│   │   ├── userController.ts    # User operations
│   │   ├── truckController.ts   # Truck operations
│   │   ├── reviewController.ts  # Review operations
│   │   └── favoriteController.ts # Favorite operations
│   ├── middleware/
│   │   ├── auth.ts              # JWT authentication
│   │   ├── errorHandler.ts      # Error handling
│   │   └── rateLimiter.ts       # Rate limiting
│   ├── models/
│   │   ├── User.ts              # User model
│   │   ├── FoodTruck.ts         # Food truck model
│   │   ├── Review.ts            # Review model
│   │   └── Favorite.ts          # Favorite model
│   ├── routes/
│   │   ├── authRoutes.ts        # Auth endpoints
│   │   ├── userRoutes.ts        # User endpoints
│   │   ├── truckRoutes.ts       # Truck endpoints
│   │   ├── reviewRoutes.ts      # Review endpoints
│   │   ├── favoriteRoutes.ts    # Favorite endpoints
│   │   └── index.ts             # Route aggregation
│   ├── utils/
│   │   └── jwt.ts               # JWT utilities
│   └── index.ts                 # App entry point
├── .env.example                 # Environment template
├── .gitignore
├── package.json
└── tsconfig.json
```

## 🔒 Security Features

- **Password Hashing**: bcrypt with salt rounds
- **JWT Authentication**: Secure token-based auth
- **Helmet**: Security headers
- **CORS**: Cross-origin resource sharing control
- **Rate Limiting**: Prevent brute force attacks
- **Input Validation**: Mongoose schema validation
- **Error Handling**: Secure error messages (no stack traces in production)

## 🧪 Testing

Test endpoints using:
- **Postman**: Import the API collection
- **cURL**: Use the example commands above
- **iOS App**: Update `APIConfiguration.swift` with your backend URL

### Health Check

```bash
curl http://localhost:3000/health
```

Response:
```json
{
  "status": "OK",
  "timestamp": "2024-03-28T10:30:00.000Z",
  "uptime": 123.456
}
```

## 🚢 Deployment

### Deploy to Heroku

```bash
# Login to Heroku
heroku login

# Create app
heroku create foodtruck-api

# Add MongoDB Atlas addon or use external MongoDB
heroku addons:create mongolab:sandbox

# Set environment variables
heroku config:set JWT_SECRET=your-secret
heroku config:set JWT_REFRESH_SECRET=your-refresh-secret
heroku config:set NODE_ENV=production

# Deploy
git push heroku main
```

### Deploy to Railway

1. Push code to GitHub
2. Go to [railway.app](https://railway.app)
3. Create new project from GitHub repo
4. Add MongoDB plugin
5. Set environment variables
6. Deploy

### Deploy to DigitalOcean

1. Create a Droplet
2. Install Node.js and MongoDB
3. Clone repository
4. Set up environment variables
5. Use PM2 for process management
6. Set up nginx as reverse proxy

## 📊 Database Schema

### User
```typescript
{
  email: string (unique)
  password: string (hashed)
  displayName: string
  role: 'eater' | 'truckOwner'
  avatarURL?: string
  createdAt: Date
  updatedAt: Date
}
```

### FoodTruck
```typescript
{
  ownerId: ObjectId (ref: User)
  name: string
  description: string
  cuisineType: CuisineType
  coordinate: { latitude: number, longitude: number }
  isOpen: boolean
  tier: 'free' | 'basic' | 'premium'
  socialLinks: { instagram?, facebook?, twitter?, website? }
  heroImageName?: string
  averageRating: number
  reviewCount: number
  isPromoted: boolean
  createdAt: Date
  updatedAt: Date
}
```

### Review
```typescript
{
  truckId: ObjectId (ref: FoodTruck)
  userId: ObjectId (ref: User)
  userName: string
  userAvatarURL?: string
  rating: number (1-5)
  comment?: string
  createdAt: Date
  updatedAt: Date
}
```

### Favorite
```typescript
{
  userId: ObjectId (ref: User)
  truckId: ObjectId (ref: FoodTruck)
  createdAt: Date
}
```

## 🐛 Troubleshooting

### MongoDB Connection Error
- Ensure MongoDB is running: `mongod`
- Check connection string in `.env`
- For Atlas: whitelist your IP address

### Port Already in Use
```bash
# Find process using port 3000
lsof -i :3000

# Kill the process
kill -9 PID
```

### JWT Errors
- Ensure `JWT_SECRET` and `JWT_REFRESH_SECRET` are set
- Check token expiration times
- Verify token is sent in `Authorization: Bearer TOKEN` header

## 📖 Additional Resources

- [Express.js Documentation](https://expressjs.com/)
- [MongoDB Documentation](https://docs.mongodb.com/)
- [Mongoose Documentation](https://mongoosejs.com/)
- [JWT.io](https://jwt.io/)

## 📄 License

MIT

## 🤝 Support

For issues or questions, please create an issue in the repository.
