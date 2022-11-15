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
    @State var bundleStr: URL? = Bundle.main.url(forResource: "www_en/index", withExtension: "html")

    func getCurrentLanguage() -> String {
        let preferredLang = Bundle.main.preferredLocalizations.first! as NSString
        switch String(describing: preferredLang) {
        case "zh-Hans-US","zh-Hans-CN","zh-Hant-CN","zh-TW","zh-HK","zh-Hans":
            return "cn"//中文
        default:
            return "en"
        }
    }
    
    var body: some View {
        let language = getCurrentLanguage()
        if language == "cn" {
            bundleStr = Bundle.main.url(forResource: "www_cn/index", withExtension: "html")
        }
        return MyWebView(url: $bundleStr)
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
