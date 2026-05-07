# 🚀 Quick Start Guide

Get your Food Truck backend up and running in 5 minutes!

## Step 1: Install Dependencies

```bash
cd backend
npm install
```

## Step 2: Setup Environment

```bash
cp .env.example .env
```

**Edit `.env` and set these minimum values:**

```env
NODE_ENV=development
PORT=3000
MONGODB_URI=mongodb://localhost:27017/foodtruck-app
JWT_SECRET=your-secret-key-change-this
JWT_REFRESH_SECRET=your-refresh-secret-change-this
```

## Step 3: Start MongoDB

**Option A: Local MongoDB**
```bash
# macOS (with Homebrew)
brew services start mongodb-community

# Linux
sudo systemctl start mongod

# Windows
net start MongoDB
```

**Option B: MongoDB Atlas (Cloud)**
1. Go to [mongodb.com/cloud/atlas](https://www.mongodb.com/cloud/atlas)
2. Create free cluster
3. Get connection string
4. Update `MONGODB_URI` in `.env`

## Step 4: Seed Database (Optional but Recommended)

```bash
npm run seed
```

This creates test users and food trucks:
- **Eater**: alex@example.com / password123
- **Owner**: maria@tacolibre.com / password123

## Step 5: Start Server

```bash
npm run dev
```

You should see:
```
✅ MongoDB Connected
🚀 Server running on port 3000
📱 API Version: v1
🌍 Environment: development
📊 Health check: http://localhost:3000/health
```

## Step 6: Test It!

**Health Check:**
```bash
curl http://localhost:3000/health
```

**Sign In:**
```bash
curl -X POST http://localhost:3000/v1/auth/signin \
  -H "Content-Type: application/json" \
  -d '{"email":"alex@example.com","password":"password123"}'
```

**Get Trucks:**
```bash
curl http://localhost:3000/v1/trucks
```

## Step 7: Connect Your iOS App

Update `APIConfiguration.swift`:

```swift
case .development:
    return URL(string: "http://localhost:3000/v1")!
```

**Important**: If testing on a real device, use your computer's IP address instead of `localhost`:

```swift
case .development:
    return URL(string: "http://192.168.1.100:3000/v1")! // Replace with your IP
```

Find your IP:
- **macOS**: `ifconfig | grep "inet "` or System Preferences → Network
- **Windows**: `ipconfig`
- **Linux**: `ip addr show`

## 🎉 You're Ready!

Your backend is now running and ready to use with your iOS app!

## Common Commands

```bash
npm run dev      # Start development server
npm run build    # Build for production
npm start        # Run production build
npm run seed     # Seed database with test data
```

## Need Help?

See the full [README.md](README.md) for:
- Complete API documentation
- Deployment guides
- Troubleshooting
- Security best practices
