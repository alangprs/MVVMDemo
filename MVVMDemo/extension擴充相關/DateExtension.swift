//
//  DateExtension.swift
//  MVVMDemo
//
//  Created by 翁燮羽 on 2022/10/3.
//

import Foundation

// MARK: - Date Constant

/// 分鐘
let MINUTE_TIME_INTERVAL: TimeInterval = 60
/// 小時
let HOUR_TIME_INTERVAL: TimeInterval = 60 * MINUTE_TIME_INTERVAL
/// 天
let DAY_TIME_INTERVAL: TimeInterval = 24 * HOUR_TIME_INTERVAL
/// 星期
let WEEK_TIME_INTERVAL: TimeInterval = 7 * DAY_TIME_INTERVAL

/// 中文星期
let WEEKDAY: [String] = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"]

/// 中文月份
let MonthNames : [String] = ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月",]

extension Date {
    
    /// 將日期轉為中文
    /// - Parameters:
    ///   - dateFormat: dateFormat
    ///   - locale: locale description
    /// - Returns: 年/月/日
    func toString(dateFormat : String? = "yyyy/MM/dd HH:mm:ss", locale: Locale = .autoupdatingCurrent) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        // 設為繁中
        formatter.locale = Locale(identifier: "zh_Hant_TW")
        return formatter.string(from: self)
    }
}
