import mongoose, { Document, Schema } from 'mongoose';

export enum CuisineType {
  MEXICAN = 'Mexican',
  ITALIAN = 'Italian',
  ASIAN = 'Asian',
  AMERICAN = 'American',
  MEDITERRANEAN = 'Mediterranean',
  SEAFOOD = 'Seafood',
  BBQ = 'BBQ',
  VEGAN = 'Vegan',
  DESSERTS = 'Desserts',
  FUSION = 'Fusion',
  OTHER = 'Other',
}

export enum SubscriptionTier {
  FREE = 'free',
  BASIC = 'basic',
  PREMIUM = 'premium',
}

export interface ICoordinate {
  latitude: number;
  longitude: number;
}

export interface ISocialLinks {
  instagram?: string;
  facebook?: string;
  twitter?: string;
  website?: string;
}

export interface IFoodTruck extends Document {
  ownerId: mongoose.Types.ObjectId;
  name: string;
  description: string;
  cuisineType: CuisineType;
  coordinate: ICoordinate;
  isOpen: boolean;
  tier: SubscriptionTier;
  socialLinks: ISocialLinks;
  heroImageName?: string;
  averageRating: number;
  reviewCount: number;
  isPromoted: boolean;
  createdAt: Date;
  updatedAt: Date;
}

const coordinateSchema = new Schema<ICoordinate>(
  {
    latitude: {
      type: Number,
      required: true,
      min: -90,
      max: 90,
    },
    longitude: {
      type: Number,
      required: true,
      min: -180,
      max: 180,
    },
  },
  { _id: false }
);

const socialLinksSchema = new Schema<ISocialLinks>(
  {
    instagram: { type: String },
    facebook: { type: String },
    twitter: { type: String },
    website: { type: String },
  },
  { _id: false }
);

const foodTruckSchema = new Schema<IFoodTruck>(
  {
    ownerId: {
      type: Schema.Types.ObjectId,
      ref: 'User',
      required: [true, 'Owner ID is required'],
      index: true,
    },
    name: {
      type: String,
      required: [true, 'Truck name is required'],
      trim: true,
      minlength: [2, 'Truck name must be at least 2 characters'],
      maxlength: [100, 'Truck name must be less than 100 characters'],
    },
    description: {
      type: String,
      required: [true, 'Description is required'],
      trim: true,
      maxlength: [500, 'Description must be less than 500 characters'],
    },
    cuisineType: {
      type: String,
      enum: Object.values(CuisineType),
      required: [true, 'Cuisine type is required'],
    },
    coordinate: {
      type: coordinateSchema,
      required: [true, 'Coordinates are required'],
    },
    isOpen: {
      type: Boolean,
      default: false,
    },
    tier: {
      type: String,
      enum: Object.values(SubscriptionTier),
      default: SubscriptionTier.FREE,
    },
    socialLinks: {
      type: socialLinksSchema,
      default: {},
    },
    heroImageName: {
      type: String,
      default: null,
    },
    averageRating: {
      type: Number,
      default: 0,
      min: 0,
      max: 5,
    },
    reviewCount: {
      type: Number,
      default: 0,
      min: 0,
    },
    isPromoted: {
      type: Boolean,
      default: false,
    },
  },
  {
    timestamps: true,
    toJSON: {
      transform: (_doc, ret: Record<string, any>) => {
        ret.id = ret._id;
        delete ret._id;
        delete ret.__v;
        return ret;
      },
    },
  }
);

// Indexes for better query performance
foodTruckSchema.index({ name: 'text', description: 'text' });
foodTruckSchema.index({ 'coordinate.latitude': 1, 'coordinate.longitude': 1 });
foodTruckSchema.index({ cuisineType: 1 });
foodTruckSchema.index({ averageRating: -1 });

export const FoodTruck = mongoose.model<IFoodTruck>('FoodTruck', foodTruckSchema);
