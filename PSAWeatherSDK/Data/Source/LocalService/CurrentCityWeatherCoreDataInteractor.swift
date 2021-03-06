//
//  CoreDataInteractor.swift
//  PSAWeatherSDK
//
//  Created by Mohamed Lamine Belfekih on 16/01/2021.
//

import Foundation
import CoreData

class CurrentCityWeatherCoreDataInteractor {
    
    /// saveCurrentCityWeather method allow us to save the current weather of a city in coredata
    /// - Parameter currentCityWeather:  the fetch currentCityWeather Model
    /// - Returns a Result of **CurrentCityWeather** or an **error**
    func saveCurrentCityWeather(_ currentCityWeather: CurrentCityWeatherModel?) -> Result<CurrentCityWeather, Error> {
        if let cityWeather = currentCityWeather {
            
            let wind = Wind(context: PersistenceService.context)
            wind.speed = cityWeather.wind.speed
            wind.degree = Int16(cityWeather.wind.deg)
            
            let clouds = Clouds(context: PersistenceService.context)
            clouds.cloudiness = Int16(cityWeather.clouds.all)
            
            let main = Main(context: PersistenceService.context)
            main.temperature = round(cityWeather.main.temp)
            main.minTemperature = round(cityWeather.main.temp_min)
            main.maxTemperature = round(cityWeather.main.temp_max)
            main.feelsLike = round(cityWeather.main.feels_like)
            main.pressure = Int16(cityWeather.main.pressure)
            main.humidity = Int16(cityWeather.main.humidity)
            
            let coord = Coord(context: PersistenceService.context)
            coord.lon = cityWeather.coord.lon
            coord.lat = cityWeather.coord.lat
            
            var weatherArray = [Weather]()
            for weatherModel in cityWeather.weather {
                let weather = Weather(context: PersistenceService.context)
                weather.id = Int64(weatherModel.id)
                weather.main = weatherModel.main
                weather.weatherDescription = weatherModel.description
                weather.icon = weatherModel.icon
                weatherArray.append(weather)
            }
            
            let currentCityWeather = CurrentCityWeather(context: PersistenceService.context)
            currentCityWeather.cityName = cityWeather.name
            currentCityWeather.cityId = Int64(cityWeather.id)
            currentCityWeather.date = Date(timeIntervalSince1970: TimeInterval(cityWeather.dt))
            currentCityWeather.visibility = Int16(cityWeather.visibility)
            
            currentCityWeather.wind = wind
            currentCityWeather.clouds = clouds
            currentCityWeather.main = main
            currentCityWeather.coord = coord
            
            currentCityWeather.weathers = NSSet.init(array: weatherArray)
            
            do {
                try PersistenceService.context.save()
                return .success(currentCityWeather)
            } catch {
                return .failure(CoreDataError.savingError)
            }
        }
        return .failure(CoreDataError.imputError)
    }
     
    /// removeSavedWeathersFromCoreData removes all the saved weathers and citys from core data
    func removeSavedWeathersFromCoreData() {
        let fetchRequest = NSFetchRequest<CurrentCityWeather>(entityName: "CurrentCityWeather")
        if let result = try? PersistenceService.context.fetch(fetchRequest) {
            for object in result {
                PersistenceService.context.delete(object)
            }
        }
    }
    
    /// remove a specific weather with CityName
    /// - Parameter : cityName 
    func removedSavedWeatherFromCoreData(with cityName: String) {
        let fetchRequest = NSFetchRequest<CurrentCityWeather>(entityName: "CurrentCityWeather")
        if let result = try? PersistenceService.context.fetch(fetchRequest) {
            let currentCityWeatherToDelete = result.first {
                $0.cityName == cityName
            }
            if let currentWeather = currentCityWeatherToDelete {
                PersistenceService.context.delete(currentWeather)
            }
        }
        try? PersistenceService.context.save()
    }
    
    /// - Returns a list of the saved CurrentCityWeather 
    func getSavedWeathersFromCoreData() -> [CurrentCityWeather]? {
        let request = NSFetchRequest<CurrentCityWeather>(entityName: "CurrentCityWeather")
        let fetchResult = try? PersistenceService.context.fetch(request)
        return fetchResult
    }
    
    /// - Returns bool checking if a given city name exist in database
    func cityExistsInDatabase(cityName: String) -> Bool {
        if let cities = getSavedWeathersFromCoreData() {
            return cities.map{ $0.cityName.lowercased() }.contains(cityName)
        }
        return false
    }
    
    func haveMaximumSavedCities() -> Bool{
        return getSavedWeathersFromCoreData()?.count == 20
    }
}
