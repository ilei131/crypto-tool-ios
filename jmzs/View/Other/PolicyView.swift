//
//  PolicyView.swift
//  jmzs
//
//  Created by ilei on 2022/11/7.
//

import SwiftUI

struct PolicyView: View {
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        let title = "policy".localized()
        ScrollView(.vertical, showsIndicators: false) {
            VStack() {
                Text("policy_content".localized())
                    .font(.system(size: 16))
            }
        }
        .padding()
        .navigationBarTitle(Text(title), displayMode:.inline)
        .navigationBarItems(leading: backNavItem)
    }
    
    var backNavItem: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "xmark")
                .imageScale(.large)
                .padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 20))
        }
    }
}

struct PolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PolicyView()
    }
}
