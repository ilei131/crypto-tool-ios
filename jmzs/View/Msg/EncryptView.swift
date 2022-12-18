//
//  EncryptView.swift
//  jmzs
//
//  Created by ilei on 2022/11/8.
//

import SwiftUI
import CoreData
import Foundation

struct EncryptView: View {
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
                Section(header: headerView(type: 1)) {
                    VStack() {
                        HStack {
                            TextView(
                                text: $message,
                                isEditing: $isEditing,
                                placeholder: "input_plaintext".localized())
                        }
                        Spacer()
                    }
                    .minHeight(180)
                }
                if !model.content.isEmpty {
                    Section(header: headerView(type: 2)) {
                        VStack() {
                            HStack {
                                Text(model.content)
                                Spacer()
                            }
                            Spacer()
                        }
                        .minHeight(180)
                    }
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
            tipContent = "ciphertext_cannot_be_empty".localized()
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
                Text("input_plaintext".localized())
            } else {
                Text("ciphertext".localized())
            }
            Spacer()
            Button(action: {
                if type == 1 {
                    if let string = UIPasteboard.general.string {
                        message = string
                    }
                } else {
                    UIPasteboard.general.string = model.content
                    isPresentingToast = true
                }
            }) {
                Image(systemName: type == 1 ? "doc.on.clipboard" : "doc.on.doc")
                    .accentColor(Color("titleColor"))
                    .imageScale(.large)
                    .foregroundColor(Color("titleColor"))
            }
        }
    }
    
    var encryptNavItem: some View {
        Button("encrypt".localized(), action: {
            if message.isEmpty {
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
        let arr = ["1", message, date]
        let text = arr.joined(separator: ";")
        model.type = 1
        model.time = date
        model.content = text.aesEncrypt(keyString: DataManager.shared.defaultKey()) ?? ""
        isEditing = false
    }
}

struct EncryptView_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
    }
}
