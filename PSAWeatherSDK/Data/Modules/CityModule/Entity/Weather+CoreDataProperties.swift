//
//  Weather+CoreDataProperties.swift
//  PSAWeatherSDK
//
//  Created by Mohamed Lamine Belfekih on 17/01/2021.
//
//

import Foundation
import CoreData


extension Weather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Weather> {
        return NSFetchRequest<Weather>(entityName: "Weather")
    }

    @NSManaged public var icon: String?
    @NSManaged public var id: Int64
    @NSManaged public var main: String?
    @NSManaged public var weatherDescription: String?
    @NSManaged public var ofCurrentCity: CurrentCityWeather?

}

extension Weather : Identifiable {

}
