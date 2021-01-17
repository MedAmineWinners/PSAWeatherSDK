//
//  WeatherDetailsCoreDataInteractor.swift
//  PSAWeatherSDK
//
//  Created by Mohamed Lamine Belfekih on 17/01/2021.
//

import Foundation
import CoreData

class WeatherDetailsCoreDataInteractor {
    
    /// saveWeatherDetails method allow us to save the weatherDetails of the current weather of a city in coredata
    /// - Parameter currentWeather:  the saved currentCityWeather
    /// - Parameter weatherDetailsModel: the remotely fetched WeatherDetailsModel
    /// - Returns a Result of **WeatherDetails** or an **error**
    func saveWeatherDetails(with weatherDetailsModel: WeatherDetailsModel, for currentWeather: CurrentCityWeather) -> Result<WeatherDetails, Error> {
        let weatherDetails = WeatherDetails(context: PersistenceService.context)
        
        var dailyForcastList = [Daily]()
        for daily in weatherDetailsModel.daily {
            let dailyForcast = Daily(context: PersistenceService.context)
            dailyForcast.date = Date(timeIntervalSince1970: TimeInterval(daily.dt))
            dailyForcast.humidity = Int16(daily.humidity)
            dailyForcast.maxTemperature = Int16(round(daily.temp.max))
            dailyForcast.minTemperature = Int16(round(daily.temp.min))
            dailyForcast.pressure = Int16(daily.pressure)
            
            var weatherArray = [Weather]()
            for weatherModel in daily.weather {
                let weather = Weather(context: PersistenceService.context)
                weather.id = Int64(weatherModel.id)
                weather.main = weatherModel.main
                weather.weatherDescription = weatherModel.description
                weather.icon = weatherModel.icon
                weatherArray.append(weather)
            }
            dailyForcast.weathers = NSSet.init(array: weatherArray)
            dailyForcastList.append(dailyForcast)
        }
        
        var hourlyForcastList = [Hourly]()
        for hourly in weatherDetailsModel.hourly {
            let hourlyForcast = Hourly(context: PersistenceService.context)
            hourlyForcast.date = Date(timeIntervalSince1970: TimeInterval(hourly.dt))
            hourlyForcast.feelsLike = Int16(hourly.feels_like)
            hourlyForcast.temperature = Int16(hourly.temp)
            
            var weatherArray = [Weather]()
            for weatherModel in hourly.weather {
                let weather = Weather(context: PersistenceService.context)
                weather.id = Int64(weatherModel.id)
                weather.main = weatherModel.main
                weather.weatherDescription = weatherModel.description
                weather.icon = weatherModel.icon
                weatherArray.append(weather)
            }
            hourlyForcast.weathers = NSSet.init(array: weatherArray)
            hourlyForcastList.append(hourlyForcast)
        }
        
        weatherDetails.dailyForcast = NSSet.init(array: dailyForcastList)
        weatherDetails.hourlyForcast = NSSet.init(array: hourlyForcastList)
        
        currentWeather.weatherDetails = weatherDetails
        
        do {
            try PersistenceService.context.save()
            return .success(weatherDetails)
        } catch  {
            return .failure(CoreDataError.savingError)
        }
    }
    
    /// removeSaved WeatherDetails From CoreData
    func removeSavedWeathersFromCoreData() {
        let fetchRequest = NSFetchRequest<WeatherDetails>(entityName: "WeatherDetails")
        if let result = try? PersistenceService.context.fetch(fetchRequest) {
            for object in result {
                PersistenceService.context.delete(object)
            }
        }
    }
    
    /// remove a specific weather details with CityName
    /// - Parameter : cityName
    func removedSavedWeatherFromCoreData(of currentWeather: CurrentCityWeather) {
        let fetchRequest = NSFetchRequest<WeatherDetails>(entityName: "WeatherDetails")
        if let result = try? PersistenceService.context.fetch(fetchRequest) {
            let weatherDetailsToDelete = result.first {
                $0.ofCurrentCity?.cityName == currentWeather.cityName
            }
            if let currentWeather = weatherDetailsToDelete {
                PersistenceService.context.delete(currentWeather)
            }
        }
    }
   
}
