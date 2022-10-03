//
//  DecimalExtension.swift
//  MVVMDemo
//
//  Created by 翁燮羽 on 2022/10/3.
//

import Foundation

extension Decimal {
    
    var doubleValue : Double{
        return NSDecimalNumber(decimal: self).doubleValue
    }
    
    var floatValue : Float{
        return NSDecimalNumber(decimal: self).floatValue
    }
    
    /// 取得四捨五入後的金額
    func byRatio(_ ratio: Int) -> Decimal{
        return Decimal(round(self.doubleValue * Double(ratio) / 100))
    }
    
    var viewCountString: String {
        if self > 10000 {
            let viewCount = (self.doubleValue / 10000.0).rounding(toDecimal: 1)
            return "\(viewCount)萬"
        }
        return "\(self)"
    }
}
