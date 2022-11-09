//
//  PwdDetailView.swift
//  jmzs
//
//  Created by ilei on 2022/11/8.
//

import SwiftUI
import CoreData
import Foundation

struct PwdDetailView: View, NavProtocal {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var pwdEntity: PwdEntity
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

    var body: some View {
        
        let form = Form {
            Section(header: Text("item_info".localized())) {
                MyTextField(
                    isEdit:editMode,
                    text: $pwdEntity.title,
                    label: "title".localized(),
                    placeholder: "title_placeholder".localized(),
                    content: .name,
                    isPresentingToast: $isPresentingToast
                )
                if !pwdEntity.account.isEmpty || editMode {
                    MyTextField(
                        isEdit:editMode,
                        text: $pwdEntity.account,
                        label: "account".localized(),
                        placeholder: "account".localized(),
                        content: .username,
                        isPresentingToast: $isPresentingToast
                    )
                }
                if !pwdEntity.pwd.isEmpty  || editMode {
                    MyTextField(
                        isEdit:editMode,
                        text: $pwdEntity.pwd,
                        label: "password".localized(),
                        placeholder: "password".localized(),
                        content: .password,
                        isPwd: true,
                        isPresentingToast: $isPresentingToast
                    )
                }
                if !pwdEntity.website.isEmpty || editMode {
                    MyTextField(
                        isEdit:editMode,
                        text: $pwdEntity.website,
                        label: "website".localized(),
                        placeholder: "website".localized(),
                        content: .URL,
                        isPresentingToast: $isPresentingToast
                    )
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
                    if editMode && !changed, let store = pwdEntity.store {
                        pwdEntity.store = store
                    }
                }
    }
    
    func updateAction() {
        if pwdEntity.title.isEmpty {
            showAlert = true
            return
        }
        if let data = pwdEntity.store {
            DataManager.shared.addPwd(pwdEntity)
            DataManager.shared.deletePwd(data)
        }
        
        changed = true
        if (removeIds.count > 0) {
            DataManager.shared.removeBigImages(imageIds: removeIds)
        }
        self.presentationMode.wrappedValue.dismiss()
    }

    func createAction() {
        if pwdEntity.title.isEmpty {
            showAlert = true
            return
        }
        DataManager.shared.addPwdAndSave(pwdEntity)
        if let createCallback = onCreate {
            createCallback()
        }
    }
    
    func cancelAction() {
        if editMode, let store = pwdEntity.store {
            pwdEntity.store = store
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
}

struct PwdDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
    }
}
