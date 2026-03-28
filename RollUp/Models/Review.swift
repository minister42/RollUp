import Foundation

struct Review: Identifiable, Codable, Equatable {
    let id: String
    let truckId: String
    let authorId: String
    var authorName: String
    var rating: Int // 1-5
    var text: String
    var date: Date

    var timeAgo: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}
