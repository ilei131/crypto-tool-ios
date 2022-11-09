//
//  EmptyView.swift
//  jmzs
//
//  Created by ilei on 2022/11/7.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
        VStack {
            Spacer()
            Image("empty")
            Spacer()
        }
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
