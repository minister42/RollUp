import Foundation

enum APIConfiguration {
    enum Environment {
        case development
        case staging
        case production
        
        var baseURL: URL {
            switch self {
            case .development:
                // Local development server
                return URL(string: "http://localhost:3000/v1")!
            case .staging:
                // Staging/testing server
                return URL(string: "https://staging-api.yourfoodtruckapp.com/v1")!
            case .production:
                // Production server
                return URL(string: "https://api.yourfoodtruckapp.com/v1")!
            }
        }
        
        var timeout: TimeInterval {
            switch self {
            case .development:
                return 60 // Longer timeout for debugging
            case .staging:
                return 30
            case .production:
                return 30
            }
        }
    }
    
    // MARK: - Current Environment
    
    /// Change this to switch between environments
    /// In production apps, you might read this from an environment variable or build configuration
    static let current: Environment = {
        #if DEBUG
        return .development
        #else
        return .production
        #endif
    }()
    
    // MARK: - Convenience Properties
    
    static var baseURL: URL {
        current.baseURL
    }
    
    static var timeout: TimeInterval {
        current.timeout
    }
    
    // MARK: - Feature Flags
    
    static var enableLogging: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    
    static var enableMockData: Bool {
        #if DEBUG
        // Set to true to use mock data instead of real API calls during development
        return false
        #else
        return false
        #endif
    }
}
