//
//  Int+Ext.swift
//  YoutubeDislikeChecker
//
//  Created by Elvis Cheng on 25/2/2025.
//

import Foundation

extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let formattedNumber = numberFormatter.string(from: NSNumber(value: self)) else {
            return String(self)
        }
        return formattedNumber
    }
}
