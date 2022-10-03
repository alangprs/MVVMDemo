//
//  AlamofireAdapter.swift
//  MVVMDemo
//
//  Created by 翁燮羽 on 2022/10/2.
//

import Foundation
import Alamofire

class AlamofireAdapter {
    
    private lazy var session: SessionManager = {
            return SessionManager()
        }()
    
    /// get
    /// - Parameters:
    ///   - url: api網址
    ///   - parameters: 參數
    ///   - httpHeader: httpHeader
    ///   - completion: 傳遞完成後動作
    func getNetwork(url: String, parameters: Parameters? = nil, httpHeader: HTTPHeaders? = nil , completion: @escaping ((Data?, HTTPURLResponse?, Error?) -> Void)) {
        
        session.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: httpHeader)
            .validate(statusCode: 200 ..< 300)
            .response { afResponse in
                
                completion(afResponse.data, afResponse.response, afResponse.error)
            }
    }
}

