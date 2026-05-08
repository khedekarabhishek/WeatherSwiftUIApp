//
//  Weather.swift
//  WeatherApp
//
//  Created by Abhishek Khedekar on 27/04/26.
//

import Foundation

struct WeatherResponse: Decodable {
    let main: Weather
}

struct Weather: Decodable {
    let temp: Double
}
