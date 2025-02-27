//
//  UIView+Ext.swift
//  YoutubeDislikeChecker
//
//  Created by Elvis Cheng on 24/2/2025.
//

import UIKit
import SnapKit

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
    
    func withIcon(imgName: String, imgSize: CGFloat, imgColor: UIColor, spacing: CGFloat) -> UIView {
        let view = UIView(frame: .zero)
        let img = UIImageView(image: UIImage(systemName: imgName))
        img.contentMode = .scaleAspectFit
        img.tintColor = imgColor
        view.addSubview(img)
        view.addSubview(self)
        
        img.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview()
            $0.size.equalTo(imgSize)
        }
        
        self.snp.makeConstraints {
            $0.centerY.equalTo(img.snp.centerY)
            $0.left.equalTo(img.snp.right).offset(spacing)
            $0.right.equalToSuperview()
        }
        
        return view
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
    static func filled(id: String = "", text: String? = "", fontTuple: FontTuple, textColor: UIColor, bgColor: UIColor, cornerRadius: CGFloat = 4.0, padding: UIEdgeInsets = UIEdgeInsets(top: 12, left: 24, bottom: 12, right: 24)) -> UIButton {
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


// MARK: - UIStackView
extension UIStackView {
    func setAsVstack(spacing: CGFloat, padding: UIEdgeInsets) {
        self.axis = .vertical
        self.spacing = spacing
        self.layoutMargins = padding
        self.isLayoutMarginsRelativeArrangement = true
    }
    
    func setAsHstack(spacing: CGFloat, padding: UIEdgeInsets) {
        self.axis = .horizontal
        self.spacing = spacing
        self.layoutMargins = padding
        self.isLayoutMarginsRelativeArrangement = true
    }
    
    func addSubviews(_ views: [UIView]) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}


// MARK: - UIView
extension UIView {
    static func plain(cornerRadius: CGFloat = 0, bgColor: UIColor = .clear, corner: ViewCorner? = nil) -> UIView {
        let v = UIView()
        if cornerRadius > 0 {
            v.layer.cornerRadius = cornerRadius
            v.clipsToBounds = true
            if let corner {
                v.layer.maskedCorners = corner.value
            }
        }
        v.backgroundColor = bgColor
        return v
    }
    
    func addAccessibilityID(_ id: String) {
        if !id.isEmpty {
            self.accessibilityIdentifier = id
        }
    }
}


enum ViewCorner {
    case top
    case bottom
    
    var value: CACornerMask {
        switch self {
        case .top:
            [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case .bottom:
            [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
    }
}

