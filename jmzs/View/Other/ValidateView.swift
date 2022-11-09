//
//  ValidateView.swift
//  jmzs
//
//  Created by ilei on 2022/11/7.
//

import SwiftUI
import SwiftUIX

struct ValidateView: View {
    @Binding var pwd: String
    var body: some View {
        VStack(alignment: .center) {
            Image("icon_no_bg")
                .resizable()
                .scaledToFit()
                .frame(CGSize(width: 150, height: 150))
                .padding(.top, 100)
            CocoaTextField("pwd_tip".localized(), text: $pwd)
                .secureTextEntry(true)
                .isFirstResponder(true)
                .multilineTextAlignment(.leading)
                .padding(.top, 20)
                .maxWidth(120)
            Spacer()
        }
    }}

struct ValidateView_Previews: PreviewProvider {
    static var previews: some View {
        ValidateView(pwd: .constant("123"))
    }
}
