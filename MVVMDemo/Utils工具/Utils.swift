//
//  Utils.swift
//  MVVMDemo
//
//  Created by 翁燮羽 on 2022/10/3.
//

import Foundation
import UIKit

class Utils: NSObject {

    /// 取得App資料夾位置
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
   // MARK: - 文字相關
    
    /// 設定lable要斷行位置，加入斷行文字、顏色
    /// - Parameters:
    ///   - text: 主要顯示文字
    ///   - moreText: 要插入的文字
    ///   - width: label寬度
    ///   - lines: 要斷行位置
    ///   - color: 插入的文字顏色
    /// - Returns: 組裝完畢文字
    static func setTextThatFitsAndColor(text: String, moreText: String, width: CGFloat, lines: Int, color: UIColor) -> NSMutableAttributedString {
        
        let moreText = moreText
        let contrnText = text
        
        // 設定斷行
        let textThatFits = contrnText.textThatFits(width: width, lines: lines, font: .systemFont(ofSize: 14), suffix: moreText)
        
        // 轉換string型別
        let attrStri = NSMutableAttributedString(string: textThatFits)
        
        // 將文字轉成nssting，提供要換色文字
        let nsString = NSString(string: textThatFits).range(of: moreText)
        
        // 加入要換色文字
        attrStri.addAttributes([NSAttributedString.Key.foregroundColor : color as Any], range: nsString)
        
        return attrStri
    }
}
