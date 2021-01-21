//
//  Daily+CoreDataProperties.swift
//  PSAWeatherSDK
//
//  Created by Mohamed Lamine Belfekih on 17/01/2021.
//
//

import Foundation
import CoreData


extension Daily {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Daily> {
        return NSFetchRequest<Daily>(entityName: "Daily")
    }

    @NSManaged public var date: Date
    @NSManaged public var humidity: Int16
    @NSManaged public var maxTemperature: Int16
    @NSManaged public var minTemperature: Int16
    @NSManaged public var pressure: Int16
    @NSManaged public var sunrise: Date
    @NSManaged public var sunset: Date
    @NSManaged public var ofWeatherDetails: WeatherDetails?
    @NSManaged public var weathers: NSSet?

}

// MARK: Generated accessors for weathers
extension Daily {

    @objc(addWeathersObject:)
    @NSManaged public func addToWeathers(_ value: Weather)

    @objc(removeWeathersObject:)
    @NSManaged public func removeFromWeathers(_ value: Weather)

    @objc(addWeathers:)
    @NSManaged public func addToWeathers(_ values: NSSet)

    @objc(removeWeathers:)
    @NSManaged public func removeFromWeathers(_ values: NSSet)

}

extension Daily : Identifiable {

}
