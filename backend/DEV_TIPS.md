# 🛠️ Development Tips & Best Practices

## 🔥 Hot Tips for Development

### 1. Testing with curl

**Sign in and save token:**
```bash
# Sign in
TOKEN=$(curl -X POST http://localhost:3000/v1/auth/signin \
  -H "Content-Type: application/json" \
  -d '{"email":"alex@example.com","password":"password123"}' \
  -s | jq -r '.data.accessToken')

# Use token in subsequent requests
curl http://localhost:3000/v1/users/me \
  -H "Authorization: Bearer $TOKEN"
```

### 2. Database Management

**View database in MongoDB Compass:**
- Download: https://www.mongodb.com/products/compass
- Connect to: `mongodb://localhost:27017`
- Browse collections visually

**MongoDB Shell Commands:**
```bash
# Connect to database
mongosh foodtruck-app

# View collections
show collections

# View users
db.users.find().pretty()

# View trucks
db.foodtrucks.find().pretty()

# Clear all data
db.users.deleteMany({})
db.foodtrucks.deleteMany({})
db.reviews.deleteMany({})
db.favorites.deleteMany({})

# Then re-seed
npm run seed
```

### 3. Debugging

**Add debug logging:**
```typescript
// In any controller
console.log('🔍 Debug:', { userId, truckId, data });
```

**VS Code Debug Configuration** (`.vscode/launch.json`):
```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "node",
      "request": "launch",
      "name": "Debug API",
      "runtimeExecutable": "npm",
      "runtimeArgs": ["run", "dev"],
      "skipFiles": ["<node_internals>/**"]
    }
  ]
}
```

### 4. Environment Variables

**Multiple environments:**
```bash
# Development
cp .env.example .env.development

# Production
cp .env.example .env.production

# Use specific env file
NODE_ENV=production node -r dotenv/config dist/index.js dotenv_config_path=.env.production
```

### 5. Testing API Endpoints

**Use HTTPie (better than curl):**
```bash
brew install httpie

# Sign in
http POST localhost:3000/v1/auth/signin email=alex@example.com password=password123

# Get trucks
http GET localhost:3000/v1/trucks

# Create truck (with auth)
http POST localhost:3000/v1/trucks \
  Authorization:"Bearer YOUR_TOKEN" \
  name="New Truck" \
  description="Great food" \
  cuisineType="Mexican" \
  coordinate:='{"latitude":37.7749,"longitude":-122.4194}'
```

## 🚨 Common Issues & Solutions

### Issue: "Cannot find module"
**Solution:**
```bash
rm -rf node_modules package-lock.json
npm install
```

### Issue: "Port 3000 is already in use"
**Solution:**
```bash
# Find process
lsof -i :3000

# Kill process
kill -9 <PID>

# Or use different port
PORT=3001 npm run dev
```

### Issue: "MongoDB connection failed"
**Solution:**
```bash
# Check if MongoDB is running
ps aux | grep mongod

# Start MongoDB
brew services start mongodb-community  # macOS
sudo systemctl start mongod            # Linux
net start MongoDB                      # Windows

# Check MongoDB logs
tail -f /usr/local/var/log/mongodb/mongo.log  # macOS
```

### Issue: "JWT malformed"
**Solution:**
- Ensure token is sent as: `Authorization: Bearer <token>`
- No extra spaces or characters
- Token should start with `eyJ`

### Issue: "Validation Error"
**Solution:**
- Check request body matches model schema
- Ensure required fields are provided
- Check data types (string vs number)

## 🎨 Code Style

### Consistent Error Handling
```typescript
// ✅ Good
import { asyncHandler, AppError } from '../middleware/errorHandler';

export const myController = asyncHandler(async (req, res) => {
  if (!data) {
    throw new AppError('Data not found', 404);
  }
  // ... rest of code
});

// ❌ Avoid
export const myController = async (req, res) => {
  try {
    if (!data) {
      return res.status(404).json({ error: 'Not found' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
```

### TypeScript Types
```typescript
// ✅ Good - Explicit types
interface CreateTruckRequest {
  name: string;
  description: string;
  cuisineType: CuisineType;
}

export const createTruck = asyncHandler(
  async (req: AuthRequest, res: Response) => {
    const data: CreateTruckRequest = req.body;
    // ...
  }
);

// ❌ Avoid - Implicit any
export const createTruck = asyncHandler(async (req, res) => {
  const data = req.body;  // any type
  // ...
});
```

## 📊 Monitoring in Development

### Log Request Times
Add to `src/index.ts`:
```typescript
app.use((req, res, next) => {
  const start = Date.now();
  res.on('finish', () => {
    const duration = Date.now() - start;
    console.log(`${req.method} ${req.path} - ${duration}ms`);
  });
  next();
});
```

### Monitor Database Queries
```typescript
mongoose.set('debug', true); // Shows all queries in console
```

## 🧪 Manual Testing Checklist

**Authentication Flow:**
- [ ] Sign up new user
- [ ] Sign in with valid credentials
- [ ] Sign in with invalid credentials (should fail)
- [ ] Access protected route without token (should fail)
- [ ] Access protected route with token (should work)
- [ ] Sign out
- [ ] Use old token after sign out (should fail)

**Truck Operations:**
- [ ] Get all trucks (no auth)
- [ ] Create truck as eater (should fail)
- [ ] Create truck as owner (should work)
- [ ] Update own truck (should work)
- [ ] Update someone else's truck (should fail)
- [ ] Delete own truck (should work)
- [ ] Search trucks

**Reviews:**
- [ ] Create review
- [ ] Create duplicate review (should fail)
- [ ] Update own review
- [ ] Update someone else's review (should fail)
- [ ] Check truck rating updates automatically

**Favorites:**
- [ ] Add favorite
- [ ] Add duplicate favorite (should fail)
- [ ] Get favorites
- [ ] Remove favorite

## 🔐 Security Testing

**Test Rate Limiting:**
```bash
# Send multiple requests quickly
for i in {1..10}; do
  curl http://localhost:3000/v1/trucks
done
```

**Test Authentication:**
```bash
# No token
curl http://localhost:3000/v1/users/me
# Should return 401

# Invalid token
curl -H "Authorization: Bearer invalid" http://localhost:3000/v1/users/me
# Should return 401

# Valid token
curl -H "Authorization: Bearer VALID_TOKEN" http://localhost:3000/v1/users/me
# Should return 200
```

## 📝 Adding New Features

**Step-by-step guide:**

1. **Create Model** (`src/models/NewModel.ts`)
```typescript
import mongoose, { Document, Schema } from 'mongoose';

export interface INewModel extends Document {
  // fields
}

const schema = new Schema<INewModel>({ /* fields */ });
export const NewModel = mongoose.model<INewModel>('NewModel', schema);
```

2. **Create Controller** (`src/controllers/newController.ts`)
```typescript
import { asyncHandler } from '../middleware/errorHandler';
import { NewModel } from '../models/NewModel';

export const getItems = asyncHandler(async (req, res) => {
  const items = await NewModel.find();
  res.json({ success: true, data: items });
});
```

3. **Create Routes** (`src/routes/newRoutes.ts`)
```typescript
import { Router } from 'express';
import { getItems } from '../controllers/newController';
import { authenticate } from '../middleware/auth';

const router = Router();
router.get('/', authenticate, getItems);
export default router;
```

4. **Add to Main Routes** (`src/routes/index.ts`)
```typescript
import newRoutes from './newRoutes';
router.use('/items', newRoutes);
```

5. **Test!**
```bash
curl http://localhost:3000/v1/items
```

## 🎯 Performance Tips

**1. Add Database Indexes:**
```typescript
// In model file
schema.index({ fieldName: 1 }); // Single field
schema.index({ field1: 1, field2: -1 }); // Compound index
```

**2. Use Lean Queries (when you don't need Mongoose documents):**
```typescript
const trucks = await FoodTruck.find().lean(); // Returns plain JS objects
```

**3. Select Only Needed Fields:**
```typescript
const users = await User.find().select('displayName email'); // Only these fields
```

**4. Pagination:**
```typescript
const page = parseInt(req.query.page) || 1;
const limit = parseInt(req.query.limit) || 10;
const skip = (page - 1) * limit;

const trucks = await FoodTruck.find()
  .skip(skip)
  .limit(limit);
```

## 🐛 Debugging Pro Tips

**1. Use MongoDB Aggregation Pipeline for complex queries:**
```typescript
const stats = await FoodTruck.aggregate([
  { $match: { isOpen: true } },
  { $group: { _id: '$cuisineType', count: { $sum: 1 } } },
  { $sort: { count: -1 } }
]);
```

**2. Check Request Body:**
```typescript
console.log('📥 Request Body:', JSON.stringify(req.body, null, 2));
```

**3. Validate Environment:**
```typescript
// At top of index.ts
const required = ['MONGODB_URI', 'JWT_SECRET', 'JWT_REFRESH_SECRET'];
required.forEach(key => {
  if (!process.env[key]) {
    console.error(`❌ Missing required env var: ${key}`);
    process.exit(1);
  }
});
```

## 🚀 Ready to Ship!

You now have:
- ✅ Complete backend API
- ✅ Development tools
- ✅ Testing strategies
- ✅ Debugging techniques
- ✅ Best practices

Happy coding! 🎉
