//
//  ErrorView.swift
//  YoutubeDislikeChecker
//
//  Created by Elvis Cheng on 27/2/2025.
//

import UIKit
import SnapKit

final class ErrorView: UIView {
    private let messageLabel = UILabel.plain(fontTuple: (18, .regular), color: .label)
    private lazy var iconLabel = messageLabel.withIcon(imgName: "exclamationmark.square.fill", imgSize: 24, imgColor: .label, spacing: 8)
    
    init() {
        super.init(frame: .zero)
        setUI()
        setLayout()
    }
    
    private func setUI() {
        isHidden = true
        backgroundColor = .systemYellow
        clipsToBounds = true
        layer.cornerRadius = 8
    }
    
    private func setLayout() {
        addSubview(iconLabel)
        iconLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
    
    func setText(message: String?) {
        messageLabel.text = message
        if message != nil {
            if isHidden {
                toggleVisibility()
            }
        } else {
            if !isHidden {
                toggleVisibility()
            }
        }
    }
    
    private func toggleVisibility() {
        UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.isHidden.toggle()
        })
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
