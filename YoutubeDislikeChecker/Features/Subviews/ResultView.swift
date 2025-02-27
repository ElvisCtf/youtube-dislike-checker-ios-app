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
        stack.setAsVstack(spacing: 16, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        stack.addSubviews([
            viewLabel.withIcon(imgName: "eye", imgSize: 24, imgColor: .label, spacing: 8),
            likeLabel.withIcon(imgName: "hand.thumbsup", imgSize: 24, imgColor: .label, spacing: 8),
            dislikeLabel.withIcon(imgName: "hand.thumbsdown", imgSize: 24, imgColor: .label, spacing: 8)
        ])
        
        super.init(title: "Result", bodyView: stack)
    }
    
    func setText(like: String, dislike: String, viewCount: String) {
        viewLabel.text = "\(viewCount) views"
        likeLabel.text = "\(like) likes"
        dislikeLabel.text = "\(dislike) dislikes"
        showBody()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
