//
//  WeatherDetails+CoreDataProperties.swift
//  PSAWeatherSDK
//
//  Created by Mohamed Lamine Belfekih on 17/01/2021.
//
//

import Foundation
import CoreData


extension WeatherDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherDetails> {
        return NSFetchRequest<WeatherDetails>(entityName: "WeatherDetails")
    }

    @NSManaged public var dailyForcast: NSSet?
    @NSManaged public var hourlyForcast: NSSet?
    @NSManaged public var ofCurrentCity: CurrentCityWeather?

}

// MARK: Generated accessors for dailyForcast
extension WeatherDetails {

    @objc(addDailyForcastObject:)
    @NSManaged public func addToDailyForcast(_ value: Daily)

    @objc(removeDailyForcastObject:)
    @NSManaged public func removeFromDailyForcast(_ value: Daily)

    @objc(addDailyForcast:)
    @NSManaged public func addToDailyForcast(_ values: NSSet)

    @objc(removeDailyForcast:)
    @NSManaged public func removeFromDailyForcast(_ values: NSSet)

}

// MARK: Generated accessors for hourlyForcast
extension WeatherDetails {

    @objc(addHourlyForcastObject:)
    @NSManaged public func addToHourlyForcast(_ value: Hourly)

    @objc(removeHourlyForcastObject:)
    @NSManaged public func removeFromHourlyForcast(_ value: Hourly)

    @objc(addHourlyForcast:)
    @NSManaged public func addToHourlyForcast(_ values: NSSet)

    @objc(removeHourlyForcast:)
    @NSManaged public func removeFromHourlyForcast(_ values: NSSet)

}

extension WeatherDetails : Identifiable {

}
