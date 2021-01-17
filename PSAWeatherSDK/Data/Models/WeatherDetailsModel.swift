//
//  WeatherDetailsModel.swift
//  PSAWeatherSDK
//
//  Created by Mohamed Lamine Belfekih on 17/01/2021.
//

import Foundation
struct WeatherDetailsModel : Codable {
    let lat : Double
    let lon : Double
    let timezone : String
    let timezone_offset : Int
    let current : CurrentModel
    let hourly : [HourlyModel]
    let daily : [DailyModel]
}

struct CurrentModel : Codable {
    let dt : Int
    let sunrise : Int
    let sunset : Int
    let temp : Double
    let feels_like : Double
    let pressure : Int
    let humidity : Int
    let dew_point : Double
    let uvi : Double
    let clouds : Int
    let visibility : Int
    let wind_speed : Double
    let wind_deg : Int
    let weather : [WeatherModel]
}

struct DailyModel : Codable {
    let dt : Int
    let sunrise : Int
    let sunset : Int
    let temp : TemperatureModel
    let feels_like : FeelsLikeModel?
    let pressure : Int
    let humidity : Int
    let dew_point : Double
    let wind_speed : Double
    let wind_deg : Int
    let weather : [WeatherModel]
    let clouds : Int
    let pop : Double
    let uvi : Double
}

struct HourlyModel : Codable {
    let dt : Int
    let temp : Double
    let feels_like : Double
    let pressure : Int
    let humidity : Int
    let dew_point : Double
    let uvi : Double
    let clouds : Int
    let visibility : Int
    let wind_speed : Double
    let wind_deg : Int
    let weather : [WeatherModel]
    let pop : Double
}

struct TemperatureModel : Codable {
    let day : Double
    let min : Double
    let max : Double
    let night : Double
    let eve : Double
    let morn : Double
}

struct FeelsLikeModel : Codable {
    let day : Double
    let night : Double
    let eve : Double
    let morn : Double
}
