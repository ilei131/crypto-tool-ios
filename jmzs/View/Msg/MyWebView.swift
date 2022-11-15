//
//  MyWebView.swift
//  jmzs
//
//  Created by ilei on 2022/11/14.
//

import SwiftUI
import WebKit

struct MyWebView: UIViewRepresentable {
    
    @Binding var url: URL?
    
    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration.init()
        config.preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")
        config.setValue(true, forKey: "allowUniversalAccessFromFileURLs")
        let webview = WKWebView.init(frame: UIScreen.main.bounds, configuration: config)
        webview.navigationDelegate = context.coordinator
        return webview
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = url  {
            uiView.loadFileURL(url, allowingReadAccessTo: Bundle.main.bundleURL)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
        
    class Coordinator: NSObject,WKNavigationDelegate {
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript("document.title") { (result, error) in
                print("didFinish:\(String(describing: result ?? ""))")
            }
        }
    }
}
