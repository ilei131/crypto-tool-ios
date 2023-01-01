//
//  ScannedObject.swift
//  jmzs
//
//  Created by ilei on 2022/12/31.
//
import Foundation
import SwiftUI

class ScannedObject: Identifiable, Codable{
    
    var id = UUID()
    var data: String = ""
    var scanDate: String?
    var type: ObjectType?
    
    
    private enum CodingKeys: String, CodingKey {
           case data
           case scanDate
        case type
       }
    
    
    init(data: String, scanDate: String, type: ObjectType) {
        self.data = data
        self.scanDate = scanDate
        self.type = type
    }
    
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decode(String.self, forKey: .data)
        scanDate = try values.decode(String.self, forKey: .scanDate)
        type = try values.decode(ObjectType.self, forKey: .type)
    }

}
