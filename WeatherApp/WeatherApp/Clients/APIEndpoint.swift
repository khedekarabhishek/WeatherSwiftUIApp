//
//  APIEndpoint.swift
//  WeatherApp
//
//  Created by Abhishek Khedekar on 27/04/26.
//

import Foundation

enum APIEndpoint {
    static let baseURL = "https://api.openweathermap.org"

    case coordinatesByLocationName(String)
    case weatherByLatLong(Double, Double)
    
    private var path: String {
        switch self {
        case .coordinatesByLocationName(let locationName):
            return "/geo/1.0/direct?q=\(locationName)&appid=\(Constants.Keys.APIKey)"
        case .weatherByLatLong(let lat, let lon):
            return "/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(Constants.Keys.APIKey)"
        }
    }
    
    static func endpointURL(for endpoint: APIEndpoint) -> URL {
        let urlPath = endpoint.path
        return URL(string: baseURL + urlPath)!
    }
}
