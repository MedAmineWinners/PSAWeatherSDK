//
//  Coord+CoreDataProperties.swift
//  PSAWeatherSDK
//
//  Created by Mohamed Lamine Belfekih on 17/01/2021.
//
//

import Foundation
import CoreData


extension Coord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Coord> {
        return NSFetchRequest<Coord>(entityName: "Coord")
    }

    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var ofCurrentWeather: CurrentCityWeather?

}

extension Coord : Identifiable {

}
