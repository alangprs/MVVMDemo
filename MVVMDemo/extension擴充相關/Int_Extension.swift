//
//  IntExtension.swift
//  MVVMDemo
//
//  Created by 翁燮羽 on 2022/10/3.
//

import UIKit

extension Int {
    
    func toDateString(dateFormat : String? = "yyyy/MM/dd") -> String{
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        return date.toString(dateFormat: dateFormat)
    }
    
    func toString() -> String{
        return "\(self)"
    }
    
    func toTimeInterval() -> TimeInterval{
        return TimeInterval(self)
    }
    
    func toDate() -> Date{
        return Date(timeIntervalSince1970: self.toTimeInterval())
    }
    
    var viewCountString: String {
        return Decimal(self).viewCountString
    }
}
