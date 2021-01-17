//
//  Clouds+CoreDataProperties.swift
//  PSAWeatherSDK
//
//  Created by Mohamed Lamine Belfekih on 17/01/2021.
//
//

import Foundation
import CoreData


extension Clouds {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Clouds> {
        return NSFetchRequest<Clouds>(entityName: "Clouds")
    }

    @NSManaged public var cloudiness: Int16
    @NSManaged public var ofCurrentWeather: CurrentCityWeather?

}

extension Clouds : Identifiable {

}
