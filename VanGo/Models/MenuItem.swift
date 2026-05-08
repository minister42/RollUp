import Foundation

struct MenuItem: Identifiable, Codable, Equatable {
    let id: String
    let truckId: String
    var name: String
    var description: String
    var price: Double
    var category: String
    var isAvailable: Bool
    var photoName: String?

    var priceString: String {
        String(format: "$%.2f", price)
    }
}
