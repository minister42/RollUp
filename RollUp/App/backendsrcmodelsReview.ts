import mongoose, { Document, Schema } from 'mongoose';

export interface IReview extends Document {
  truckId: mongoose.Types.ObjectId;
  userId: mongoose.Types.ObjectId;
  userName: string;
  userAvatarURL?: string;
  rating: number;
  comment?: string;
  createdAt: Date;
  updatedAt: Date;
}

const reviewSchema = new Schema<IReview>(
  {
    truckId: {
      type: Schema.Types.ObjectId,
      ref: 'FoodTruck',
      required: [true, 'Truck ID is required'],
      index: true,
    },
    userId: {
      type: Schema.Types.ObjectId,
      ref: 'User',
      required: [true, 'User ID is required'],
      index: true,
    },
    userName: {
      type: String,
      required: [true, 'User name is required'],
    },
    userAvatarURL: {
      type: String,
      default: null,
    },
    rating: {
      type: Number,
      required: [true, 'Rating is required'],
      min: [1, 'Rating must be at least 1'],
      max: [5, 'Rating must be at most 5'],
    },
    comment: {
      type: String,
      maxlength: [500, 'Comment must be less than 500 characters'],
      trim: true,
    },
  },
  {
    timestamps: true,
    toJSON: {
      transform: (doc, ret) => {
        ret.id = ret._id;
        delete ret._id;
        delete ret.__v;
        return ret;
      },
    },
  }
);

// Compound index to ensure a user can only review a truck once
reviewSchema.index({ truckId: 1, userId: 1 }, { unique: true });

// Update truck's average rating after review is saved
reviewSchema.post('save', async function () {
  const FoodTruck = mongoose.model('FoodTruck');
  
  const stats = await mongoose.model('Review').aggregate([
    { $match: { truckId: this.truckId } },
    {
      $group: {
        _id: '$truckId',
        averageRating: { $avg: '$rating' },
        reviewCount: { $sum: 1 },
      },
    },
  ]);
  
  if (stats.length > 0) {
    await FoodTruck.findByIdAndUpdate(this.truckId, {
      averageRating: Math.round(stats[0].averageRating * 10) / 10,
      reviewCount: stats[0].reviewCount,
    });
  }
});

// Update truck's average rating after review is deleted
reviewSchema.post('findOneAndDelete', async function (doc) {
  if (doc) {
    const FoodTruck = mongoose.model('FoodTruck');
    
    const stats = await mongoose.model('Review').aggregate([
      { $match: { truckId: doc.truckId } },
      {
        $group: {
          _id: '$truckId',
          averageRating: { $avg: '$rating' },
          reviewCount: { $sum: 1 },
        },
      },
    ]);
    
    if (stats.length > 0) {
      await FoodTruck.findByIdAndUpdate(doc.truckId, {
        averageRating: Math.round(stats[0].averageRating * 10) / 10,
        reviewCount: stats[0].reviewCount,
      });
    } else {
      await FoodTruck.findByIdAndUpdate(doc.truckId, {
        averageRating: 0,
        reviewCount: 0,
      });
    }
  }
});

export const Review = mongoose.model<IReview>('Review', reviewSchema);
