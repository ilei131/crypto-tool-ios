//
//  Indicator.swift
//  jmzs
//
//  Created by ilei on 2022/11/8.
//

import SwiftUI
import UIKit

struct Indicator: UIViewRepresentable {
    let isAnimating: Bool
    
    init(isAnimating: Bool = true) {
        self.isAnimating = isAnimating
    }
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = false
        return activityIndicator
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        if isAnimating && uiView.isAnimating == false {
            uiView.startAnimating()
        }
        else if isAnimating == false && uiView.isAnimating {
            uiView.stopAnimating()
        }
    }
}
