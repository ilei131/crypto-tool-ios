//
//  PwdEntity.swift
//  jmzs
//
//  Created by ilei on 2022/11/7.
//

import Foundation
import CoreData

class PwdEntity: ObservableObject {

    weak var store: Pwd? {
        didSet {
            account = store?.account ?? ""
            createTime = store?.createTime ?? Date()
            id = store?.id ?? UUID()
            if let password = store?.pwd, !password.isEmpty {
                pwd = password.aesDecrypt(keyString: DataManager.shared.password()) ?? ""
            } else {
                pwd = ""
            }
//            NSLog("store.pwd:\(store?.pwd ?? "")")
            remarks = store?.remarks ?? ""
            title = store?.title ?? ""
            type = store?.type ?? 0
            updateTime = store?.updateTime ?? Date()
            website = store?.website ?? ""
        }
    }

    @Published var account = ""
    @Published var createTime = Date()
    @Published var id = UUID()
    @Published var pwd = ""
    @Published var remarks = ""
    @Published var title = ""
    @Published var type: Int32 = 0
    @Published var updateTime = Date()
    @Published var website = ""

}
