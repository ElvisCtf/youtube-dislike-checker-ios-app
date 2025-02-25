//
//  CheckerViewModel.swift
//  YoutubeDislikeChecker
//
//  Created by Elvis Cheng on 25/2/2025.
//

import RxSwift
import RxCocoa
import Foundation

final class CheckerViewModel {
    let videoStatsObservable = PublishRelay<VideoStatsModel>()
    
    private let apiService: APIServiceProtocol
    
    init(apiServie: APIService = APIService()) {
        self.apiService = apiServie
        
    }
    
    func getVideoStats(with url: String) {
        if let videoID = extractYouTubeID(from: url) {
            apiService.getVideoStats(with: videoID) { [weak self] success, data, error in
                guard let self else { return }
                if success {
                    if let data {
                        self.videoStatsObservable.accept(data)
                    }
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
