//
//  APIService.swift
//  YoutubeDislikeChecker
//
//  Created by Elvis Cheng on 25/2/2025.
//

import Foundation
import RxSwift

protocol APIServiceProtocol: AnyObject {
    func getVideoStats(with videoID: String?, completion: @escaping (Bool, VideoStatsModel?, Error?) -> Void)
}

final class APIService: APIServiceProtocol {
    private let disposeBag = DisposeBag()
    
    func getVideoStats(with videoID: String?, completion: @escaping (Bool, VideoStatsModel?, Error?) -> Void) {
        guard let videoID else {
            completion(false, nil, APIError.invalidVideoID)
            return
        }
        
        let request = APIRequest(parameters: ["videoId": videoID]).make(with: Endpoints.videoStatsURL)
        NetworkManager.shared
            .send(with: request, as: VideoStatsModel.self)
            .subscribe(onSuccess: { data in
                completion(true, data, nil)
            },onFailure: { error in
                completion(false, nil, error)
            })
            .disposed(by: disposeBag)
    }
}
