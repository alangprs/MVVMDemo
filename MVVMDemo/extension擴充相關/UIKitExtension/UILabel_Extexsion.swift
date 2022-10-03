//
//  LabelExtexsion.swift
//  MVVMDemo
//
//  Created by 翁燮羽 on 2022/10/3.
//

import UIKit

extension UILabel {
    
    /// 文字間距
    var letterSpace: CGFloat {
        set {
            let attributedString: NSMutableAttributedString!
            if let currentAttrString = attributedText {
                attributedString = NSMutableAttributedString(attributedString: currentAttrString)
            }
            else {
                attributedString = NSMutableAttributedString(string: text ?? "")
                text = nil
            }
            
            attributedString.addAttribute(NSAttributedString.Key.kern,
                                          value: newValue,
                                          range: NSRange(location: 0, length: attributedString.length))
            
            attributedText = attributedString
        }
        
        get {
            if let currentLetterSpace = attributedText?.attribute(NSAttributedString.Key.kern, at: 0, effectiveRange: .none) as? CGFloat {
                return currentLetterSpace
            }
            else {
                return 0
            }
        }
    }
    
    /// 取得文字寬度
    ///
    /// - Parameters:
    ///   - text: 文字
    ///   - fixedHeight: 固定高度
    ///   - font: 字型大小
    /// - Returns: 文字寬度
    static func getLabelWidth(text: String, fixedHeight: CGFloat, font: UIFont) -> CGFloat {
        let boundingRect = (text as NSString).boundingRect(with: CGSize(width: .greatestFiniteMagnitude, height: fixedHeight),
                                                           options: .usesLineFragmentOrigin,
                                                           attributes: [NSAttributedString.Key.font: font],
                                                           context: nil)
        return boundingRect.size.width
    }
    
    /// 取得文字高度
    ///
    /// - Parameters:
    ///   - text: 文字
    ///   - fixedWidth: 固定寬度
    ///   - font: 字型大小
    /// - Returns: 文字高度
    static func getLabelHeight(text: String, fixedWidth: CGFloat, font: UIFont) -> CGFloat {
        let boundingRect = (text as NSString).boundingRect(with: CGSize(width: fixedWidth, height: .greatestFiniteMagnitude),
                                                           options: .usesLineFragmentOrigin,
                                                           attributes: [NSAttributedString.Key.font: font],
                                                           context: nil)
        return boundingRect.size.height
    }
}
