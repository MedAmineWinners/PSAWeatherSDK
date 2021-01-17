//
//  Extenions.swift
//  PSAWeatherSDK
//
//  Created by Mohamed Lamine Belfekih on 16/01/2021.
//

import Foundation

extension String {
    func stringToDate(with dateFormatter: DateFormatter) -> Date? {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: self)
        return date
    }
}
