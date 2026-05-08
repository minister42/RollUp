import Foundation

struct User: Identifiable, Codable, Equatable {
    let id: String
    var email: String
    var displayName: String
    var role: UserRole
    var avatarURL: URL?
    var createdAt: Date

    static let preview = User(
        id: "user-001",
        email: "alex@example.com",
        displayName: "Alex Johnson",
        role: .eater,
        avatarURL: nil,
        createdAt: Date()
    )

    static let previewOwner = User(
        id: "owner-001",
        email: "maria@tacolibre.com",
        displayName: "Maria Garcia",
        role: .truckOwner,
        avatarURL: nil,
        createdAt: Date()
    )
}
