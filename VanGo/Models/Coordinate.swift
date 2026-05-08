import Foundation
import CoreLocation

struct Coordinate: Codable, Equatable, Hashable {
    let latitude: Double
    let longitude: Double

    var clCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    var clLocation: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }

    func distance(to other: Coordinate) -> CLLocationDistance {
        clLocation.distance(from: other.clLocation)
    }

    /// Distance in miles
    func distanceMiles(to other: Coordinate) -> Double {
        distance(to: other) / 1609.34
    }
}
