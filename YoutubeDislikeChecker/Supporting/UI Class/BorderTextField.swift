//
//  BorderTextField.swift
//  YoutubeDislikeChecker
//
//  Created by Elvis Cheng on 24/2/2025.
//

import UIKit

class BorderTextField: UITextField {
    let textPadding = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    
    init(id: String = "", hint: String = "", fontTuple: FontTuple, borderColor: UIColor = .systemGray) {
        super.init(frame: .zero)
        addAccessibilityID(id)
        font = .systemFont(ofSize: fontTuple.0, weight: fontTuple.1)
        borderStyle = .roundedRect
        keyboardType = .asciiCapable
        clearButtonMode = .whileEditing
        returnKeyType = .done
        placeholder = hint
        
        layer.masksToBounds = true
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 4.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Override
extension BorderTextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}
