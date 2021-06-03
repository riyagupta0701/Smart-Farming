//
//  HomeViewController.swift
//  Smart Farming
//
//  Created by Riya Gupta on 28/04/21.
//

import UIKit
import CoreLocation
import Firebase

class HomeViewController: UIViewController, WeatherManagerDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var locationButtonLabel: UIButton!
    @IBOutlet weak var profileButtonLabel: UIButton!
    @IBOutlet weak var logoutLabel: UIButton!
    
    @IBOutlet weak var tempValueLabel: UILabel!
    @IBOutlet weak var humidityValueLabel: UILabel!
    @IBOutlet weak var uviValueLabel: UILabel!
    @IBOutlet weak var precipitationValueLabel: UILabel!
    @IBOutlet weak var pressureValueLabel: UILabel!
    @IBOutlet weak var windSpeedValueLabel: UILabel!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
    }
    
    
    @IBAction func locationButton(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.tempValueLabel.text = "\(weather.temperatureString)ºC"
            self.humidityValueLabel.text = "\(weather.humidityString)%"
            self.uviValueLabel.text = "\(weather.uviString)"
            self.precipitationValueLabel.text = "\(weather.precipitationString) mm"
            self.pressureValueLabel.text = "\(weather.pressureString) hPa"
            self.windSpeedValueLabel.text = "\(weather.windspeedString) m/sec"
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    @IBAction func profileButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "homeToProfile", sender: self)
    }
    
    @IBAction func logoutButton(_ sender: UIButton) {
        
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            self.dismiss(animated: true, completion: nil)
            
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
}
