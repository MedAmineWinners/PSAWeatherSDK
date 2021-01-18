//
//  Main+CoreDataProperties.swift
//  PSAWeatherSDK
//
//  Created by Mohamed Lamine Belfekih on 17/01/2021.
//
//

import Foundation
import CoreData


extension Main {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Main> {
        return NSFetchRequest<Main>(entityName: "Main")
    }

    @NSManaged public var feelsLike: Double
    @NSManaged public var humidity: Int16
    @NSManaged public var maxTemperature: Double
    @NSManaged public var minTemperature: Double
    @NSManaged public var pressure: Int16
    @NSManaged public var temperature: Double
    @NSManaged public var ofCurrentWeather: CurrentCityWeather?

}

extension Main : Identifiable {

}
