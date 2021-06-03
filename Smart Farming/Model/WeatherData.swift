//
//  WeatherData.swift
//  Smart Farming
//
//  Created by Riya Gupta on 07/05/21.
//

import Foundation

struct WeatherData: Codable {
    let current: Current
    let minutely: [Minutely]
}

struct Current: Codable {
    let temp: Double
    let pressure: Double
    let humidity: Double
    let uvi: Double
    let wind_speed: Double
    
}

struct Minutely: Codable {
    let precipitation: Double
}
