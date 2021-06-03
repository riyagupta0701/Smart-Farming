//
//  WeatherManager.swift
//  Smart Farming
//
//  Created by Riya Gupta on 06/05/21.
//

import UIKit

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/onecall?appid=186c5133fa811a3bf192edff1ed55835&exclude=hourly,daily&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(latitude: Double, longitude: Double) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        
        if let url = URL(string: urlString) {

            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }

                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let temp = decodedData.current.temp
            let pressure = decodedData.current.pressure
            let humidity = decodedData.current.humidity
            let uvi = decodedData.current.uvi
            let wind_speed = decodedData.current.wind_speed
            let precipitation = decodedData.minutely[0].precipitation

            let weather = WeatherModel(temperature: temp, pressure: pressure, humidity: humidity, uvi: uvi, wind_speed: wind_speed, precipitation: precipitation)
            return weather
            
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
