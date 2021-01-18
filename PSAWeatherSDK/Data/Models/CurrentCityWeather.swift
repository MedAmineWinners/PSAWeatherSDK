//
//  CurrentCityWeather.swift
//  PSAWeatherSDK
//
//  Created by Mohamed Lamine Belfekih on 16/01/2021.
//

import Foundation
struct CurrentCityWeatherModel : Codable {
    let coord : CoordModel
    let weather : [WeatherModel]
    let main : MainModel
    let visibility : Int
    let wind : WindModel
    let clouds : CloudsModel
    let dt : Int
    let id : Int
    let name : String
}

struct CoordModel : Codable {
    let lon : Double
    let lat : Double
}

struct MainModel : Codable {
    let temp : Double
    let feels_like : Double
    let temp_min : Double
    let temp_max : Double
    let pressure : Int
    let humidity : Int
}

struct WeatherModel : Codable {
    let id : Int
    let main : String
    let description : String
    let icon : String
}

struct CloudsModel : Codable {
    let all : Int
}

struct WindModel : Codable {
    let speed : Double
    let deg : Int
}
