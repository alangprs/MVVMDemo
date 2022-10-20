//
//  HomeViewModel.swift
//  MVVMDemo
//
//  Created by 翁燮羽 on 2022/7/1.
//

import Combine
import Foundation
//import Alamofire

class HomeViewMode {
    
    private lazy var travelData: [Info] = {
        var travelData = [Info]()
        return travelData
    }()
    
    private lazy var alamofireAdapter: AlamofireAdapter = {
       return AlamofireAdapter()
    }()
    
    // MARK: - 外部呼叫參數
    
    /// 取得data數量
    lazy var travelDateCount: Int = {
        return Int()
    }()
    
    
    // MARK: - 外部呼叫
    
    /// 取得model層拿到的資料
    func getData(indexPath: IndexPath) -> Info? {
        return travelData[indexPath.item]
    }
    
    /// alamofire 打 api 方式
    func getTravelData(completion: @escaping (() -> Void)) {
        let urlStr = "https://gis.taiwan.net.tw/XMLReleaseALL_public/scenic_spot_C_f.json"

        alamofireAdapter.getNetwork(url: urlStr) { data, respond, error in

            if let data = data {
                do {
                    let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
                    self.travelData = searchResponse.xmlHead.infos.info
                    self.travelDateCount = self.travelData.count
                    completion()

                } catch {
                    print("json decoder error\(error.localizedDescription)")
                }
            } else {
                print("get data error\(error?.localizedDescription)")
            }
        }
    }
    
    /// 原生打api方式
    func getNetworkData(completion: @escaping ((Result<[Info],Error>) -> Void)) {
        let urlStr = "https://gis.taiwan.net.tw/XMLReleaseALL_public/scenic_spot_C_f.json"
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { data, respond, error in
                if let data = data {
                    do {
                        let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
                        
                        self.travelData = searchResponse.xmlHead.infos.info
                        self.travelDateCount = self.travelData.count
                        
                        completion(.success(self.travelData))
                    } catch  {
                        completion(.failure(error))
                    }
                } else {
                    print("get networkData data error", error as Any)
                }
                
            }.resume()
        }
    }
}



