//
//  PicCell.swift
//  jmzs
//
//  Created by ilei on 2022/11/8.
//

import SwiftUI
import CoreData

struct PicCell: View {
    @ObservedObject var item: Pic
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                ZStack(alignment: .center) {
                    Image(systemName: "photo")
                        .font(.system(size: 16, weight: .regular))
                        .padding(14)
                        .foregroundColor(.white)
//                        .frame(width: 30, height: 30, alignment: .center)
                        .background(Circle().fill(Color(hexadecimal: "5366df")))
                }
                Spacer()
                Text("\(item.pics?.count ?? 0)")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color("titleColor"))
            }
            Text(item.title ?? "")
                .bold()
                .multilineTextAlignment(.leading)
                .foregroundColor(Color(hexadecimal: "8a8a8a"))
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground).brightness(0))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
