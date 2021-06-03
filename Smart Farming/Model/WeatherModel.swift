//
//  WeatherModel.swift
//  Smart Farming
//
//  Created by Riya Gupta on 07/05/21.
//

import Foundation

struct WeatherModel {
    
    let temperature: Double
    let pressure: Double
    let humidity: Double
    let uvi: Double
    let wind_speed: Double
    let precipitation: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var pressureString: String {
        return String(format: "%.1f", pressure)
    }
    
    var humidityString: String {
        return String(format: "%.1f", humidity)
    }
    
    var uviString: String {
        return String(format: "%.1f", uvi)
    }
    
    var windspeedString: String {
        return String(format: "%.1f", wind_speed)
    }
    
    var precipitationString: String {
        return String(format: "%.1f", precipitation)
    }    
}
