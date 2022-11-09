//
//  Util.swift
//  jmzs
//
//  Created by ilei on 2022/11/7.
//

import Foundation
import SwiftUI
import SwiftUIX

struct MyButtonStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding(.all)
            .foregroundColor(.white)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .background(Color(hexadecimal: "5366df"))
            .cornerRadius(8)
    }
}

extension View {
    func myButtonStyle() -> some View {
        ModifiedContent(content: self, modifier: MyButtonStyle())
    }
}
