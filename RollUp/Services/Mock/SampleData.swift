import Foundation

struct SampleData {

    // MARK: - User Location (Austin, TX downtown)
    static let userLocation = Coordinate(latitude: 30.2672, longitude: -97.7431)

    // MARK: - Food Trucks
    static let trucks: [FoodTruck] = [
        FoodTruck(
            id: "truck-001",
            ownerId: "owner-001",
            name: "Taco Libre",
            description: "Authentic street tacos made with love. Family recipes passed down through generations. Our tortillas are made fresh daily.",
            cuisineType: .mexican,
            coordinate: Coordinate(latitude: 30.2690, longitude: -97.7405),
            isOpen: true,
            tier: .pro,
            socialLinks: SocialLinks(
                instagram: URL(string: "https://instagram.com/tacolibre"),
                twitter: URL(string: "https://twitter.com/tacolibre"),
                website: URL(string: "https://tacolibre.com"),
                phone: "(512) 555-0142"
            ),
            heroImageName: "taco_truck",
            averageRating: 4.8,
            reviewCount: 127,
            isPromoted: true
        ),
        FoodTruck(
            id: "truck-002",
            ownerId: "owner-002",
            name: "Smokin' Joe's BBQ",
            description: "Low and slow Texas BBQ. Brisket smoked for 14 hours over post oak wood. Come hungry, leave happy.",
            cuisineType: .bbq,
            coordinate: Coordinate(latitude: 30.2635, longitude: -97.7480),
            isOpen: true,
            tier: .pro,
            socialLinks: SocialLinks(
                instagram: URL(string: "https://instagram.com/smokinjoes"),
                phone: "(512) 555-0287"
            ),
            heroImageName: "bbq_truck",
            averageRating: 4.5,
            reviewCount: 89,
            isPromoted: false
        ),
        FoodTruck(
            id: "truck-003",
            ownerId: "owner-003",
            name: "Seoul on Wheels",
            description: "Korean street food meets Austin. Try our famous Korean fried chicken and bibimbap bowls.",
            cuisineType: .korean,
            coordinate: Coordinate(latitude: 30.2710, longitude: -97.7390),
            isOpen: false,
            tier: .basic,
            socialLinks: SocialLinks(
                instagram: URL(string: "https://instagram.com/seoulonwheels"),
                website: URL(string: "https://seoulonwheels.com"),
                phone: "(512) 555-0391"
            ),
            heroImageName: "korean_truck",
            averageRating: 4.6,
            reviewCount: 64,
            isPromoted: false
        ),
        FoodTruck(
            id: "truck-004",
            ownerId: "owner-004",
            name: "The Rolling Pin",
            description: "Artisan pizzas fired in our wood-burning oven on wheels. Neapolitan style with locally sourced ingredients.",
            cuisineType: .italian,
            coordinate: Coordinate(latitude: 30.2650, longitude: -97.7510),
            isOpen: true,
            tier: .pro,
            socialLinks: SocialLinks(
                instagram: URL(string: "https://instagram.com/therollingpin"),
                facebook: URL(string: "https://facebook.com/therollingpin"),
                website: URL(string: "https://therollingpin.com"),
                phone: "(512) 555-0455"
            ),
            heroImageName: "pizza_truck",
            averageRating: 4.7,
            reviewCount: 203,
            isPromoted: true
        ),
        FoodTruck(
            id: "truck-005",
            ownerId: "owner-005",
            name: "Green Machine",
            description: "100% plant-based comfort food that even meat lovers enjoy. Our cauliflower tacos will change your life.",
            cuisineType: .vegan,
            coordinate: Coordinate(latitude: 30.2700, longitude: -97.7450),
            isOpen: true,
            tier: .basic,
            socialLinks: SocialLinks(
                instagram: URL(string: "https://instagram.com/greenmachine"),
                phone: "(512) 555-0512"
            ),
            heroImageName: "vegan_truck",
            averageRating: 4.3,
            reviewCount: 42,
            isPromoted: false
        ),
        FoodTruck(
            id: "truck-006",
            ownerId: "owner-006",
            name: "Wok This Way",
            description: "Fresh wok-tossed noodles and rice bowls. Made to order with your choice of protein and sauce.",
            cuisineType: .asian,
            coordinate: Coordinate(latitude: 30.2620, longitude: -97.7420),
            isOpen: true,
            tier: .pro,
            socialLinks: SocialLinks(
                instagram: URL(string: "https://instagram.com/wokthisway"),
                twitter: URL(string: "https://twitter.com/wokthisway"),
                phone: "(512) 555-0678"
            ),
            heroImageName: "asian_truck",
            averageRating: 4.4,
            reviewCount: 76,
            isPromoted: false
        ),
        FoodTruck(
            id: "truck-007",
            ownerId: "owner-007",
            name: "Catch of the Day",
            description: "Fresh Gulf seafood brought to the streets. Fish tacos, shrimp po'boys, and lobster rolls.",
            cuisineType: .seafood,
            coordinate: Coordinate(latitude: 30.2680, longitude: -97.7460),
            isOpen: false,
            tier: .basic,
            socialLinks: SocialLinks(
                website: URL(string: "https://catchoftheday.com"),
                phone: "(512) 555-0734"
            ),
            heroImageName: "seafood_truck",
            averageRating: 4.2,
            reviewCount: 31,
            isPromoted: false
        ),
        FoodTruck(
            id: "truck-008",
            ownerId: "owner-008",
            name: "Sugar Rush",
            description: "Gourmet desserts on wheels! Fresh churros, handmade ice cream sandwiches, and our famous funnel cakes.",
            cuisineType: .dessert,
            coordinate: Coordinate(latitude: 30.2660, longitude: -97.7435),
            isOpen: true,
            tier: .pro,
            socialLinks: SocialLinks(
                instagram: URL(string: "https://instagram.com/sugarrush"),
                facebook: URL(string: "https://facebook.com/sugarrush"),
                phone: "(512) 555-0890"
            ),
            heroImageName: "dessert_truck",
            averageRating: 4.9,
            reviewCount: 156,
            isPromoted: false
        ),
        FoodTruck(
            id: "truck-009",
            ownerId: "owner-009",
            name: "Burger Blitz",
            description: "Smash burgers done right. Hand-formed patties, brioche buns, and secret sauce that keeps 'em coming back.",
            cuisineType: .american,
            coordinate: Coordinate(latitude: 30.2645, longitude: -97.7395),
            isOpen: true,
            tier: .basic,
            socialLinks: SocialLinks(
                instagram: URL(string: "https://instagram.com/burgerblitz"),
                phone: "(512) 555-0923"
            ),
            heroImageName: "burger_truck",
            averageRating: 4.5,
            reviewCount: 98,
            isPromoted: false
        ),
        FoodTruck(
            id: "truck-010",
            ownerId: "owner-010",
            name: "East Meets West",
            description: "Fusion cuisine that blends Asian and Texan flavors. Try our Korean BBQ brisket tacos!",
            cuisineType: .fusion,
            coordinate: Coordinate(latitude: 30.2715, longitude: -97.7470),
            isOpen: true,
            tier: .pro,
            socialLinks: SocialLinks(
                instagram: URL(string: "https://instagram.com/eastmeetswest"),
                twitter: URL(string: "https://twitter.com/eastmeetswest"),
                website: URL(string: "https://eastmeetswest.com"),
                phone: "(512) 555-1042"
            ),
            heroImageName: "fusion_truck",
            averageRating: 4.7,
            reviewCount: 112,
            isPromoted: true
        ),
    ]

    // MARK: - Menu Items
    static let menuItems: [MenuItem] = [
        // Taco Libre
        MenuItem(id: "mi-001", truckId: "truck-001", name: "Carne Asada Taco", description: "Grilled steak, cilantro, onion, salsa verde", price: 4.50, category: "Tacos", isAvailable: true),
        MenuItem(id: "mi-002", truckId: "truck-001", name: "Al Pastor Taco", description: "Marinated pork, pineapple, cilantro", price: 4.00, category: "Tacos", isAvailable: true),
        MenuItem(id: "mi-003", truckId: "truck-001", name: "Fish Taco", description: "Beer-battered cod, cabbage slaw, chipotle crema", price: 5.00, category: "Tacos", isAvailable: true),
        MenuItem(id: "mi-004", truckId: "truck-001", name: "Super Burrito", description: "Rice, beans, cheese, sour cream, guac, your choice of meat", price: 12.00, category: "Burritos", isAvailable: true),
        MenuItem(id: "mi-005", truckId: "truck-001", name: "Chips & Guac", description: "Fresh tortilla chips with house-made guacamole", price: 6.00, category: "Sides", isAvailable: true),
        MenuItem(id: "mi-006", truckId: "truck-001", name: "Horchata", description: "Traditional rice drink with cinnamon", price: 3.50, category: "Drinks", isAvailable: true),

        // Smokin' Joe's BBQ
        MenuItem(id: "mi-010", truckId: "truck-002", name: "Brisket Plate", description: "14-hour smoked brisket, two sides", price: 16.00, category: "Plates", isAvailable: true),
        MenuItem(id: "mi-011", truckId: "truck-002", name: "Pulled Pork Sandwich", description: "Slow-smoked pulled pork, coleslaw, pickles", price: 11.00, category: "Sandwiches", isAvailable: true),
        MenuItem(id: "mi-012", truckId: "truck-002", name: "Ribs (Half Rack)", description: "St. Louis style ribs, dry rub", price: 18.00, category: "Plates", isAvailable: true),
        MenuItem(id: "mi-013", truckId: "truck-002", name: "Mac & Cheese", description: "Creamy smoked gouda mac", price: 5.00, category: "Sides", isAvailable: true),
        MenuItem(id: "mi-014", truckId: "truck-002", name: "Coleslaw", description: "Tangy vinegar-based slaw", price: 3.00, category: "Sides", isAvailable: true),

        // Seoul on Wheels
        MenuItem(id: "mi-020", truckId: "truck-003", name: "Korean Fried Chicken", description: "Double-fried, gochujang glaze", price: 13.00, category: "Mains", isAvailable: true),
        MenuItem(id: "mi-021", truckId: "truck-003", name: "Bibimbap Bowl", description: "Rice, vegetables, egg, gochujang", price: 12.00, category: "Bowls", isAvailable: true),
        MenuItem(id: "mi-022", truckId: "truck-003", name: "Bulgogi Tacos", description: "Marinated beef, kimchi slaw, sesame", price: 5.50, category: "Tacos", isAvailable: true),
        MenuItem(id: "mi-023", truckId: "truck-003", name: "Japchae", description: "Sweet potato noodles, vegetables, soy", price: 10.00, category: "Mains", isAvailable: true),

        // The Rolling Pin
        MenuItem(id: "mi-030", truckId: "truck-004", name: "Margherita Pizza", description: "San Marzano tomatoes, fresh mozzarella, basil", price: 14.00, category: "Pizzas", isAvailable: true),
        MenuItem(id: "mi-031", truckId: "truck-004", name: "Pepperoni Pizza", description: "Cup & char pepperoni, mozzarella", price: 15.00, category: "Pizzas", isAvailable: true),
        MenuItem(id: "mi-032", truckId: "truck-004", name: "Truffle Mushroom Pizza", description: "Wild mushrooms, truffle oil, fontina", price: 17.00, category: "Pizzas", isAvailable: true),
        MenuItem(id: "mi-033", truckId: "truck-004", name: "Garlic Knots", description: "Fresh-baked, parmesan, marinara", price: 6.00, category: "Sides", isAvailable: true),

        // Sugar Rush
        MenuItem(id: "mi-060", truckId: "truck-008", name: "Churros", description: "Cinnamon sugar, chocolate dipping sauce", price: 6.00, category: "Sweets", isAvailable: true),
        MenuItem(id: "mi-061", truckId: "truck-008", name: "Ice Cream Sandwich", description: "Fresh-baked cookies, house-made ice cream", price: 7.00, category: "Sweets", isAvailable: true),
        MenuItem(id: "mi-062", truckId: "truck-008", name: "Funnel Cake", description: "Classic with powdered sugar or loaded with toppings", price: 8.00, category: "Sweets", isAvailable: true),
        MenuItem(id: "mi-063", truckId: "truck-008", name: "Milkshake", description: "Hand-spun, your choice of flavor", price: 6.50, category: "Drinks", isAvailable: true),

        // Burger Blitz
        MenuItem(id: "mi-070", truckId: "truck-009", name: "Classic Smash Burger", description: "Double patty, American cheese, pickles, secret sauce", price: 10.00, category: "Burgers", isAvailable: true),
        MenuItem(id: "mi-071", truckId: "truck-009", name: "Bacon Smash", description: "Double patty, thick-cut bacon, cheddar, BBQ sauce", price: 12.00, category: "Burgers", isAvailable: true),
        MenuItem(id: "mi-072", truckId: "truck-009", name: "Truffle Fries", description: "Crispy fries, truffle oil, parmesan", price: 6.00, category: "Sides", isAvailable: true),
        MenuItem(id: "mi-073", truckId: "truck-009", name: "Onion Rings", description: "Beer-battered, ranch dipping sauce", price: 5.00, category: "Sides", isAvailable: true),
    ]

    // MARK: - Reviews
    static let reviews: [Review] = [
        Review(id: "rev-001", truckId: "truck-001", authorId: "user-001", authorName: "Sarah M.", rating: 5, text: "Best tacos in Austin! The al pastor is incredible. Fresh tortillas make all the difference.", date: Date().addingTimeInterval(-86400 * 2)),
        Review(id: "rev-002", truckId: "truck-001", authorId: "user-002", authorName: "James K.", rating: 5, text: "Went here for lunch and was blown away. The super burrito is massive and delicious.", date: Date().addingTimeInterval(-86400 * 5)),
        Review(id: "rev-003", truckId: "truck-001", authorId: "user-003", authorName: "Emily R.", rating: 4, text: "Great food, but the wait can be long during lunch rush. Worth it though!", date: Date().addingTimeInterval(-86400 * 8)),
        Review(id: "rev-004", truckId: "truck-002", authorId: "user-001", authorName: "Sarah M.", rating: 4, text: "Solid BBQ. The brisket is tender and smoky. Mac and cheese is a must-get side.", date: Date().addingTimeInterval(-86400 * 3)),
        Review(id: "rev-005", truckId: "truck-002", authorId: "user-004", authorName: "Mike D.", rating: 5, text: "This is what Texas BBQ should taste like. Joe knows what he's doing!", date: Date().addingTimeInterval(-86400 * 7)),
        Review(id: "rev-006", truckId: "truck-004", authorId: "user-005", authorName: "Lisa T.", rating: 5, text: "The margherita pizza is perfection. Crispy crust, fresh ingredients. Better than most restaurants!", date: Date().addingTimeInterval(-86400 * 1)),
        Review(id: "rev-007", truckId: "truck-004", authorId: "user-006", authorName: "Carlos V.", rating: 4, text: "Wood-fired pizza from a truck?! Mind blown. The truffle mushroom is insane.", date: Date().addingTimeInterval(-86400 * 4)),
        Review(id: "rev-008", truckId: "truck-008", authorId: "user-007", authorName: "Amanda W.", rating: 5, text: "The churros are life-changing. Crispy outside, soft inside. Perfect chocolate sauce.", date: Date().addingTimeInterval(-86400 * 2)),
        Review(id: "rev-009", truckId: "truck-008", authorId: "user-008", authorName: "David L.", rating: 5, text: "Best dessert truck in the city! The ice cream sandwiches are massive and so good.", date: Date().addingTimeInterval(-86400 * 6)),
        Review(id: "rev-010", truckId: "truck-009", authorId: "user-009", authorName: "Rachel P.", rating: 4, text: "Great smash burgers. The secret sauce is addictive. Truffle fries are a solid add-on.", date: Date().addingTimeInterval(-86400 * 3)),
    ]

    // MARK: - Coupons
    static let coupons: [Coupon] = [
        Coupon(id: "coup-001", truckId: "truck-001", truckName: "Taco Libre", code: "TACO10", description: "10% off orders over $20", discountType: .percentage, discountValue: 10, expiresAt: Date().addingTimeInterval(86400 * 18), maxRedemptions: 200, currentRedemptions: 47, revenueSharePercent: 15, isActive: true),
        Coupon(id: "coup-002", truckId: "truck-002", truckName: "Smokin' Joe's BBQ", code: "SMOKY3", description: "$3 off any combo meal", discountType: .fixedAmount, discountValue: 3, expiresAt: Date().addingTimeInterval(86400 * 10), maxRedemptions: 100, currentRedemptions: 23, revenueSharePercent: 15, isActive: true),
        Coupon(id: "coup-003", truckId: "truck-004", truckName: "The Rolling Pin", code: "PIZZA20", description: "20% off any large pizza", discountType: .percentage, discountValue: 20, expiresAt: Date().addingTimeInterval(86400 * 25), maxRedemptions: 150, currentRedemptions: 62, revenueSharePercent: 15, isActive: true),
        Coupon(id: "coup-004", truckId: "truck-008", truckName: "Sugar Rush", code: "SWEET5", description: "$5 off when you spend $15+", discountType: .fixedAmount, discountValue: 5, expiresAt: Date().addingTimeInterval(86400 * 14), maxRedemptions: 100, currentRedemptions: 35, revenueSharePercent: 15, isActive: true),
        Coupon(id: "coup-005", truckId: "truck-010", truckName: "East Meets West", code: "FUSE15", description: "15% off your first order", discountType: .percentage, discountValue: 15, expiresAt: Date().addingTimeInterval(86400 * 30), maxRedemptions: 300, currentRedemptions: 89, revenueSharePercent: 15, isActive: true),
    ]

    // MARK: - Ad Packages
    static let adPackages: [AdPackage] = [
        AdPackage(id: "ad-001", truckId: "truck-001", name: "Spotlight", description: "Promoted section placement", price: 29.99, durationDays: 7, impressionsIncluded: 5000, startDate: Date().addingTimeInterval(-86400 * 3), endDate: Date().addingTimeInterval(86400 * 4), isActive: true),
        AdPackage(id: "ad-002", truckId: "truck-004", name: "Featured", description: "Top of search + promoted", price: 59.99, durationDays: 14, impressionsIncluded: 15000, startDate: Date().addingTimeInterval(-86400 * 5), endDate: Date().addingTimeInterval(86400 * 9), isActive: true),
        AdPackage(id: "ad-003", truckId: "truck-010", name: "Premium", description: "Featured + push notifications", price: 99.99, durationDays: 30, impressionsIncluded: 50000, startDate: Date().addingTimeInterval(-86400 * 10), endDate: Date().addingTimeInterval(86400 * 20), isActive: true),
    ]

    // MARK: - Helpers
    static func menuItems(forTruck truckId: String) -> [MenuItem] {
        menuItems.filter { $0.truckId == truckId }
    }

    static func reviews(forTruck truckId: String) -> [Review] {
        reviews.filter { $0.truckId == truckId }
    }

    static func coupons(forTruck truckId: String) -> [Coupon] {
        coupons.filter { $0.truckId == truckId }
    }
}
