//
//  WeatherClient.swift
//  WeatherApp
//
//  Created by Abhishek Khedekar on 27/04/26.
//

import Foundation

struct WeatherClient {
    func getWeatherFor(location: Location) async throws -> Weather {
        let (data, response) = try await URLSession.shared.data(from: APIEndpoint.endpointURL(for: .weatherByLatLong(location.lat, location.lon)))
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
        return weatherResponse.main
    }
}
