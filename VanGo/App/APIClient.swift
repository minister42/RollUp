import Foundation

@MainActor
final class APIClient: ObservableObject {
    nonisolated(unsafe) static let shared = APIClient()
    
    private let baseURL: URL
    private let session: URLSession
    private var accessToken: String?
    
    private nonisolated init() {
        self.baseURL = APIConfiguration.baseURL
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = APIConfiguration.timeout
        configuration.timeoutIntervalForResource = 300
        self.session = URLSession(configuration: configuration)
        
        if APIConfiguration.enableLogging {
            print("🌐 APIClient initialized with baseURL: \(baseURL)")
        }
    }
    
    // MARK: - Token Management
    
    func setAccessToken(_ token: String?) {
        self.accessToken = token
        if let token = token {
            UserDefaults.standard.set(token, forKey: "accessToken")
        } else {
            UserDefaults.standard.removeObject(forKey: "accessToken")
        }
    }
    
    func loadSavedToken() {
        self.accessToken = UserDefaults.standard.string(forKey: "accessToken")
    }
    
    // MARK: - Core Request Method
    
    func request<T: Decodable>(
        endpoint: APIEndpoint,
        responseType: T.Type
    ) async throws -> T {
        var urlComponents = URLComponents(url: baseURL.appendingPathComponent(endpoint.path), resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = endpoint.queryItems
        
        guard let url = urlComponents?.url else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body
        
        // Set default headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        // Add authorization header if token exists
        if let accessToken = accessToken {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        // Add custom headers from endpoint
        endpoint.headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        if APIConfiguration.enableLogging {
            print("🚀 \(endpoint.method.rawValue) \(url)")
            if let body = endpoint.body, let bodyString = String(data: body, encoding: .utf8) {
                print("📦 Body: \(bodyString)")
            }
        }
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            if APIConfiguration.enableLogging {
                print("✅ \(httpResponse.statusCode) \(url)")
            }
            
            try validateResponse(httpResponse)
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let decodedResponse = try decoder.decode(T.self, from: data)
                return decodedResponse
            } catch {
                if APIConfiguration.enableLogging {
                    print("❌ Decoding error: \(error)")
                    if let dataString = String(data: data, encoding: .utf8) {
                        print("📄 Response data: \(dataString)")
                    }
                }
                throw APIError.decodingError(error)
            }
        } catch let error as APIError {
            if APIConfiguration.enableLogging {
                print("❌ API Error: \(error.localizedDescription)")
            }
            throw error
        } catch {
            if APIConfiguration.enableLogging {
                print("❌ Network error: \(error)")
            }
            throw APIError.networkError(error)
        }
    }
    
    // Variant for requests that don't return data (like DELETE)
    func request(endpoint: APIEndpoint) async throws {
        let _: EmptyResponse = try await request(endpoint: endpoint, responseType: EmptyResponse.self)
    }
    
    // MARK: - Response Validation
    
    private func validateResponse(_ response: HTTPURLResponse) throws {
        switch response.statusCode {
        case 200...299:
            return
        case 401:
            throw APIError.unauthorized
        case 403:
            throw APIError.forbidden
        case 404:
            throw APIError.notFound
        case 500...599:
            throw APIError.serverError(statusCode: response.statusCode)
        default:
            throw APIError.unknownError
        }
    }
}

// MARK: - Helper Types

private struct EmptyResponse: Codable {}
