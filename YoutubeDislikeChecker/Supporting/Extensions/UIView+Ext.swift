//
//  UIView+Ext.swift
//  YoutubeDislikeChecker
//
//  Created by Elvis Cheng on 24/2/2025.
//

import UIKit

typealias FontTuple = (CGFloat, UIFont.Weight)

// MARK: - UILabel
extension UILabel {
    static func plain(id: String = "", lines: Int = 0, alignment: NSTextAlignment = .left, fontTuple: FontTuple, color: UIColor, text: String? = "") -> UILabel {
        let lbl = UILabel()
        lbl.addAccessibilityID(id)
        lbl.numberOfLines = lines
        lbl.textAlignment = alignment
        lbl.font = .systemFont(ofSize: fontTuple.0, weight: fontTuple.1)
        lbl.textColor = color
        lbl.text = text
        return lbl
    }
}


// MARK: - UITextField
extension UITextField {
    static func border(id: String = "", hint: String? = "", fontTuple: FontTuple, borderColor: UIColor = .systemGray) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.addAccessibilityID(id)
        textField.borderStyle = .roundedRect
        textField.keyboardType = .asciiCapable
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = .done
        textField.placeholder = hint
        textField.font = .systemFont(ofSize: fontTuple.0, weight: fontTuple.1)
        
        textField.layer.masksToBounds = true
        textField.layer.borderColor = borderColor.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 4.0
        
        return textField
    }
}


// MARK: - UIButton
extension UIButton {
    static func filled(id: String = "", text: String? = "", fontTuple: FontTuple, textColor: UIColor, bgColor: UIColor, cornerRadius: CGFloat = 4.0, padding: UIEdgeInsets = UIEdgeInsets(top: 8, left: 24, bottom: 8, right: 24)) -> UIButton {
        let btn = UIButton(frame: .zero)
        btn.addAccessibilityID(id)
        btn.setTitleColor(textColor, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: fontTuple.0, weight: fontTuple.1)
        btn.setTitle(text, for: .normal)
        btn.backgroundColor = bgColor
        btn.layer.cornerRadius = cornerRadius
        btn.contentEdgeInsets = padding
        return btn
    }
}


// MARK: - UIView
extension UIView {
    static func plain(cornerRadius: CGFloat = 0, isClipsToBounds: Bool = false, bgColor: UIColor = .clear) -> UIView {
        let v = UIView()
        if cornerRadius > 0 {
            v.layer.cornerRadius = cornerRadius
        }
        v.clipsToBounds = isClipsToBounds
        v.backgroundColor = bgColor
        return v
    }
    
    func addAccessibilityID(_ id: String) {
        if !id.isEmpty {
            self.accessibilityIdentifier = id
        }
    }
}

