//
//  CurrentCityWeather+CoreDataProperties.swift
//  PSAWeatherSDK
//
//  Created by Mohamed Lamine Belfekih on 17/01/2021.
//
//

import Foundation
import CoreData


extension CurrentCityWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrentCityWeather> {
        return NSFetchRequest<CurrentCityWeather>(entityName: "CurrentCityWeather")
    }

    @NSManaged public var base: String?
    @NSManaged public var cityId: Int64
    @NSManaged public var cityName: String?
    @NSManaged public var date: Date?
    @NSManaged public var visibility: Int16
    @NSManaged public var clouds: Clouds?
    @NSManaged public var coord: Coord?
    @NSManaged public var main: Main?
    @NSManaged public var weatherDetails: WeatherDetails?
    @NSManaged public var weathers: NSSet?
    @NSManaged public var wind: Wind?

}

// MARK: Generated accessors for weathers
extension CurrentCityWeather {

    @objc(addWeathersObject:)
    @NSManaged public func addToWeathers(_ value: Weather)

    @objc(removeWeathersObject:)
    @NSManaged public func removeFromWeathers(_ value: Weather)

    @objc(addWeathers:)
    @NSManaged public func addToWeathers(_ values: NSSet)

    @objc(removeWeathers:)
    @NSManaged public func removeFromWeathers(_ values: NSSet)

}

extension CurrentCityWeather : Identifiable {

}
