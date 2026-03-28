import SwiftUI

struct TruckAnnotationView: View {
    let truck: FoodTruck

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Circle()
                    .fill(truck.isOpen ? Color.rollUpOrange : Color.rollUpGray)
                    .frame(width: 40, height: 40)

                Text(truck.cuisineType.icon)
                    .font(.system(size: 20))
            }
            .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)

            // Triangle pointer
            Triangle()
                .fill(truck.isOpen ? Color.rollUpOrange : Color.rollUpGray)
                .frame(width: 12, height: 8)
                .offset(y: -2)
        }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.closeSubpath()
        return path
    }
}

#Preview {
    HStack(spacing: 20) {
        TruckAnnotationView(truck: SampleData.trucks[0])
        TruckAnnotationView(truck: SampleData.trucks[2]) // closed
    }
}
