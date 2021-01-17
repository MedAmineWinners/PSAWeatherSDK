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
        if result is CurrentCityWeather {
           
        }
    }
    
    func PSAWeatherSDKDidFailWithError(error: String) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        PSAWeatherSDK.shared.delegate = self
//        PSAWeatherSDK.shared.configure(with: "216f0a6fde418838d9d47d4cb09238f5")
//        PSAWeatherSDK.shared.addCity(with: "Paris")
        
        // Do any additional setup after loading the view.
    }


}

