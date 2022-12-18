//
//  MoreCell.swift
//  jmzs
//
//  Created by ilei on 2022/11/8.
//

import SwiftUI

struct MoreCell: View {
    var icon = ""
    var title = ""
    var body: some View {
        HStack {
            Image(systemName: icon)
                .resizable(true)
                .scaledToFit()
                .frame(CGSize(width: 24, height: 24))
                .foregroundColor(Color("titleColor"))
            Text(title)
                .foregroundColor(Color("titleColor"))
            Spacer()
        }
    }
}

struct MoreCell_Previews: PreviewProvider {
    static var previews: some View {
        MoreCell(icon: "", title: "")
    }
}
