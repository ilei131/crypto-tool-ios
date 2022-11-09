//
//  PicDetailView.swift
//  jmzs
//
//  Created by ilei on 2022/11/8.
//

import SwiftUI

import SwiftUI
import CoreData
import Foundation

struct PicDetailView: View, NavProtocal {
    @EnvironmentObject var vm: PicViewModel
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var picEntity: PicEntity
    @State private var showAlert = false
    @State var editMode = false
    var onCreate: (() -> Void)?
    var onUpdate: (() -> Void)?
    var onCancel: (() -> Void)?
    var enableCreate: Bool?
    var enableUpdate: Bool?
    var enableCancel: Bool?
    @State var changed = false
    @State var removeIds = [UUID]()
    @State var addIds = [UUID]()
    @State private var isPresentingToast = false

    private let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        
        let form = Form {
            Section(header: Text("item_info".localized())) {
                MyTextField(
                    isEdit:editMode,
                    text: $picEntity.title,
                    label: "title".localized(),
                    placeholder: "title_placeholder".localized(),
                    content: .name,
                    isPresentingToast: $isPresentingToast
                )
            }
            if picEntity.pics.count > 0 || editMode {
                Section(header: Text("photo".localized())) {
                    LazyVGrid(columns: columns) {
                        ForEach(pictureViews(), id: \.self) { pic in
                            Rectangle()
                                .foregroundColor(.clear)
                                .background(
                                    pic
                                )
                                .minHeight(80)
                                .clipped()
                                .clipShape(RoundedRectangle(cornerRadius: 4))
                        }
                    }
//                    Grid(pictureViews()) { pic in
//                        Rectangle()
//                            .foregroundColor(.clear)
//                            .background(
//                                pic
//                            )
//                            .clipped()
//                            .clipShape(RoundedRectangle(cornerRadius: 4))
//                    }
                }
            }
        }
        return setupNavItems(forForm: form.eraseToAnyView(), editMode: editMode)
                .toast(isPresenting: $isPresentingToast,
                   message: "copy".localized(),
                   icon: .success,
                   autoDismiss: .after(1))
                .onTapGesture {
                    hideKeyboard()
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("tip".localized()),
                          message: Text("tip_content".localized()),
                          dismissButton: .default(Text("ok".localized())))
                }
                .onDisappear{
                    if editMode && !changed, let store = picEntity.store {
                        picEntity.store = store
                        if (addIds.count > 0) {
                            DataManager.shared.removeBigImages(imageIds: addIds)
                        }
                    }
                }
                .onAppear {
                    if #available(iOS 14.0, *) {
                        var ids = [UUID]()
                        for pic in picEntity.pics {
                            if let uuid = pic.id {
                                ids.append(uuid)
                            }
                        }
                        vm.allImages = ids
                    }
                }
    }
    
    func updateAction() {
        if picEntity.title.isEmpty {
            showAlert = true
            return
        }
        if let data = picEntity.store {
            DataManager.shared.addPic(picEntity)
            DataManager.shared.deletePic(data)
        }
        
        changed = true
        if (removeIds.count > 0) {
            DataManager.shared.removeBigImages(imageIds: removeIds)
        }
        self.presentationMode.wrappedValue.dismiss()
    }

    func createAction() {
        if picEntity.title.isEmpty {
            showAlert = true
            return
        }
        DataManager.shared.addPicAndSave(picEntity)
        if let createCallback = onCreate {
            createCallback()
        }
    }
    
    func cancelAction() {
        if editMode, let store = picEntity.store {
            picEntity.store = store
            editMode = false
        }
        if let cancelCallback = onCancel {
            cancelCallback()
        }
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func editAction() {
        editMode = true
    }
    
    func onSelectAction(image: Data) {
        let pic = Thumbnail()
        pic.id = UUID()
        if let fixedImage = UIImage(data: image) {
            pic.data = fixedImage.thumbnail()?.jpegData(compressionQuality: 1)
            DataManager.shared.addBigImage(image: image, id: pic.id)
            addIds.append(pic.id!)
        }
        picEntity.pics.append(pic)
    }
    
    func pictureViews() -> [ThumbnailView] {
        var views = [ThumbnailView]()
        for i in 0..<picEntity.pics.count {
            views.append(ThumbnailView(index:i,
                                   pictrue: picEntity.pics[i],
                                    isEdit: editMode,
                                     isAdd: false,
                                  onDelete: onDeleteAction,
                                    onShow: onShowAction))
        }
        if editMode {
            let pic = Thumbnail()
            pic.id = UUID()
            views.append(ThumbnailView(pictrue: pic,
                                     isAdd: true,
                                     onSelect: onSelectAction))
        }
        
        return views
    }
    
    func pictures() -> [Thumbnail] {
        var pics = [Thumbnail]()
        pics.append(contentsOf: picEntity.pics)
        if editMode {
            pics.append(Thumbnail())
        }
        return pics
    }
    
    func onDeleteAction(index: Int) {
        if index < picEntity.pics.count {
            if let id = picEntity.pics[index].id {
                removeIds.append(id)
            }
            picEntity.pics.remove(at: index)
        }
    }
    
    func onShowAction(image: Data) {
        
    }
}


struct PicDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
    }
}
