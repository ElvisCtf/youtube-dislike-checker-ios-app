//
//  NetworkManager.swift
//  YoutubeDislikeChecker
//
//  Created by Elvis Cheng on 25/2/2025.
//

import Foundation
import RxSwift

final class NetworkManager {
    static let shared = NetworkManager()
    private let session: URLSession
    
    private init() {
        self.session = URLSession(configuration: .default)
    }
    
    func send<T: Decodable>(with request: URLRequest, as type: T.Type) -> Single<T> {
        return Single<T>.create { observer in
            let task = self.session.dataTask(with: request) { data, response, error in
                if error != nil {
                    observer(.failure(APIError.invalidVideoID))
                } else if let data {
                    observer(data.decode(as: T.self))
                } else {
                    observer(.failure(APIError.noData))
                }
            }
            task.resume()
            return Disposables.create { task.cancel() }
        }
    }
}

extension Data {
    func decode<T: Decodable>(as type: T.Type) -> Result<T, Error> {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decodedObject = try decoder.decode(T.self, from: self)
            return .success(decodedObject)
        } catch let decodingError {
            return .failure(APIError.decodeFailed)
        }
    }
}
