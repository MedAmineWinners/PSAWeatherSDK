//
//  ViewController.swift
//  PSAWeatherSDKExamples
//
//  Created by Mohamed Lamine Belfekih on 16/01/2021.
//

import UIKit
import PSAWeatherSDK

class ViewController: UIViewController, PSAWeatherSDKDelegate {

    func PSAWeatherSDKDidFinishWithSuccess<T>(result: T) {
        if let cityWeather =  result as? CurrentCityWeather {
            PSAWeatherSDK.shared.getCityWeatherDetails(of: cityWeather)
        }
        
        if let weatherDetails = result as? WeatherDetails {
            if weatherDetails.ofCurrentCity?.cityName == "Arrondissement de Marseille" {
                PSAWeatherSDK.shared.getSavedCitiesCurrentWeatherList()
            }
        }
        
        if let cities = result as? [CurrentCityWeather] {
            
        }
    }
    
    func PSAWeatherSDKDidFailWithError(error: String) {
        print("error")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  //  PSAWeatherSDK.shared.delegate = self
   // PSAWeatherSDK.shared.configure(with: "216f0a6fde418838d9d47d4cb09238f5")
    //PSAWeatherSDK.shared.addCity(with: "pakaka")
    //PSAWeatherSDK.shared.addCity(with: "Marseille")
        
        
        // Do any additional setup after loading the view.
    }
}
