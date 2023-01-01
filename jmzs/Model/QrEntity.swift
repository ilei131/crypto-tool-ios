//
//  QrEntity.swift
//  jmzs
//
//  Created by ilei on 2023/1/1.
//

import Foundation
import CoreData

class QrEntity: ObservableObject {

    weak var store: QrCode? {
        didSet {
            data = store?.data ?? ""
            scanData = store?.scanData ?? ""
            id = store?.id ?? UUID()
            type = store?.type ?? 0
            encrypted = store?.encrypted ?? false
        }
    }

    @Published var data = ""
    @Published var scanData = ""
    @Published var createTime = Date()
    @Published var id = UUID()
    @Published var type: Int32 = 0
    @Published var encrypted = false

}
