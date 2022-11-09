//
//  ActionSheetModifier.swift
//  jmzs
//
//  Created by ilei on 2022/11/8.
//

import SwiftUI

struct ActionSheetModifier: ViewModifier {

    @Binding var showImagePickerOptions: Bool
    @Binding var showImagePicker: Bool
    @Binding var sourceType: UIImagePickerController.SourceType

    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .confirmationDialog(Localization.chooseTitle, isPresented: $showImagePickerOptions, titleVisibility: .visible) {
                    Button(Localization.photoLibraryTitle) {
                        sourceType = .photoLibrary
                        showImagePicker = true
                    }

                    Button(Localization.cameraTitle) {
                        sourceType = .camera
                        showImagePicker = true
                    }
                }
        }
        else {
            content
                .actionSheet(isPresented: $showImagePickerOptions) {
                    ActionSheet(title: Text(Localization.chooseTitle), buttons: [
                        .default(Text(Localization.photoLibraryTitle)) {
                            sourceType = .photoLibrary
                            showImagePicker = true
                        },

                        .default(Text(Localization.cameraTitle)) {
                            sourceType = .camera
                            showImagePicker = true

                        },
                        .cancel()
                    ])
                }
        }
    }
}

// MARK: View extension
extension View {

    func ActionSheet(showImagePickerOptions: Binding<Bool>, showImagePicker: Binding<Bool>, sourceType: Binding<UIImagePickerController.SourceType>) -> some View {
        // Conditional check has to be done inside the Group function builder,
        // otherwise the iOS 15 modifier will be loaded into memory and the app will crash.
        Group {
            self.modifier(ActionSheetModifier(showImagePickerOptions: showImagePickerOptions, showImagePicker: showImagePicker, sourceType: sourceType))
        }
    }
}

// MARK: Localization
private enum Localization {
    static let chooseTitle = NSLocalizedString("Choose", comment: "Action sheet title")
    static let photoLibraryTitle = NSLocalizedString("Photo Library", comment: "Action sheet text for `Photo Library` option")
    static let cameraTitle = NSLocalizedString("Camera", comment: " Action sheet text `Camera` option")
}

