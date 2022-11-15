//
//  EncryptPicView.swift
//  jmzs
//
//  Created by ilei on 2022/11/14.
//

import SwiftUI
import CoreData
import Foundation

struct EncryptPicView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var model: MsgEntity
    @State private var showAlert = false
    @State private var isPresentingToast = false
    @State private var tipContent = ""
    @State private var showImagePickerOptions: Bool = false
    @State private var showSheet: Bool = false
    @State private var sourceType = UIImagePickerController.SourceType.photoLibrary
    @State private var imageString = ""
    @State var editMode = true
    var body: some View {
        ZStack {
            Form {
                Section(header: Text("item_info".localized())) {
                    MyTextField(
                        isEdit:editMode,
                        text: $model.title,
                        label: "title".localized(),
                        placeholder: "title_placeholder".localized(),
                        content: .name,
                        isPresentingToast: $isPresentingToast
                    )
                }
                Section(header: Text("plaintext_pic".localized())) {
                    VStack() {
                        if !imageString.isEmpty {
                            if let imageData = Data.init(base64Encoded: imageString) {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Image(uiImage: UIImage(data:imageData)!)
                                        .renderingMode(.original)
                                        .resizable().aspectRatio(contentMode: .fit)
                                    Spacer()
                                }
                                Spacer()
                            }
                        } else {
                            Spacer()
                            HStack {
                                Button(action:{}) {
                                    Image("add")
                                        .renderingMode(.original)
                                        .resizable().aspectRatio(contentMode: .fit)
                                }
                                .frame(width: 80, height: 80, alignment: .center)
                                .highPriorityGesture(TapGesture().onEnded {
                                    showImagePickerOptions = true
                                })
                                .ActionSheet(showImagePickerOptions: $showImagePickerOptions, showImagePicker: $showSheet, sourceType: $sourceType)
                                Spacer()
                            }
                            Spacer()
                        }
                    }
                    .maxHeight(200)
                }
                Section(header: headerView(type: 2)) {
                    VStack() {
                        HStack {
                            Text(model.content)
                            Spacer()
                        }
                        Spacer()
                    }
                    .minHeight(200)
                }
            }
            .navigationBarItems(leading: cancelNavItem, trailing: encryptNavItem)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("tip".localized()),
                      message: Text(tipContent),
                      dismissButton: .default(Text("ok".localized())))
            }
            VStack {
                Spacer()
                HStack {
                    Button(action: saveAction, label: {
                        Text("save".localized())
                            .frame(width: UIScreen.main.bounds.width-40, height: 44)
                            .foregroundColor(.white)
                    })
                    .background(Color(UIColor(named: "AccentColor")!))
                    .cornerRadius(8)
                }
            }
        }
        .toast(isPresenting: $isPresentingToast,
               message: "copy".localized(),
               icon: .success,
               autoDismiss: .after(1))
        .sheet(isPresented: $showSheet) {
            ImagePicker(isShown: self.$showSheet,
                        sourceType: self.sourceType,
                        onSelect:onSelectAction,
                        needZip:true)
        }
    }
    
    func shareAction() {
        if model.content.isEmpty {
            tipContent = "ciphertext_cannot_be_empty".localized()
            showAlert = true
        }
    }
    
    func saveAction() {
        if model.title.isEmpty {
            tipContent = "tip_content".localized()
            showAlert = true
        } else if model.content.isEmpty {
            tipContent = "plaintext_cannot_be_empty".localized()
            showAlert = true
        } else {
            DataManager.shared.addMessageAndSave(model)
            self.presentationMode.wrappedValue.dismiss()
        }
    }

    var cancelNavItem: some View {
        Button("cancel".localized(), action: {
            self.presentationMode.wrappedValue.dismiss()
        })
            .font(Font.body.bold())
    }
    
    //1明文 2密文
    func headerView(type: Int) -> some View {
        HStack {
            Text("ciphertext".localized())
            Spacer()
            Button(action: {
                UIPasteboard.general.string = model.content
                isPresentingToast = true
            }) {
                Image(systemName: "doc.on.doc")
                    .accentColor(.black)
                    .imageScale(.large)
                    .foregroundColor(Color(UIColor(named: "titleColor")!))
            }
        }
    }
    
    var encryptNavItem: some View {
        Button("encrypt".localized(), action: {
            if imageString.isEmpty {
                tipContent = "plaintext_cannot_be_empty".localized()
                showAlert = true
            } else {
                makeCiphertext()
            }
        })
            .font(Font.body.bold())
    }
    
    func makeCiphertext() {
        let date = Date().formateString()
        let arr = ["2", imageString, date]
        let text = arr.joined(separator: ";")
        model.type = 2
        model.time = date
        model.content = text.aesEncrypt(keyString: DataManager.shared.defaultKey()) ?? ""
    }
    
    func onSelectAction(image: Data) {
        imageString = image.base64EncodedString()
    }
}
