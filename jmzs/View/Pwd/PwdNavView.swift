//
//  PwdNavView.swift
//  jmzs
//
//  Created by ilei on 2022/11/7.
//

import SwiftUI
import SwiftUIX
import CoreData

struct PwdNavView: View {
    @State private var showCreateForm = false
    var type = 1
    var body: some View {
        let title = "password".localized()
        return NavigationView() {
         PwdView(type: type)
                .navigationBarTitle(Text(title), displayMode:.inline)
                .navigationBarItems(trailing:
                    Button(action: { beginCreate()}) {
                        Image(systemName: "plus")
                            .imageScale(.large)
                            .padding(EdgeInsets(top: 4, leading: 20, bottom: 4, trailing: 0))
                    }
                )
                .sheet(isPresented: $showCreateForm, onDismiss: cancelCreateNewStore, content: { self.createForm })
        }
    }
    
    func cancelCreateNewStore() {
        DataManager.shared.discardNewPwd()
        DataManager.shared.discardContext()
        showCreateForm = false
    }
    
    func beginCreate() {
        showCreateForm = true
    }
}

extension PwdNavView {
    var createForm: some View {
        DataManager.shared.discardNewPwd()
        DataManager.shared.prepareNewPwd()
        return NavigationView {
            PwdDetailView(
                pwdEntity: DataManager.shared.newPwd!,
                editMode: true,
                onCreate: create,
                onCancel: cancel,
                enableCreate: true
            )
            .navigationBarTitle(Text("new_item".localized()), displayMode: .inline)
        }
    }
    
    func create() {
        showCreateForm = false
    }
    
    func cancel() {
        showCreateForm = false
    }
}

struct PwdNavView_Previews: PreviewProvider {
    static var previews: some View {
        PwdNavView()
    }
}
