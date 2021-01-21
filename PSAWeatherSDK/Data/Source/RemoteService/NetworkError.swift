//
//  NetworkError.swift
//  PSAWeatherSDK
//
//  Created by Mohamed Lamine Belfekih on 16/01/2021.
//

import Foundation

enum NetWorkError: Error {
    case decodingError
    case domainError
    case networkError
    case reachabilityError
}

extension NetWorkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return NSLocalizedString(
                "An Error occured please try again",
                comment: ""
            )
        case .domainError:
            return NSLocalizedString(
                "An Error occured please try again",
                comment: ""
            )
        case .networkError:
            return NSLocalizedString(
                "An Error occured please try again",
                comment: ""
            )
        case .reachabilityError:
            return NSLocalizedString(
                "Please Verify your Internet connection",
                comment: ""
            )
        }
    }
}
