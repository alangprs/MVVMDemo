//
//  HomeViewModel.swift
//  MVVMDemo
//
//  Created by 翁燮羽 on 2022/7/1.
//

import Foundation
import Combine

class HomeViewMode {
    
    private lazy var travelData: [Info] = {
        let travelData = [Info]()
        return travelData
    }()
    
    /// 資料發布者
    private var traveDataSubject = PassthroughSubject<[Info], Never>()
    private var anyCancellable = Set<AnyCancellable>()
    
    /// 取得model層拿到的資料
    func getData() -> [Info] {
        
        traveDataSubject.sink(receiveCompletion: { result in
            
            switch result {
                
            case .finished:
                print("finished")
            case .failure(let error):
                print(error)
            }
            
        }, receiveValue: { value in
            self.travelData = value
        }).store(in: &anyCancellable)
        
        return travelData
        
    }
    
    /// 打api取得網路資料
    func getNetworkData(completion: @escaping (() -> Void)) {
        let urlStr = "https://gis.taiwan.net.tw/XMLReleaseALL_public/scenic_spot_C_f.json"
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { data, respond, error in
                if let data = data {
                    do {
                        let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
                        
                        self.travelData = searchResponse.xmlHead.infos.info
                        self.traveDataSubject
                            .send(self.travelData)
                        completion()
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



