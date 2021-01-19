//
//  WebService .swift
//  PSAWeatherSDK
//
//  Created by Mohamed Lamine Belfekih on 16/01/2021.
//

import Foundation

protocol NetworkSession {
    func loadData(from url: URL,
                  completionHandler: @escaping (Data?, Error?) -> Void)
}

extension URLSession: NetworkSession {
    func loadData(from url: URL,
                  completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: url) { (data, _, error) in
            completionHandler(data, error)
        }
        task.resume()
    }
}

struct Resource<T: Codable> {
    let url: URL
}

enum PSASDKResult<T, SDKError, NetworkError> {
    case success(T)
    case apiFailure(ApiError)
    case failure(NetworkError)
}

class WebService {
    private let session: NetworkSession
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func load<T>(resource: Resource<T>, completion: @escaping (PSASDKResult<T, ApiError, NetWorkError>) -> Void) {
        session.loadData(from: resource.url) { data, error in
            guard let data = data, error == nil else {
                completion(.failure(.domainError))
                return
            }
            let result = try? JSONDecoder().decode(T.self, from: data)
            if let result = result {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } else if let apiError = try? JSONDecoder().decode(ApiError.self, from: data) {
                DispatchQueue.main.async {
                    completion(.apiFailure(apiError))
                }
            }
            else {
                DispatchQueue.main.async {
                    completion(.failure(.decodingError))
                }
            }
        }
    }
}
