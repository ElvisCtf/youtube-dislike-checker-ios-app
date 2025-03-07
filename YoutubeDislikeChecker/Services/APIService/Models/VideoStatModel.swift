//
//  VideoStatModel.swift
//  YoutubeDislikeChecker
//
//  Created by Elvis Cheng on 25/2/2025.
//

struct VideoStatsModel: Codable {
    let id, dateCreated: String?
    let likes, dislikes: Int?
    let rating: Double?
    let viewCount: Int?
    let deleted: Bool?
    
    func isNil() -> Bool {
        return id == nil &&
        dateCreated == nil &&
        likes == nil &&
        dislikes == nil &&
        rating == nil &&
        viewCount == nil &&
        deleted == nil
    }
}
