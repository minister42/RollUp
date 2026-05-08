import SwiftUI

@MainActor
final class DependencyContainer: ObservableObject {
    // In the future, this will hold service protocol references.
    // For now, views use SampleData directly for the front-end build.

    nonisolated(unsafe) static let shared = DependencyContainer()

    private nonisolated init() {}
}
