//
//  MsgDetailView.swift
//  jmzs
//
//  Created by ilei on 2022/11/8.
//

import SwiftUI
import CoreData
import Foundation

struct MsgDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var model: MsgEntity
    @State private var isPresentingToast = false
    @State private var showAlert = false
    @State private var showSheet: Bool = false
    @State private var message = ""
    @State private var tipContent = ""
    @State var editMode = false

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
                            Text(model.content)
                        }
                        Spacer()
                    }
                    .minHeight(180)
                }
                if !message.isEmpty {
                    Section(header: headerView(type: 2)) {
                        VStack() {
                            HStack {
                                Text(message)
                            }
                            Spacer()
                        }
                        .minHeight(180)
                    }
                }
            }
        }
        .navigationBarItems(trailing: cipherTextNavItem)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("tip".localized()),
                  message: Text(tipContent),
                  dismissButton: .default(Text("ok".localized())))
        }
//        .sheet(isPresented: $showSheet) {
//            return NavigationView {
//                MsgCipherTextView(cipherText: model.message)
//                    .navigationBarTitle(Text("ciphertext".localized()), displayMode: .inline)
//            }
//        }
        .toast(isPresenting: $isPresentingToast,
               message: "copy".localized(),
               icon: .success,
               autoDismiss: .after(1))
    }
    
    //1明文 2密文
    func headerView(type: Int) -> some View {
        HStack {
            if type == 2 {
                Text("plaintext".localized())
            } else {
                Text("ciphertext".localized())
            }
            Spacer()
            Button(action: {
                UIPasteboard.general.string = type == 1 ? model.content : message
                isPresentingToast = true
            }) {
                Image(systemName: "doc.on.doc")
                    .accentColor(.black)
                    .imageScale(.large)
                    .foregroundColor(.black)
            }
        }
    }
    
    var cipherTextNavItem: some View {
        Button("plaintext".localized(), action: {
            if model.content.isEmpty {
                tipContent = "ciphertext_is_empty".localized()
                showAlert = true
            } else {
                if (model.mode == "default") {
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
                }
            }
        })
            .font(Font.body.bold())
    }
}

struct MsgDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
    }
}