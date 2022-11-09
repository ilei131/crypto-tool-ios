//
//  PwdCell.swift
//  jmzs
//
//  Created by ilei on 2022/11/8.
//

import SwiftUI
import CoreData

struct PwdCell: View {
    @ObservedObject var item: Pwd
    
    var body: some View {
            HStack(spacing: 8) {
                TextImageView(type: 1)
                VStack(alignment: .leading, spacing: 6) {
                    HStack(alignment: .center) {
                        Text(item.title ?? "")
                            .font(.system(size: 20))
                            .lineLimit(1)
                    }
                    
                    if let account = item.account, !account.isEmpty {
                        Text(item.account ?? "")
                            .font(.system(size: 16))
                            .foregroundColor(Color(hexadecimal: "9fa2a9"))
                    }
                }
                Spacer()
            }
    }
}

struct PwdCell_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
    }
}
