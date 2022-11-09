//
//  Date.swift
//  jmzs
//
//  Created by ilei on 2022/11/7.
//

import Foundation
extension Date {
    
    func formateString() -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return df.string(from: self)
    }
}