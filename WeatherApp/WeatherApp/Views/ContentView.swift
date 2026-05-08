//
//  ContentView.swift
//  WeatherApp
//
//  Created by Abhishek Khedekar on 27/04/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Get Cord") {
                Task {
                    let geocodingClient = GeocodingClient()
                    let weatherClient = WeatherClient()
                    let location = try await geocodingClient.getCoordinatedByCity("Pune")
                    let weather = try await weatherClient.getWeatherFor(location: location!)
                    print(weather)
                }
            }

        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
