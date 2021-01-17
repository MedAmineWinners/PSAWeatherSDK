//
//  Hourly+CoreDataProperties.swift
//  PSAWeatherSDK
//
//  Created by Mohamed Lamine Belfekih on 17/01/2021.
//
//

import Foundation
import CoreData


extension Hourly {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hourly> {
        return NSFetchRequest<Hourly>(entityName: "Hourly")
    }

    @NSManaged public var date: Date?
    @NSManaged public var feelsLike: Int16
    @NSManaged public var temperature: Int16
    @NSManaged public var ofWeatherDetails: WeatherDetails?
    @NSManaged public var weathers: NSSet?

}

// MARK: Generated accessors for weathers
extension Hourly {

    @objc(addWeathersObject:)
    @NSManaged public func addToWeathers(_ value: Weather)

    @objc(removeWeathersObject:)
    @NSManaged public func removeFromWeathers(_ value: Weather)

    @objc(addWeathers:)
    @NSManaged public func addToWeathers(_ values: NSSet)

    @objc(removeWeathers:)
    @NSManaged public func removeFromWeathers(_ values: NSSet)

}

extension Hourly : Identifiable {

}
