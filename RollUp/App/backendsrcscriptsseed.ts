import dotenv from 'dotenv';
import { connectDatabase, disconnectDatabase } from '../config/database';
import { User, UserRole } from '../models/User';
import { FoodTruck, CuisineType, SubscriptionTier } from '../models/FoodTruck';
import { Review } from '../models/Review';

dotenv.config();

const seedDatabase = async () => {
  try {
    console.log('🌱 Starting database seed...');
    
    await connectDatabase();
    
    // Clear existing data
    console.log('🗑️  Clearing existing data...');
    await User.deleteMany({});
    await FoodTruck.deleteMany({});
    await Review.deleteMany({});
    
    // Create users
    console.log('👥 Creating users...');
    const users = await User.create([
      {
        email: 'alex@example.com',
        password: 'password123',
        displayName: 'Alex Johnson',
        role: UserRole.EATER,
      },
      {
        email: 'maria@tacolibre.com',
        password: 'password123',
        displayName: 'Maria Garcia',
        role: UserRole.TRUCK_OWNER,
      },
      {
        email: 'john@slicemobile.com',
        password: 'password123',
        displayName: 'John Smith',
        role: UserRole.TRUCK_OWNER,
      },
      {
        email: 'sarah@example.com',
        password: 'password123',
        displayName: 'Sarah Chen',
        role: UserRole.EATER,
      },
    ]);
    
    console.log(`✅ Created ${users.length} users`);
    
    // Create food trucks
    console.log('🚚 Creating food trucks...');
    const trucks = await FoodTruck.create([
      {
        ownerId: users[1]._id, // Maria
        name: 'Taco Libre',
        description: 'Authentic Mexican street tacos with fresh ingredients',
        cuisineType: CuisineType.MEXICAN,
        coordinate: {
          latitude: 37.7749,
          longitude: -122.4194,
        },
        isOpen: true,
        tier: SubscriptionTier.PREMIUM,
        socialLinks: {
          instagram: '@tacolibre',
          facebook: 'tacolibresf',
          website: 'https://tacolibre.com',
        },
        isPromoted: true,
      },
      {
        ownerId: users[2]._id, // John
        name: 'Slice Mobile',
        description: 'New York style pizza by the slice',
        cuisineType: CuisineType.ITALIAN,
        coordinate: {
          latitude: 37.7849,
          longitude: -122.4294,
        },
        isOpen: true,
        tier: SubscriptionTier.BASIC,
        socialLinks: {
          instagram: '@slicemobile',
        },
      },
      {
        ownerId: users[1]._id, // Maria's second truck
        name: 'Burrito Express',
        description: 'Fast, delicious burritos on the go',
        cuisineType: CuisineType.MEXICAN,
        coordinate: {
          latitude: 37.7649,
          longitude: -122.4094,
        },
        isOpen: false,
        tier: SubscriptionTier.FREE,
      },
      {
        ownerId: users[2]._id, // John's second truck
        name: 'Pasta Paradise',
        description: 'Fresh pasta dishes and Italian specialties',
        cuisineType: CuisineType.ITALIAN,
        coordinate: {
          latitude: 37.7949,
          longitude: -122.4394,
        },
        isOpen: true,
        tier: SubscriptionTier.BASIC,
      },
    ]);
    
    console.log(`✅ Created ${trucks.length} food trucks`);
    
    // Create reviews
    console.log('⭐ Creating reviews...');
    const reviews = await Review.create([
      {
        truckId: trucks[0]._id,
        userId: users[0]._id,
        userName: users[0].displayName,
        rating: 5,
        comment: 'Best tacos in the city! The carne asada is amazing.',
      },
      {
        truckId: trucks[0]._id,
        userId: users[3]._id,
        userName: users[3].displayName,
        rating: 5,
        comment: 'Authentic flavors and generous portions. Highly recommend!',
      },
      {
        truckId: trucks[1]._id,
        userId: users[0]._id,
        userName: users[0].displayName,
        rating: 4,
        comment: 'Great pizza, reminds me of New York!',
      },
      {
        truckId: trucks[1]._id,
        userId: users[3]._id,
        userName: users[3].displayName,
        rating: 5,
        comment: 'Perfect slice every time. Love the margherita!',
      },
      {
        truckId: trucks[3]._id,
        userId: users[0]._id,
        userName: users[0].displayName,
        rating: 4,
        comment: 'Delicious pasta, great portions. Can get busy at lunch.',
      },
    ]);
    
    console.log(`✅ Created ${reviews.length} reviews`);
    
    console.log('\n🎉 Database seeded successfully!');
    console.log('\n📝 Test Accounts:');
    console.log('Eater: alex@example.com / password123');
    console.log('Truck Owner: maria@tacolibre.com / password123');
    console.log('Truck Owner: john@slicemobile.com / password123');
    console.log('Eater: sarah@example.com / password123');
    
    await disconnectDatabase();
    process.exit(0);
  } catch (error) {
    console.error('❌ Error seeding database:', error);
    await disconnectDatabase();
    process.exit(1);
  }
};

seedDatabase();
