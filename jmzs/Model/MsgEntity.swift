//
//  MsgEntity.swift
//  jmzs
//
//  Created by ilei on 2022/11/7.
//

import Foundation
import CoreData

class MsgEntity: ObservableObject {

    weak var store: Msg? {
        didSet {
            title = store?.title ?? ""
            content = store?.content ?? ""
            createTime = store?.createTime ?? Date()
            id = store?.id ?? UUID()
            key = store?.key ?? ""
            mode = store?.mode ?? ""
            owner = store?.owner ?? true
            
            if time.isEmpty {
                if let ctime = store?.createTime?.formateString() {
                    time = ctime
                }
            }
        }
    }

    @Published var title = ""
    @Published var content = ""
    @Published var createTime = Date()
    @Published var id = UUID()
    @Published var key = ""
    @Published var mode = "default"
    @Published var type: Int = 0
    @Published var time = ""
    @Published var owner = true
}
