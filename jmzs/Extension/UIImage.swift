//
//  UIImage.swift
//  jmzs
//
//  Created by ilei on 2022/11/8.
//

import UIKit

extension UIImage {
    
    func thumbnail() -> UIImage? {
        let maxWidth = 200.0
        let maxHeight = 200.0
        var newImage: UIImage?
        if size.width < size.height {
            let width = maxHeight*size.width/size.height
            UIGraphicsBeginImageContext(CGSize.init(width: width, height: maxHeight))
            draw(in: CGRect.init(x: 0, y: 0, width: width, height: maxHeight))
            newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext();
        } else {
            if size.width > maxWidth {
                let height = maxWidth*size.height/size.width
                UIGraphicsBeginImageContext(CGSize.init(width: maxWidth, height: height))
                draw(in: CGRect.init(x: 0, y: 0, width: maxWidth, height: height))
                newImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
            } else {
                newImage = self
            }
        }
        return newImage
    }
}
