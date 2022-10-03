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

// MARK: - 參數

extension Date {
    
    /// 遇到日期計算一律使用 ISO8601 格式,不要用 Calendar.current
    /// 日曆
    private var calender: Calendar {
        return Calendar.current
    }
    
    /// 昨天日期
    static var yesterday: Date { return Date().dayBefore }
    /// 明天日期
    static var tomorrow:  Date { return Date().dayAfter }
    
    /// 前一天午夜12:00
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: midnight)!
    }
    /// 後一天午夜12:00
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: midnight)!
    }
    
    var wholeDayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    
    var midnight: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    /// 日末(晚上11:59:59)
    var dayEnd: Date{
        var date = self.dayAfter
        date.addTimeInterval(-1)
        return date
    }
    
    var day: Int {
        return Calendar.current.component(.day,  from: self)
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var year: Int {
        return Calendar.current.component(.year,  from: self)
    }
    
    /// 是否是本月最後一天
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
   
}

extension Date {
    
    /// 比較兩個時間是否為同一天
    func isSameDay(compare date1: Date, to date2: Date) -> Bool {
        return calender.isDate(date1, inSameDayAs: date2)
    }
    
    /// 比較兩個時間是否為同一週
    func isSameWeek(compare date1: Date, to date2: Date) -> Bool {
        return calender.isDate(date1, equalTo: date2, toGranularity: .weekOfMonth)
    }
    
    /// 年起始時間
    func startOfYear() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year], from: Calendar.current.startOfDay(for: self)))!
    }
    
    /// 年結束時間
    func endOfYear() -> Date {
        return Calendar.current.date(byAdding: DateComponents(year: 1, day: -1), to: self.startOfYear())!.dayEnd
    }
    
    /// 前/後一個年初
    func nextStartOfYear(advanceBy:Int) -> Date {
        return Calendar.current.date(byAdding: DateComponents(year: 1*advanceBy), to: self.startOfYear())!
    }
    
    /// 前/後一個年終
    func nextEndOfYear(advanceBy:Int) -> Date {
        return nextStartOfYear(advanceBy: advanceBy).endOfYear()
    }
    
    /// 前/後一年
    func nextYear(advanceBy:Int) -> Date {
        return Calendar.current.date(byAdding: DateComponents(year: 1*advanceBy), to: self)!
    }
    
    /// 月起始時間
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    /// 月結束時間
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!.dayEnd
    }
    
    /// 下個月起始日
    func nextStartOfMonth(advanceBy:Int) -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1*advanceBy), to: self.startOfMonth())!.startOfMonth()
    }
    
    /// 下個月結束日
    func nextEndOfMonth(advanceBy:Int) -> Date {
        return nextStartOfMonth(advanceBy: advanceBy).endOfMonth()
    }
    
    /// 開始的星期
    func startOfWeek(using calendar: Calendar = Calendar.current) -> Date {
        calendar.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: self).date!
    }
    
    /// 結束的星期
    func endOfWeek(using calendar: Calendar = Calendar.current) -> Date {
        Calendar.current.date(byAdding: .day, value: 7, to: self.startOfWeek())!.dayEnd
    }
    
    /// 取得日期間隔數
    /// ex: 8/5 - 8/10 = 5天
    func daysBetweenDate(toDate: Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: self, to: toDate)
        return components.day ?? 0
    }
    
    /// 取得指定日期當月的天數
    func countOfMonthDays() -> Int {
        let calendar = Calendar.current
        let range = (calendar as NSCalendar?)?.range(of: .day, in: .month, for: self)
        return range?.length ?? 0
    }
    
    /// 根據年月得到某月天數
    static func getCountOfDaysInMonth(year:Int,month:Int) ->Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        let date
            = dateFormatter.date(from: String(year)+"-"+String(month))
        let calendar = Calendar(identifier:Calendar.Identifier.gregorian)
        let range = (calendar as NSCalendar?)?.range(of: .day, in: .month, for: date!)
        return (range?.length)!
    }
    
    /// 取得指定年,月,日的日期
    func setDate(year: Int? = nil, month: Int? = nil, day: Int? = nil) -> Date{
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: self)
        if let year = year{
            dateComponents.year = year
        }
        if let month = month{
            dateComponents.month = month
        }
        if let day = day{
            dateComponents.day = day
        }
        return Calendar.current.date(from: dateComponents) ?? self
    }
    
    /// 輸入日期，取得星期幾(一~日)
    func getWeekday(date: Date) -> String? {
        let weekday = calender.component(.weekday, from: date)
        if weekday < 1 || weekday > 7 {
            return nil
        }
        let index = weekday - 1
        guard WEEKDAY.indices.contains(index) else {
            return nil
        }
        
        return WEEKDAY[index]
    }
    
    /// 取得客製化時間字串 - 天
    /// 今天 >> "今天"
    /// 4天內 >> "n天前" (最多顯示"3天前")
    /// 第四天後文章顯示："MM月DD日"
    func getDisplayDateStringByDay() -> String {
        let nowDate = Date()
        if isSameDay(compare: self, to: nowDate) {
            return "今天"
        }
        let days = self.daysBetweenDate(toDate: nowDate)
        if days < 4 {
            return "\(days)" + "天前"
        }
        return self.toString(dateFormat: "MM月dd日")
    }
    
    /// 取得客製化時間字串 - 小時
    /// 當天 1 小時內顯示 "剛剛"
    /// 當天 x 小時內顯示 "x 小時前"
    /// 當週(一~日) 顯示 "星期x"
    /// 其餘顯示年/月/日，如： "2021/1/1"
    func getDisplayDateStringByHour() -> String {
        let nowDate = Date()
        let nowTime = nowDate.timeIntervalSince1970
        let diffSec = nowTime - self.timeIntervalSince1970
        if diffSec < HOUR_TIME_INTERVAL {
            return "剛剛"
        }
        if diffSec < DAY_TIME_INTERVAL {
            let hour = lround(diffSec / (HOUR_TIME_INTERVAL))
            return "\(hour)" + "小時前"
        }
        if isSameWeek(compare: self, to: nowDate),
           let weekday = getWeekday(date: self) {
            return weekday
        }
        return self.toString(dateFormat: "yyyy/M/d")
    }
    
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
