//
//  ImagePicker.swift
//  jmzs
//
//  Created by ilei on 2022/11/8.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    typealias imagePickerController = UIImagePickerController
    
    @Binding var isShown: Bool
    var sourceType: UIImagePickerController.SourceType = .camera
    var onSelect: ((Data) -> Void)?
    var needZip = false
    func makeUIViewController(context: Context) -> some UIViewController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(/*image: $image, */isShown: $isShown, onSelect: onSelect, needZip: needZip)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        @Binding var isShown: Bool
        var onSelect: ((Data) -> Void)?

        var sourceType: UIImagePickerController.SourceType = .camera
        var needZip: Bool
        init(isShown: Binding<Bool>, onSelect: ((Data) -> Void)?, needZip: Bool) {
            _isShown = isShown
            self.onSelect = onSelect
            self.needZip = needZip
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if needZip {
                if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                    if let onSelectAction = onSelect {
                        var image = uiImage
                        if let fixImage = getCompressedImage(uiImage) {
                            image = fixImage
                        }
                        var compression = 0.75
                        var data = image.jpegData(compressionQuality: compression)
                        var length = data?.count ?? 0
                        NSLog("压缩：\(compression) length:\(length)")
                        while length > 10*1024, compression > 0 {
                            data = image.jpegData(compressionQuality: compression)
                            length = data?.count ?? 0
                            NSLog("压缩：\(compression)")
                            compression -= 0.1
                        }
                        if let result = data {
                            onSelectAction(result)
                        }
                    }
                    isShown = false
                }
            } else {
                if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                    if let onSelectAction = onSelect {
                        if let data = uiImage.jpegData(compressionQuality: 1) {
                            onSelectAction(data)
                        }
                    }
                    isShown = false
                }
            }
        }
        
        func getPropertyImage(_ image: UIImage) -> UIImage? {
            let maxWidth = 150.0
            let maxHeight = 300.0
            var newImage: UIImage?
            if 2*image.size.width < image.size.height {
                let width = maxHeight*image.size.width/image.size.height
                UIGraphicsBeginImageContext(CGSize.init(width: width, height: maxHeight))
                image.draw(in: CGRect.init(x: 0, y: 0, width: width, height: maxHeight))
                newImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext();
            } else {
                if image.size.width > maxWidth {
                    let height = maxWidth*image.size.height/image.size.width
                    UIGraphicsBeginImageContext(CGSize.init(width: maxWidth, height: height))
                    image.draw(in: CGRect.init(x: 0, y: 0, width: maxWidth, height: height))
                    newImage = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()
                } else {
                    newImage = image
                }
            }
            return newImage
        }
        
        func getCompressedImage(_ image: UIImage) -> UIImage? {
            let maxWidth = 200.0
            let maxHeight = 400.0
            var newImage: UIImage?
            if 2*image.size.width < image.size.height {
                let width = maxHeight*image.size.width/image.size.height
                UIGraphicsBeginImageContext(CGSize.init(width: width, height: maxHeight))
                image.draw(in: CGRect.init(x: 0, y: 0, width: width, height: maxHeight))
                newImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext();
            } else {
                if image.size.width > maxWidth {
                    let height = maxWidth*image.size.height/image.size.width
                    UIGraphicsBeginImageContext(CGSize.init(width: maxWidth, height: height))
                    image.draw(in: CGRect.init(x: 0, y: 0, width: maxWidth, height: height))
                    newImage = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()
                } else {
                    newImage = image
                }
            }
            return newImage
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            isShown = false
        }
    }
}
