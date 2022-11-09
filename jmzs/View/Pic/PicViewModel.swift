//
//  PicViewModel.swift
//  jmzs
//
//  Created by ilei on 2022/11/8.
//

import SwiftUI

class PicViewModel: ObservableObject {
    var allImages: [UUID] = []
    @Published var showImageViewer = false
    @Published var selectedImageID: UUID = UUID()
    @Published var imageViewerOffset: CGSize = .zero

    @Published var bgOpacity: Double = 1
    @Published var imageScale: CGFloat = 1

    func onChange(value: CGSize) {
        imageViewerOffset = value
    }

    func onEnd(value: DragGesture.Value) {
        withAnimation(.easeInOut) {
            var translation = value.translation.height
            if translation < 0 {
                translation = -translation
            }
            if translation < 250 {
                imageViewerOffset = .zero
                bgOpacity = 1
            } else {
                showImageViewer.toggle()
                imageViewerOffset = .zero
                bgOpacity = 1
            }
        }
    }
}
