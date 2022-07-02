//
//  NetworkStruct.swift
//  MVVMDemo
//
//  Created by 翁燮羽 on 2022/7/1.
//

import Foundation

struct SearchResponse: Codable {
    let xmlHead: XML_Head
    
    enum CodingKeys: String, CodingKey {
        case xmlHead = "XML_Head"
    }
}
struct XML_Head: Codable {
    let infos: Infos
    
    enum CodingKeys: String, CodingKey {
        case infos = "Infos"
    }
}
struct Infos: Codable {
    let info: [Info]
    
    enum CodingKeys: String, CodingKey {
        case info = "Info"
    }
}
struct Info: Codable {
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
    }
}
