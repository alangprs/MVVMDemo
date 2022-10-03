//
//  DoubleExtension.swift
//  MVVMDemo
//
//  Created by 翁燮羽 on 2022/10/3.
//

import Foundation

extension Double {
    
    func toDateString(dateFormat : String? = "yyyy/MM/dd") -> String{
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        return date.toString(dateFormat: dateFormat)
    }
    
    /// 四捨五入至小數第幾位
    func rounding(toDecimal decimal: Int) -> Double {
        let numberOfDigits = pow(10.0, Double(decimal))
        return (self * numberOfDigits).rounded(.toNearestOrAwayFromZero) / numberOfDigits
    }
}
