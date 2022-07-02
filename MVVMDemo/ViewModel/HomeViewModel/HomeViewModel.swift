//
//  HomeViewModel.swift
//  MVVMDemo
//
//  Created by 翁燮羽 on 2022/7/1.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    /// 通知刷新tableView
    func reloadTableViewData()
}

class HomeViewMode {
    
    weak var delegate: HomeViewModelDelegate?
        
    private var travelData: [Info] = {
        let travelData = [Info]()
        return travelData
    }()
    
    /// 取得model層拿到的資料
    func getDate() -> [Info] {
        return travelData
    }
    
    /// 打api取得網路資料
    func getNetworkData() {
        let urlStr = "https://gis.taiwan.net.tw/XMLReleaseALL_public/scenic_spot_C_f.json"
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { data, respond, error in
                if let data = data {
                    do {
                        let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
                        self.travelData = searchResponse.xmlHead.infos.info
                        self.delegate?.reloadTableViewData()
                    } catch  {
                        print(error)
                    }
                } else {
                    print("get networkData error", error as Any)
                }
                
            }.resume()
        }
    }
}



