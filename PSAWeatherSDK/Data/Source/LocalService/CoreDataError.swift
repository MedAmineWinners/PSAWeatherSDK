//
//  CoreDataError.swift
//  PSAWeatherSDK
//
//  Created by Mohamed Lamine Belfekih on 20/01/2021.
//

import Foundation

enum CoreDataError: Error {
    case savingError
    case imputError
    case cityExist
    case maximumCityNumber
}

extension CoreDataError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .savingError:
            return NSLocalizedString(
                "Saving Error please try again",
                comment: ""
            )
        case .imputError:
            return NSLocalizedString(
                "Input Error please try again",
                comment: ""
            )
        case .cityExist:
            return NSLocalizedString(
                "This city exists in database, please try with another one",
                comment: ""
            )
        case .maximumCityNumber:
            return NSLocalizedString(
                "You already have  saved 20 cities, if you want to add it try to remove one !",
                comment: ""
            )
        }
    }
}

