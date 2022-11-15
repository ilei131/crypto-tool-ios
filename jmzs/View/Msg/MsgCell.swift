//
//  MsgCell.swift
//  jmzs
//
//  Created by ilei on 2022/11/8.
//

import SwiftUI
import CoreData

struct MsgCell: View {
    @ObservedObject var item: Msg
    
    var body: some View {
        let title = (item.title ?? "")//.secretString()
        var subTitle = ""
        if let time = item.time, !time.isEmpty {
            subTitle = time
        } else if let ctime = item.createTime?.formateString() {
            subTitle = ctime
        }
        return HStack(spacing: 8) {
                ZStack(alignment: .center) {
                    if item.owner {
                        Image(systemName: "ellipsis.bubble")
                            .font(.system(size: 20, weight: .regular))
                            .padding(12)
                            .foregroundColor(Color(hexadecimal: "5366df"))
                    } else {
                        Image(systemName: "lock.open")
                            .font(.system(size: 20, weight: .regular))
                            .padding(12)
                            .foregroundColor(Color(hexadecimal: "5366df"))
                    }
                }
                .background(Color(hexadecimal: "F1F1F1"))
                .cornerRadius(6)
                VStack(alignment: .leading, spacing: 6) {
                    HStack(alignment: .center) {
                        Text(title)
                            .font(.system(size: 20))
                            .lineLimit(1)
                    }

                    Text(subTitle)
                        .font(.system(size: 16))
                        .foregroundColor(Color(hexadecimal: "9fa2a9"))
                }
                Spacer()
            }
    }
}

struct MsgCell_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
    }
}
