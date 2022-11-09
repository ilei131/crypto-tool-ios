//
//  NavProtocal.swift
//  jmzs
//
//  Created by ilei on 2022/11/8.
//

import SwiftUI

protocol NavProtocal {
    
    var onCreate: (() -> Void)? { set get }
    var onUpdate: (() -> Void)? { set get }
    var onCancel: (() -> Void)? { set get }
    
    var enableCreate: Bool? { set get }
    var enableUpdate: Bool? { set get }
    var enableCancel: Bool? { set get }
    
    func updateAction() -> Void
    func createAction() -> Void
    func cancelAction() -> Void
    func editAction() -> Void
}


// MARK: - Navigation Item

extension NavProtocal {
    
    var createNavItem: some View {
        Button("create".localized(), action: {
            createAction()
        })
            .font(Font.body.bold())
            .disabled(enableCreate == false)
    }
    
    var cancelNavItem: some View {
        Button("cancel".localized(), action: {
            cancelAction()
        })
            .font(Font.body.bold())
            .disabled(enableCreate == false)
    }
    
    var backNavItem: some View {
        Button(action: {
            cancelAction()
        }, label: {
            HStack {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                Text("back".localized())
                    .font(Font.body.bold())
            }
        })
    }
    
    var updateNavItem: some View {
        Button("update".localized(), action: {
            updateAction()
        })
            .font(Font.body.bold())
            .disabled(enableUpdate == false)
    }
    
    var editNavItem: some View {
        Button("edit".localized(), action: {
            editAction()
        })
            .font(Font.body.bold())
            .disabled(enableUpdate == false)
    }
    
}

// MARK: - Setup Method

extension NavProtocal {
    func setupNavItems(forForm form: AnyView, editMode: Bool = false) -> some View {
        if onCreate != nil, onCancel != nil {
            return AnyView(form.navigationBarItems(leading: cancelNavItem, trailing: createNavItem))
        }
        
        if onUpdate != nil, onCancel != nil {
            if editMode {
                return AnyView(form.navigationBarItems(trailing: updateNavItem))
            } else {
                return AnyView(form.navigationBarItems(trailing: editNavItem))
            }
        }
        return AnyView(form)
    }

}
