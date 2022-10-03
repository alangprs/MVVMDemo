//
//  StringExtension.swift
//  MVVMDemo
//
//  Created by 翁燮羽 on 2022/10/3.
//

import Foundation
import UIKit

// MARK: -  other

extension String {
    
    /// 添加分隔符號
    /// - Parameters:
    ///   - every: 每隔幾個字
    ///   - separator: 分隔符號
    func separate(every: Int = 1, with separator: String) -> String {
        return String(stride(from: 0, to: Array(self).count, by: every).map {
            Array(Array(self)[$0..<min($0 + every, Array(self).count)])
        }.joined(separator: separator))
    }
    
    /// 回傳指定位置的字串
    func getByIndex(_ index: Int) -> String {
        if index >= self.count || index < 0{
            return ""
        }
        let index = String.Index(utf16Offset: index, in: self)
        return String(self[index])
    }
    
    /// 是否為符合Email格式的文字
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    /// 有下底線的文字
    ///  - Parameters:
    ///    - color: 文字顏色
    ///    - font: 字型
    ///    - wordSpacing: 文字間距
    ///    - paragraphStyle: 其他設定
    func getUnderLineAttributedString(color: UIColor, font: UIFont, wordSpacing: CGFloat = 1, paragraphStyle: NSMutableParagraphStyle? = nil) -> NSMutableAttributedString{
        let attributedString = NSMutableAttributedString(string: self, attributes:[
            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.kern: wordSpacing,
        ])
        
        let rangeService = self.range(of: self)!
        let nsRangeService = NSRange(rangeService, in:self)
        attributedString.addAttributes([
            NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.underlineColor : color],
                                       range: nsRangeService)
        
        if let paragraphStyle = paragraphStyle{
            attributedString.addAttributes([.paragraphStyle: paragraphStyle], range: nsRangeService)
        }
        return attributedString
    }
}

// MARK: - string轉換成其他型別

extension String {
    
    func toDate(dateFormat : String? = "yyyyMMddHHmmss") -> Date{
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = .autoupdatingCurrent
        //        formatter.locale = Locale(identifier: "zh_CN")
        return formatter.date(from: self) ?? Date()
    }
    
    func toTimeStamp(dateFormat : String? = "yyyyMMddHHmmss") -> TimeInterval{
        let date = self.toDate(dateFormat: dateFormat)
        return date.timeIntervalSince1970
    }
    
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
    
    func toDecimal() -> Decimal? {
        return NumberFormatter().number(from: self)?.decimalValue
    }
}

// MARK: - 截斷文字，插入指定文字
extension String {
    
    /// 當label行數為最後一行時，加入要顯示文字
    /// - Parameters:
    ///   - width: label寬度
    ///   - lines: label可顯示行數
    ///   - font: 文字樣式
    ///   - suffix: 結尾要顯示文字
    /// - Returns: 組合完畢文字
    func textThatFits(width: CGFloat, lines: Int, font: UIFont, suffix: String = "") -> String {
        if self.isEmpty {
            return self
        }
        let lineHeight = font.lineHeight
        let completeString = self + suffix
        let height = completeString.heightWithConstrainedWidth(width: width, font: font)
        
        if height > lineHeight * CGFloat(lines) * 2 {
            let partialString = self.substring(from: 0, length: count / 2)
            return partialString.textThatFits(width: width, lines: lines, font: font, suffix: suffix)
            
        } else if height > lineHeight * CGFloat(lines) {
            var partialString = self
            partialString.removeLast()
            return partialString.textThatFits(width: width, lines: lines, font: font, suffix: suffix)
            
        } else {
            return completeString
        }
    }
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height
    }
    
    func substring(from: Int?, to: Int?) -> String {
        if let start = from,
            start >= self.count {
            return ""
        }
        
        if let end = to,
            end < 0 {
            return ""
        }
        
        if let start = from, let end = to,
            end - start < 0 {
            return ""
        }
        
        let startIndex: String.Index
        if let start = from, start >= 0 {
            startIndex = self.index(self.startIndex, offsetBy: start)
        } else {
            startIndex = self.startIndex
        }
        
        let endIndex: String.Index
        if let end = to, end >= 0, end < self.count {
            endIndex = self.index(self.startIndex, offsetBy: end + 1)
        } else {
            endIndex = self.endIndex
        }
        
        return String(self[startIndex ..< endIndex])
    }
    
    func substring(from: Int?, length: Int) -> String {
        guard length > 0 else {
            return ""
        }
        
        let end: Int
        if let start = from, start > 0 {
            end = start + length - 1
        } else {
            end = length - 1
        }
        
        return self.substring(from: from, to: end)
    }
}
