//
//  AnyView.swift
//  jmzs
//
//  Created by ilei on 2022/11/8.
//

import SwiftUI

extension AnyView {
    static var emptyView: AnyView {
        AnyView(EmptyView())
    }
}

extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
    
    func hidden(_ hidden: Bool) -> some View {
        hidden ? AnyView(EmptyView()) : AnyView(self)
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil)
    }
}
