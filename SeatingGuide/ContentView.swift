//
//  ContentView.swift
//  SeatingGuide
//
//  Created by Igor Malyarov on 25.06.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    //TODO: - заменить на UserDefaults
    @State var area: Double = 200.0
    @State var isKitchenAreaIncluded: Bool = false
    
    var body: some View {
        let seatingAreaInSquareFeet = Measurement(value: area, unit: UnitArea.squareMeters).converted(to: UnitArea.squareFeet).value * (isKitchenAreaIncluded ? 0.6 : 1.0)
        let seatingArea = area * (isKitchenAreaIncluded ? 0.6 : 1.0)
        let kitchenArea = area * (isKitchenAreaIncluded ? 0.4 : 0.4 / 0.6)

        return NavigationView {
            Form {
                Section(header: Text("Restaurant Area".uppercased()), footer: Text("Drag the slider to change Seating or Total (if Kitchen is included) area of the Restaurant.").lineLimit(3)) {

                    HStack {
                        Text("\(isKitchenAreaIncluded ? "Total" : "Seating"): \(Int(area)) sq meters")
                        Slider(value: $area, from: 20.0, through: 500.0, by: 10.0)
                    }
                    Toggle(isOn: $isKitchenAreaIncluded) {
                        Text("Kitchen area (40%) is included")
                    }
                    Text("Seating \(Int(seatingArea)) + Kitchen \(Int(kitchenArea)) = Total \(Int(seatingArea + kitchenArea)) sq m").color(.secondary)
                }
                    
                Section(header: Text("Number of Guests".uppercased()))
                {
//                  https://totalfood.com/how-to-create-a-restaurant-floor-plan/
//                  Fine Dining: 18 – 20 Square Feet
//                  Full Service Restaurant Dining: 12 – 15 Square Feet
//                  Counter Service: 18 – 20 Square Feet
//                  Fast Food Minimum: 11 – 14 Square Feet
//                  Table Service, Hotel/Club:  15 – 18 Square Feet
//                  Banquet, Minimum: 10 – 11 Square Feet
                    
                    HStack {
                        Text("Fine Dining")
                        Spacer()
                        Text("\(Int(seatingAreaInSquareFeet / 20)) - \(Int(seatingAreaInSquareFeet / 18))")
                    }
                    HStack {
                        Text("Full Service Restaurant Dining")
                        Spacer()
                        Text("\(Int(seatingAreaInSquareFeet / 15)) - \(Int(seatingAreaInSquareFeet / 12))")
                    }
                    HStack {
                        Text("Counter Service")
                        Spacer()
                        Text("\(Int(seatingAreaInSquareFeet / 20)) - \(Int(seatingAreaInSquareFeet / 18))")
                    }
                    HStack {
                        Text("Fast Food, Maximum")
                        Spacer()
                        Text("\(Int(seatingAreaInSquareFeet / 14)) - \(Int(seatingAreaInSquareFeet / 11))")
                    }
                    HStack {
                        Text("Table Service, Hotel/Club")
                        Spacer()
                        Text("\(Int(seatingAreaInSquareFeet / 18)) - \(Int(seatingAreaInSquareFeet / 15))")
                    }
                    HStack {
                        Text("Banquet, Maximum")
                        Spacer()
                        Text("\(Int(seatingAreaInSquareFeet / 11)) - \(Int(seatingAreaInSquareFeet / 10))")
                    }
                }
                
                Section(header: Text("Notes".uppercased())) {
                    //TODO: - надо бы текст переисать (копирайт!!)
                    //TODO: - заменить футы на (санти)метры
                    Text("For safety reasons and to allow for the free flow of traffic for diners and servers, the traffic path between occupied chairs should be at least 18 inches wide and you should leave at least 4 – 5 feet per table, including chair space. This allows for free movement of servers between stations and the kitchen and provides enough comfortable room for the guests to move around. It is very important for safety reasons that there is enough space for the guest and staff to move around and that the aisles are clear, especially in case there is a fire.").italic()
                        .font(.caption)
                        .lineLimit(nil)
                        .foregroundColor(Color.secondary)
                }
                    
                .navigationBarTitle(Text("Seating Guidelines"))
            }
            
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(area: 200.0)
//                .environment(\.colorScheme, .dark)
            ContentView(area: 200.0).environment(\.sizeCategory, .accessibilityMedium)
        }
    }
}
#endif
