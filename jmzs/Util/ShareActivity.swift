//
//  ShareActivity.swift
//  jmzs
//
//  Created by ilei on 2022/12/31.
//

import Foundation
import SwiftUI
import LinkPresentation


struct ShareSheet: UIViewControllerRepresentable {
    let photo: UIImage
          
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let text = ""
        let itemSource = ShareActivityItemSource(shareText: text, shareImage: photo)
        
        let activityItems: [Any] = [photo, text, itemSource]
        
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: nil)
        
        return controller
    }
      
    func updateUIViewController(_ vc: UIActivityViewController, context: Context) {
    }
}

struct TextShareSheet: UIViewControllerRepresentable {
    let text: String
          
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let itemSource = ShareActivityItemSource(shareText: text, shareImage: nil)
        
        let activityItems: [Any] = [text, itemSource]
        
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: nil)
        
        return controller
    }
      
    func updateUIViewController(_ vc: UIActivityViewController, context: Context) {
    }
}

class ShareActivityItemSource: NSObject, UIActivityItemSource {
    
    var shareText: String
    var shareImage: UIImage?
    var linkMetaData = LPLinkMetadata()
    
    init(shareText: String, shareImage: UIImage?) {
        self.shareText = shareText
        self.shareImage = shareImage
        linkMetaData.title = shareText
        super.init()
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return UIImage(named: "AppIcon ") as Any
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return nil
    }
    
    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        return linkMetaData
    }
}

