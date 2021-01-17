//
//  Wind+CoreDataProperties.swift
//  PSAWeatherSDK
//
//  Created by Mohamed Lamine Belfekih on 17/01/2021.
//
//

import Foundation
import CoreData


extension Wind {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Wind> {
        return NSFetchRequest<Wind>(entityName: "Wind")
    }

    @NSManaged public var degree: Int16
    @NSManaged public var speed: Double
    @NSManaged public var ofCurrentWeather: CurrentCityWeather?

}

extension Wind : Identifiable {

}
