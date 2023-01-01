//
//  EmptyView.swift
//  jmzs
//
//  Created by ilei on 2022/11/7.
//

import SwiftUI

struct EmptyTipView: View {
    var body: some View {
        VStack {
            Spacer()
            Image("empty")
            Spacer()
        }
    }
}

struct EmptyTipView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
