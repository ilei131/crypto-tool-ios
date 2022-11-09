//
//  PicNavView.swift
//  jmzs
//
//  Created by ilei on 2022/11/7.
//

import SwiftUI

struct PicNavView: View {
    @State private var showCreateForm = false
    var type = 1
    var body: some View {
        let title = "photo".localized()
        return NavigationView() {
         PicView()
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
        DataManager.shared.discardNewPic()
        DataManager.shared.discardContext()
        showCreateForm = false
    }
    
    func beginCreate() {
        showCreateForm = true
    }
}

extension PicNavView {
    var createForm: some View {
        DataManager.shared.discardNewPic()
        DataManager.shared.prepareNewPic()
        return NavigationView {
            PicDetailView(
                picEntity: DataManager.shared.newPic!,
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

struct PicNavView_Previews: PreviewProvider {
    static var previews: some View {
        PicNavView()
    }
}
