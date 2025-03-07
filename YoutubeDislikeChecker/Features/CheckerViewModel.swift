//
//  CheckerViewModel.swift
//  YoutubeDislikeChecker
//
//  Created by Elvis Cheng on 25/2/2025.
//

import Foundation
import RxSwift
import RxCocoa
import UniformTypeIdentifiers

final class CheckerViewModel {
    let videoStatsObservable = PublishRelay<Result<VideoStatsModel, Error>>()
    
    private let apiService: APIServiceProtocol
    
    init(apiServie: APIService = APIService()) {
        self.apiService = apiServie
    }
    
    func getVideoStats(with url: String) {
        let videoID = extractYouTubeID(from: url)
        apiService.getVideoStats(with: videoID) { [weak self] success, data, error in
            guard let self else { return }
            if success {
                if let data, !data.isNil() {
                    self.videoStatsObservable.accept(.success(data))
                } else {
                    self.videoStatsObservable.accept(.failure(APIError.noData))
                }
            } else {
                if let error {
                    self.videoStatsObservable.accept(.failure(error))
                } else {
                    self.videoStatsObservable.accept(.failure(APIError.noData))
                }
            }
        }
    }
    
    func extractYouTubeID(from url: String) -> String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/)|(?<=shorts/))([\\w-]++)"
        
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: url.count)
        
        guard let result = regex?.firstMatch(in: url, range: range) else {
            return nil
        }
        
        return (url as NSString).substring(with: result.range)
    }
}
