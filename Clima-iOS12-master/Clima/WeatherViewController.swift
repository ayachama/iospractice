//
//  ViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "77aea9fefa18f16196f4adc64046e2bc"
    /***Get your own App ID at https://openweathermap.org/appid ****/
    var isCelsius:Bool = true

    //TODO: Declare instance variables here
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
    
    //Pre-linked IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var unitConvert: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO:Set up the location manager here.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        unitConvert.isUserInteractionEnabled = true
        unitConvert.addGestureRecognizer(tapGestureRecognizer)
    }
    
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
    func getWeatherData(url: String, params: [String: String]) {
        Alamofire.request(url, method: .get, parameters: params).responseJSON {
            response in
            if response.result.isSuccess {
                let responseJson = JSON(response.result.value!)
                self.updateWeatherData(weatherResponseJson: responseJson)
            } else {
                print("Error")
            }
            
        }
    }
    
    //MARK: - JSON Parsing
    /***************************************************************/
   
    //Write the updateWeatherData method here:
    func updateWeatherData(weatherResponseJson: JSON){
        if let temp = weatherResponseJson["main"]["temp"].double {
            weatherDataModel.city = weatherResponseJson["name"].stringValue
            weatherDataModel.temperature = Int(temp - 273.15)
            weatherDataModel.condition = weatherResponseJson["weather"][0]["id"].intValue
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            updateUIWithWeatherData(weatherDataModel: weatherDataModel)
        } else {
            cityLabel.text = "Weather Not Available for this location!"
        }
    }

    //MARK: - UI Updates
    /***************************************************************/
    
    //Write the updateUIWithWeatherData method here:
    func updateUIWithWeatherData(weatherDataModel: WeatherDataModel) {
        if isCelsius {
            temperatureLabel.text = "\(String(weatherDataModel.temperature))°"
        } else {
            var temp: Float = Float(weatherDataModel.temperature) * 1.8 + 32
            temperatureLabel.text = "\(String(Int(temp)))°"
        }
        cityLabel.text = weatherDataModel.city
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
    }
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    //Write the didUpdateLocations method here:
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            
            let lat = String(location.coordinate.latitude)
            let lon = String(location.coordinate.longitude)

            let params: [String: String] = ["lat": lat, "lon": lon, "appid": APP_ID]
            
            getWeatherData(url: WEATHER_URL, params: params)
        }
    }
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        locationManager.stopUpdatingLocation()
    }
    
    //MARK: - Switch between Celsius and Fahrenheit.
    /***************************************************************/
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        _ = tapGestureRecognizer.view as! UIImageView
        
        if isCelsius {
            isCelsius = false
            unitConvert.image = UIImage(named: "F_Temp")
        } else {
            isCelsius = true
            unitConvert.image = UIImage(named: "C_Temp")
        }
        updateUIWithWeatherData(weatherDataModel: weatherDataModel)
    }
    
    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    @IBAction func callChangeCity(_ sender: Any) {
        performSegue(withIdentifier: "changeCityName", sender: self)
    }
    
    //Write the userEnteredANewCityName Delegate method here:
    func userEnteredANewCityName(cityEntered: String) {
        let params : [String: String] = ["q": cityEntered, "appid" : APP_ID]
        getWeatherData(url: WEATHER_URL, params: params)
    }
    
    //Write the PrepareForSegue Method here
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCityName" {
            let destinationVC = segue.destination as! ChangeCityViewController
            destinationVC.delegate = self
        }
    }
    
//    override var shouldAutorotate: Bool {
//        return true
//    }
//    
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        return .landscapeLeft
//    }
}


