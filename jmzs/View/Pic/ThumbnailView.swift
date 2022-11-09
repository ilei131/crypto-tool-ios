//
//  ThumbnailView.swift
//  jmzs
//
//  Created by ilei on 2022/11/8.
//

import SwiftUI
import AVFoundation

struct ThumbnailView: View {
    @EnvironmentObject var vm: PicViewModel
    @Environment(\.managedObjectContext) var context

    var index = 0
    @ObservedObject var pictrue: Thumbnail
    
    var isEdit = false
    var isAdd = false

    var onDelete: ((Int) -> Void)?
    var onSelect: ((Data) -> Void)?
    var onShow: ((Data) -> Void)?

    @State private var showImagePickerOptions: Bool = false
    @State private var showSheet: Bool = false
    @State private var sourceType : Int?
    
    var body: some View {
        return ZStack(alignment: .center) {
            if isAdd {
                Button(action:{}) {
                    Image("add")
                        .renderingMode(.original)
                        .resizable().aspectRatio(contentMode: .fit)
                }
                .highPriorityGesture(TapGesture().onEnded {
                    showImagePickerOptions = true
                })
                .actionSheet(isPresented: $showImagePickerOptions) {
                    SwiftUI.ActionSheet(title: Text("Choose".localized()), buttons: [
                        .default(Text("Photo Library".localized())) {
                            sourceType = 1//.photoLibrary
                            showSheet = true
                        },
                        .default(Text("Camera".localized())) {
                            sourceType = 2//.camera
                            showSheet = true
                        },
                        .cancel()
                    ])
                }
            } else {
                if let imageData = pictrue.data {
                    Button(action:{}){
                        Image(uiImage: UIImage(data:imageData)!)
                            .renderingMode(.original)
                            .resizable().aspectRatio(contentMode: .fill)
                    }
                    .highPriorityGesture(TapGesture().onEnded {
                        if !isEdit {
                            withAnimation(.easeInOut) {
                                vm.selectedImageID = pictrue.id!
                                vm.showImageViewer.toggle()
                            }
                        }
                    })
                }
                if isEdit {
                    Button(action: {}) {
                        Image(systemName: "xmark.circle.fill")
                            .accentColor(Color(UIColor(named: "AccentColor")!))
                            .imageScale(.large)
                    }
                    .highPriorityGesture(TapGesture().onEnded {
                        if let onDeleteAction = onDelete {
                            onDeleteAction(index)
                        }
                    })
                }
            }
        }
        .sheet(isPresented: $showSheet) {
            if let _ = onSelect {
                ImagePicker(isShown: self.$showSheet,
                            sourceType: sourceType == 1 ? .photoLibrary : .camera,
                            onSelect:onSelectImage)
            } else {
                BigPicView(filter: pictrue.id!)
                    .environment(\.managedObjectContext, self.context)
            }
        }
    }
    
    func onSelectImage(data: Data) {
        if let onSelectAction = onSelect {
            onSelectAction(data)
        }
    }
}

extension ThumbnailView: Identifiable {
    public var id: Int {
        return hashValue
    }
}

extension ThumbnailView: Hashable {
    static func == (lhs: ThumbnailView, rhs: ThumbnailView) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    public var hashValue: Int {
        if isAdd {
            return 1234567
        }
        return pictrue.hashValue + (isEdit ? 10000 : 10001) + index
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(hashValue)
    }
}


struct ThumbnailView_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
    }
}
