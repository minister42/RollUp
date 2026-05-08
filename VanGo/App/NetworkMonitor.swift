import Foundation
import Network

/// Monitors network connectivity and provides status to the app
@MainActor
final class NetworkMonitor: ObservableObject {
    nonisolated(unsafe) static let shared = NetworkMonitor()
    
    @Published var isConnected: Bool = true
    @Published var connectionType: ConnectionType = .unknown
    
    private let monitor: NWPathMonitor
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    enum ConnectionType {
        case wifi
        case cellular
        case wiredEthernet
        case unknown
        
        var description: String {
            switch self {
            case .wifi:
                return "Wi-Fi"
            case .cellular:
                return "Cellular"
            case .wiredEthernet:
                return "Ethernet"
            case .unknown:
                return "Unknown"
            }
        }
    }
    
    private nonisolated init() {
        monitor = NWPathMonitor()
    }
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            Task { @MainActor in
                self?.isConnected = path.status == .satisfied
                self?.updateConnectionType(from: path)
                
                if APIConfiguration.enableLogging {
                    if path.status == .satisfied {
                        print("🌐 Network connected via \(self?.connectionType.description ?? "unknown")")
                    } else {
                        print("⚠️ Network disconnected")
                    }
                }
            }
        }
        
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
    
    private func updateConnectionType(from path: NWPath) {
        if path.usesInterfaceType(.wifi) {
            connectionType = .wifi
        } else if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
        } else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .wiredEthernet
        } else {
            connectionType = .unknown
        }
    }
}

// MARK: - SwiftUI View Extension

import SwiftUI

extension View {
    /// Shows an offline banner when network is unavailable
    func offlineAware() -> some View {
        self.modifier(OfflineAwareModifier())
    }
}

struct OfflineAwareModifier: ViewModifier {
    @ObservedObject var networkMonitor = NetworkMonitor.shared
    
    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            content
            
            if !networkMonitor.isConnected {
                OfflineBanner()
                    .transition(.move(edge: .top))
            }
        }
        .animation(.easeInOut, value: networkMonitor.isConnected)
    }
}

struct OfflineBanner: View {
    var body: some View {
        HStack {
            Image(systemName: "wifi.slash")
            Text("No Internet Connection")
            Spacer()
        }
        .font(.subheadline)
        .foregroundStyle(.white)
        .padding()
        .background(Color.red)
    }
}

// MARK: - App Integration Example

/*
 Add to your main App struct:
 
 @main
 struct FoodTruckApp: App {
     @StateObject private var appState = AppState()
     
     var body: some Scene {
         WindowGroup {
             ContentView()
                 .environmentObject(appState)
                 .offlineAware() // Add this modifier
                 .onAppear {
                     NetworkMonitor.shared.startMonitoring()
                 }
         }
     }
 }
 */
