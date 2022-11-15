//
//  DecryptView.swift
//  jmzs
//
//  Created by ilei on 2022/11/8.
//

import SwiftUI
import CoreData
import Foundation

struct DecryptView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var model: MsgEntity
    @State private var showAlert = false
    @State private var isPresentingToast = false
    @State private var showShareSheet = false
    @State private var tipContent = ""
    @State private var isEditing = false
    @State private var message = ""
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
                if !message.isEmpty {
                    Section(header: headerView(type: 1)) {
                        if model.type == 1 {
                            VStack() {
                                HStack {
                                    Text(message)
                                    Spacer()
                                }
                                Spacer()
                            }
                            .minHeight(180)
                        } else {
                            if let imageData = Data.init(base64Encoded: message) {
                                VStack() {
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
                            }
                        }
                    }
                }
                Section(header: headerView(type: 2)) {
                    VStack() {
                        HStack {
                            TextView(
                                text: $model.content,
                                isEditing: $isEditing,
                                placeholder: "copy_ciphertext".localized())
                        }
                        Spacer()
                    }
                    .minHeight(180)
                }
            }
            .navigationBarItems(leading: cancelNavItem, trailing: decryptNavItem)
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
                    .background(Color(hexadecimal: "5366df"))
                    .cornerRadius(8)
                }
            }
        }
        .toast(isPresenting: $isPresentingToast,
               message: "copy".localized(),
               icon: .success,
               autoDismiss: .after(1))
        .shareSheet(items: [model.content],
                    isPresented: $showShareSheet,
                    excludedActivityTypes:nil)
    }
    
    func shareAction() {
        if model.content.isEmpty {
            tipContent = "ciphertext_cannot_be_empty".localized()
            showAlert = true
        } else {
            showShareSheet = true
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
            if type == 1 {
                Text("plaintext".localized())
            } else {
                Text("copy_ciphertext".localized())
            }
            Spacer()
            if type == 1  {
                if model.type == 1 {
                    Button(action: {
                        UIPasteboard.general.string = message
                        isPresentingToast = true
                    }) {
                        Image(systemName: "doc.on.doc")
                            .accentColor(.black)
                            .imageScale(.large)
                            .foregroundColor(.black)
                    }
                }
            } else {
                Button(action: {
                    if let string = UIPasteboard.general.string {
                        model.content = string
                    }
                }) {
                    Image(systemName: "doc.on.clipboard")
                        .accentColor(.black)
                        .imageScale(.large)
                        .foregroundColor(.black)
                }
            }
        }
    }
    
    var decryptNavItem: some View {
        Button("decrypt".localized(), action: {
            if model.content.isEmpty {
                tipContent = "ciphertext_cannot_be_empty".localized()
                showAlert = true
            } else {
                makePlaintext()
            }
        })
            .font(Font.body.bold())
    }
    
    func makePlaintext() {
        guard let text = model.content.aesDecrypt(keyString: DataManager.shared.defaultKey()) else {
            tipContent = "invalidate_ciphertext".localized()
            showAlert = true
            return
        }
        
        let arr = text.split(separator: ";").compactMap{"\($0)"}
        if arr.count == 3 {
            model.type = Int(arr[0])!
            message = arr[1]
            model.time = arr[2]
        }
        isEditing = false
    }
}
