//
//  BuilderDemo.swift
//  MVVMDemo
//
//  Created by cm0768 on 2022/10/17.
//

import Foundation

/// 創建一個旅行社給兩個行程套裝
/// 分入境團、出境團
/// 套裝內容: 主行程、餐廳

// MARK: - 旅遊套裝種類

/// 旅遊套裝種類
enum TravelPacking: String {
    case inbound = "入境"
    case outbound = "出境"
}

// MARK: - 旅遊項目

/// 旅遊資訊
protocol AttractionsInfo {
    /// 景點名稱
    var name: String {get}
    /// 景點總類
    var packing: TravelPacking {get}
    /// 景點價格
    var price: Int {get}
}

/// 景點內容
class Attraction: AttractionsInfo {
    var name: String = ""
    
    var packing: TravelPacking = .inbound
    
    var price: Int = 0
}

/// 故宮博物院
class NationalPalaceMuseum: Attraction {
    
    override var name: String {
        get {
            return "故宮博物院"
        }
        set {
            self.name = newValue
        }
    }
    
    override var price: Int {
        get {
            return 380
        }
        set {
            self.price = newValue
        }
    }
    
}

/// 環球影城
class UniversalStudiosSingapore: Attraction {
    
    override var name: String {
        get {
            return "環球影城"
        }
        set {
            self.name = newValue
        }
    }
    
    override var price: Int {
        get {
            return 7054
        }
        set {
            self.price = newValue
        }
    }
}

/// 飲食內容
class FoodInfo: AttractionsInfo {
    var name: String = ""
    
    var packing: TravelPacking = .outbound
    
    var price: Int = 0
    
}

/// 故宮晶華
class SilksPalace: FoodInfo {
    
    override var name: String {
        get {
            return "港點自助餐"
        }
        set {
            self.name = newValue
        }
    }
    
    override var packing: TravelPacking {
        get {
            return .inbound
        }
        set {
            self.packing = newValue
        }
    }
    
    override var price: Int {
        get {
            return 499
        }
        set {
            self.price = newValue
        }
    }
}

/// 餐卷
class MealRolls: FoodInfo {
    
    override var name: String {
        get {
            return "影城餐卷"
        }
        set {
            self.name = newValue
        }
    }
    
    override var packing: TravelPacking {
        get {
            return .outbound
        }
        set {
            self.packing = newValue
        }
    }
    
    override var price: Int {
        get {
            return 500
        }
        set {
            self.price = newValue
        }
    }
}

/// 行程套裝總管
class TravelPackingManager {
    /// 套裝內容
    var travelPackings: [AttractionsInfo] = []
    
    /// 加入套裝
    /// - Parameter attraction: 欲加入的景點
    func addTravelPacking(attraction: AttractionsInfo) {
        travelPackings.append(attraction)
    }
    
    /// 計算套裝總和
    func getTravelPackingsCost() -> Int {
        return travelPackings.reduce(0) { (total, item) -> Int in
            return total + item.price
        }
    }
    
    /// 顯示所有套裝內容
    func showAllTravelPackings() {
        travelPackings.forEach { travelPacking in
            print("套裝內容 - 品項: \(travelPacking.name), 國內/外: \(travelPacking.packing), 價格: \(travelPacking.price)")
        }
    }
}

// MARK: - 產生器

class TravelBuilder {
    
    /// 創建國內套裝
    func makeInbound() -> TravelPackingManager {
        let packing = TravelPackingManager()
        packing.addTravelPacking(attraction: NationalPalaceMuseum())
        packing.addTravelPacking(attraction: SilksPalace())
        return packing
    }
    
    /// 創建國外套裝
    func makeOutbound() -> TravelPackingManager {
        let packing = TravelPackingManager()
        packing.addTravelPacking(attraction: UniversalStudiosSingapore())
        packing.addTravelPacking(attraction: MealRolls())
        return packing
    }
}
