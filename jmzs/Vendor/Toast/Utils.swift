//
//  Utils.swift
//  jmzs
//
//  Created by ilei on 2022/11/8.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder
    func `ifElse`<V: View, T: View>(_ condition: Bool, _ then: @escaping (Self) -> V, `else`: @escaping ((Self) -> T)) -> some View {
        if condition {
            then(self)
        } else {
            `else`(self)
        }
    }
    
    @ViewBuilder
    func `if`<V: View>(_ condition: Bool, _ then: (Self) -> V) -> some View {
        if condition {
            then(self)
        } else {
            self
        }
    }
}
