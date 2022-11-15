//
//  HideView.swift
//  jmzs
//
//  Created by ilei on 2022/11/14.
//

import SwiftUI
import Foundation

struct HideView: View {
    @Environment(\.presentationMode) var presentationMode

    func getCurrentFile() -> String {
        let lc = Locale.current.languageCode ?? ""
        if lc.contains("zh") {
            return "www_cn/index"//中文
        } else {
            return "www_en/index"
        }
    }
    
    var body: some View {
        let bundleStr = Bundle.main.url(forResource: getCurrentFile(), withExtension: "html")
        return MyWebView(url: bundleStr)
    }
    
    var cancelNavItem: some View {
        Button("cancel".localized(), action: {
            self.presentationMode.wrappedValue.dismiss()
        })
        .font(Font.body.bold())
    }
}

struct HideView_Previews: PreviewProvider {
    static var previews: some View {
        HideView()
    }
}
