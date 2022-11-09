//
//  PicEntity.swift
//  jmzs
//
//  Created by ilei on 2022/11/7.
//

import Foundation
import CoreData

class PicEntity: ObservableObject {

    weak var store: Pic? {
        didSet {
            createTime = store?.createTime ?? Date()
            id = store?.id ?? UUID()
            title = store?.title ?? ""
            updateTime = store?.updateTime ?? Date()
            pics = [Thumbnail]()
            if let pics = store?.pics {
                for object in pics {
                    guard let pic = object as? Thumb else { return }
                    let p = Thumbnail()
                    p.data = pic.data
                    p.id = pic.id
                    p.path = pic.path
                    self.pics.append(p)
                }
            }
        }
    }
    @Published var title = ""
    @Published var createTime = Date()
    @Published var id = UUID()
    @Published var updateTime = Date()
    @Published var pics = [Thumbnail]()
    
}
