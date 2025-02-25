//
//  CheckerView.swift
//  YoutubeDislikeChecker
//
//  Created by Elvis Cheng on 24/2/2025.
//

import UIKit
import SnapKit

final class CheckerView: UIView {
    private let textField = BorderTextField(id: UI.textField.id, hint: "Enter URL", fontTuple: (18, .regular))
    private let checkButton = UIButton.filled(id: UI.checkButton.id, text: "CHECK", fontTuple: (18, .semibold), textColor: .white, bgColor: .systemRed)
    private let resultView = ResultView()
    
    init() {
        super.init(frame: .zero)
        setUI()
        setLayout()
    }
    
    private func setUI() {
        backgroundColor = .systemBackground
    }
    
    private func setLayout() {
        addSubview(textField)
        addSubview(checkButton)
        addSubview(resultView)
        
        textField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).inset(36)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        checkButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(textField.snp.bottom).offset(24)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        resultView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(checkButton.snp.bottom).offset(24)
            $0.left.right.equalToSuperview().inset(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Accessibility Identifier
extension CheckerView {
    private enum UI: String {
        case textField   = "CheckerView_TextField"
        case checkButton = "CheckerView_CheckButton"
        
        var id: String {
            return rawValue
        }
    }
}
