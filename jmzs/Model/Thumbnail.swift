//
//  Thumbnail.swift
//  jmzs
//
//  Created by ilei on 2022/11/7.
//

import Foundation

class Thumbnail: ObservableObject, Identifiable {
    @Published var data: Data?
    @Published var id: UUID?
    @Published var path: String?
}

extension Thumbnail: Hashable {
    static func == (lhs: Thumbnail, rhs: Thumbnail) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    public var hashValue: Int {
        return id?.hashValue ?? 0
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(hashValue)
    }
}
