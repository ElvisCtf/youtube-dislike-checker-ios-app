//
//  APIError.swift
//  YoutubeDislikeChecker
//
//  Created by Elvis Cheng on 27/2/2025.
//

import Foundation

enum APIError: Error {
    case decodeFailed
    case invalidVideoID
    case noData
}

extension APIError: CustomStringConvertible {
    var description: String {
        switch self {
        case .decodeFailed:
            "Failed to decode data"
        case .invalidVideoID:
            "Invalid video ID"
        case .noData:
            "No data"
        }
    }
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodeFailed:
            String(localized: "Failed to decode data")
        case .invalidVideoID:
            String(localized: "Invalid video ID")
        case .noData:
            String(localized: "No data")
        }
    }
}
