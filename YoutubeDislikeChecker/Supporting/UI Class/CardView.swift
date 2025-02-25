//
//  CardView.swift
//  YoutubeDislikeChecker
//
//  Created by Elvis Cheng on 24/2/2025.
//

import UIKit
import SnapKit

class CardView: UIView {
    private let headerLabel = UILabel.plain(fontTuple: (18, .semibold), color: .white)
    private let headerView = UIView.plain(cornerRadius: 8, bgColor: .systemRed, corner: .top)
    private let containerView = UIView.plain(cornerRadius: 8, corner: .bottom)
    private let bodyView: UIView
    private let title: String
    
    init(title: String, bodyView: UIView) {
        self.bodyView = bodyView
        self.title = title
        super.init(frame: .zero)
        setUI()
        setLayout()
    }
    
    private func setUI() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 8
        clipsToBounds = true
        headerLabel.text = title
    }
    
    private func setLayout() {
        addSubview(headerView)
        headerView.addSubview(headerLabel)
        
        addSubview(containerView)
        containerView.addSubview(bodyView)
        
        headerView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
        
        headerLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
        
        bodyView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
