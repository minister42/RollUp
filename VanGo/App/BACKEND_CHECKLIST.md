# Backend Integration Checklist

Use this checklist to integrate the backend into your food truck app.

## ✅ Phase 1: Initial Setup (5-10 minutes)

- [ ] **Update Backend URLs**
  - Open `APIConfiguration.swift`
  - Update the development URL (e.g., `http://localhost:3000/v1`)
  - Update the staging URL (if you have one)
  - Update the production URL
  
- [ ] **Verify Model Compatibility**
  - Check that `FoodTruck` model matches your backend schema
  - Check that `User` model matches your backend schema
  - Add any missing fields to `APIModels.swift` request/response types

- [ ] **Add Network Monitoring** (Optional but recommended)
  - Open your main App file
  - Add `.offlineAware()` modifier to root view
  - Add `NetworkMonitor.shared.startMonitoring()` in `onAppear`

## ✅ Phase 2: Authentication Integration (15-30 minutes)

- [ ] **Create Login View**
  - Add email and password TextFields
  - Add sign in button that calls `await appState.signIn(email:password:)`
  - Show loading state with `appState.isLoading`
  - Show errors with `appState.errorMessage`

- [ ] **Create Sign Up View**
  - Add email, password, displayName fields
  - Add role picker (eater vs truck owner)
  - Call `await appState.signUp(email:password:displayName:role:)`

- [ ] **Add Session Persistence**
  - In your App's `init` or `onAppear`, call:
    ```swift
    Task {
        await appState.loadSavedSession()
    }
    ```

- [ ] **Test Authentication**
  - Try signing up a new user
  - Try signing in
  - Try signing out
  - Close and reopen app - should stay logged in

## ✅ Phase 3: Truck Operations (20-40 minutes)

- [ ] **Update Explore View**
  - Add `@StateObject private var truckService = TruckService()`
  - Load trucks with `try await truckService.getAllTrucks()`
  - Replace sample data with real API data
  - Add error handling

- [ ] **Update Search Functionality**
  - Use `truckService.searchTrucks(query:location:)` for search
  - Add debouncing to avoid too many requests

- [ ] **Owner: Create Truck View**
  - Check if user role is `.truckOwner`
  - Create form for truck details
  - Call `truckService.createTruck(...)`

- [ ] **Owner: Edit Truck View**
  - Load existing truck data
  - Call `truckService.updateTruck(truckId:...)`

## ✅ Phase 4: Reviews & Favorites (15-30 minutes)

- [ ] **Display Reviews**
  - Add `@StateObject private var reviewService = ReviewService()`
  - Load reviews with `reviewService.getTruckReviews(truckId:)`

- [ ] **Create Review**
  - Add review form (rating + comment)
  - Call `reviewService.createReview(truckId:userId:rating:comment:)`
  - Refresh reviews list after creation

- [ ] **Implement Favorites**
  - Add `@StateObject private var favoriteService = FavoriteService()`
  - Load user favorites on profile view
  - Add/remove with `favoriteService.toggleFavorite(...)`
  - Update UI to show favorite state

## ✅ Phase 5: User Profile (10-20 minutes)

- [ ] **Display Profile**
  - Show current user data from `appState.currentUser`

- [ ] **Edit Profile**
  - Add `@StateObject private var userService = UserService()`
  - Create edit form
  - Call `userService.updateProfile(userId:displayName:avatarURL:email:)`
  - Update `appState.currentUser` after successful update

## ✅ Phase 6: Testing (30-60 minutes)

- [ ] **Test All User Flows**
  - Sign up → Sign in → Browse trucks
  - Search trucks
  - View truck details
  - Add/remove favorites
  - Create review
  - Edit profile
  - Sign out

- [ ] **Test Truck Owner Flows**
  - Sign in as owner
  - Create truck
  - Edit truck
  - View own trucks

- [ ] **Test Error Cases**
  - Try signing in with wrong password
  - Try accessing data while offline
  - Try creating truck without required fields
  - Verify error messages are user-friendly

## ✅ Phase 7: Polish (Optional)

- [ ] **Add Loading States**
  - Show ProgressView during API calls
  - Disable buttons during loading

- [ ] **Add Pull to Refresh**
  - Add `.refreshable` modifier to lists
  - Reload data on pull down

- [ ] **Add Empty States**
  - Show helpful message when no trucks found
  - Show message when no favorites
  - Show message when no reviews

- [ ] **Add Optimistic Updates**
  - Update UI immediately when favoriting
  - Revert if API call fails

## 🚀 Before Production

- [ ] **Security**
  - Implement Keychain storage for tokens (replace UserDefaults)
  - Add SSL certificate pinning
  - Add request rate limiting

- [ ] **Performance**
  - Implement caching for frequently accessed data
  - Add pagination for large lists
  - Optimize image loading

- [ ] **Testing**
  - Write unit tests for services
  - Write UI tests for critical flows
  - Test on slow network conditions

- [ ] **Monitoring**
  - Add crash reporting (e.g., Crashlytics)
  - Add analytics for user actions
  - Add API error tracking

- [ ] **Documentation**
  - Document any custom backend requirements
  - Update README with setup instructions
  - Document environment variables

## 📚 Resources

- **Full Documentation**: See `BACKEND_README.md`
- **Architecture Overview**: See `ARCHITECTURE.md`
- **Code Examples**: See `BackendUsageExampleView.swift`
- **Summary**: See `BACKEND_SUMMARY.md`

## 🆘 Troubleshooting

### "Invalid URL" Error
- Check `APIConfiguration.swift` URLs are valid
- Ensure URLs don't have trailing slashes
- Verify base URL is accessible

### "Unauthorized" Error
- Check if access token is being saved
- Verify token is included in request headers
- Try signing in again

### "Decoding Error"
- Backend response doesn't match expected model
- Check backend API documentation
- Update models in `APIModels.swift` to match backend

### Network Timeout
- Check internet connection
- Verify backend server is running
- Increase timeout in `APIConfiguration.swift`

### Can't See Logs
- Ensure you're running in DEBUG mode
- Check `APIConfiguration.enableLogging` is true
- Look in Xcode console

## 💡 Tips

1. **Start Simple**: Get authentication working first, then add features
2. **Use Previews**: Mock data is still useful for UI development
3. **Test Early**: Don't wait until everything is built to test API calls
4. **Handle Errors**: Always show user-friendly error messages
5. **Log Everything**: Enable debug logging during development

## ✨ You're Ready!

Once you've completed the checklist, your app will be fully connected to your backend!

Good luck! 🚀
