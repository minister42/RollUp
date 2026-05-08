import Foundation

struct SocialLinks: Codable, Equatable {
    var instagram: URL?
    var twitter: URL?
    var facebook: URL?
    var website: URL?
    var phone: String?

    static let empty = SocialLinks()

    static let preview = SocialLinks(
        instagram: URL(string: "https://instagram.com/tacolibre"),
        twitter: URL(string: "https://twitter.com/tacolibre"),
        facebook: nil,
        website: URL(string: "https://tacolibre.com"),
        phone: "(512) 555-0142"
    )
}
