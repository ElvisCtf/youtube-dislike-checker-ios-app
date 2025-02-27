//
//  ResultView.swift
//  YoutubeDislikeChecker
//
//  Created by Elvis Cheng on 25/2/2025.
//

import UIKit
import SnapKit

final class ResultView: CardView {
    private let viewLabel = UILabel.plain(fontTuple: (18, .regular), color: .label)
    private let likeLabel = UILabel.plain(fontTuple: (18, .regular), color: .label)
    private let dislikeLabel = UILabel.plain(fontTuple: (18, .regular), color: .label)
    private let stack = UIStackView()
    
    init() {
        super.init(title: "Result", bodyView: stack)
        setUI()
    }
    
    private func setUI() {
        isHidden = true
        
        stack.setAsVstack(spacing: 24, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        stack.addSubviews([
            viewLabel.withIcon(imgName: "eye", imgSize: 24, imgColor: .label, spacing: 8),
            likeLabel.withIcon(imgName: "hand.thumbsup", imgSize: 24, imgColor: .label, spacing: 8),
            dislikeLabel.withIcon(imgName: "hand.thumbsdown", imgSize: 24, imgColor: .label, spacing: 8)
        ])
    }
    
    func setText(_ stats: VideoStatsModel?) {
        if let stats, let likes = stats.likes, let dislikes = stats.dislikes, let viewCount = stats.viewCount {
            viewLabel.text = "\(viewCount.withCommas()) views"
            likeLabel.text = "\(likes.withCommas()) likes"
            dislikeLabel.text = "\(dislikes.withCommas()) dislikes"
            if isHidden {
                toggleVisibility()
            }
        } else {
            if !isHidden {
                toggleVisibility()
            }
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
