//
//  MsgNavView.swift
//  jmzs
//
//  Created by ilei on 2022/11/7.
//

import SwiftUI

struct MsgNavView: View {
    @State private var showActionSheet = false
    @State private var showCreateForm = false
    @State private var type: Int?
    var body: some View {
        let title = "letter".localized()
        NavigationView() {
            MsgView()//lock.open
                .navigationBarTitle(Text(title), displayMode:.inline)
                .navigationBarItems(leading: Button(action: {type = 2}) {
                    Image(systemName: "lock.open")
                        .imageScale(.large)
                        .padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 20))
                },trailing:
                    Button(action: {
                    type = 1
                }) {
                        Image(systemName: "plus")
                            .imageScale(.large)
                            .padding(EdgeInsets(top: 4, leading: 20, bottom: 4, trailing: 0))
                    }
                )
                .sheet(item:$type) { item in
                    switch item {
                        case 1:
                            createEncryptForm
                        case 2:
                            createDecryptForm
                        case 3:
                            createEncryptPicForm
                    default:
                        EmptyView()
                    }
                }
        }
        .actionSheet(isPresented: $showActionSheet) {
            SwiftUI.ActionSheet(title: Text("add_letter_tip".localized()), buttons: [
                .default(Text("secret_text".localized())) { beginCreate(1) },
                .default(Text("secret_photo".localized())) { beginCreate(3) },
                .cancel()
            ])
        }
    }
    
    func cancelCreateNewStore() {
        DataManager.shared.discardNewMsg()
        DataManager.shared.discardContext()
        showCreateForm = false
    }

    func beginCreate(_ opType: Int) {
        // discard and prepare a new object for the form
        type = opType
        showCreateForm = true
    }
}

extension MsgNavView {
    var createEncryptForm: some View {
        DataManager.shared.discardNewMsg()
        DataManager.shared.prepareNewMsg(type: 1)
        return NavigationView {
            EncryptView(
                model: DataManager.shared.newMsg!)
            .navigationBarTitle(Text("secret_msg".localized()), displayMode: .inline)
        }
    }
    
    var createEncryptPicForm: some View {
        DataManager.shared.discardNewMsg()
        DataManager.shared.prepareNewMsg(type: 1)
        return NavigationView {
//            MsgEncryptPicView(
//                model: DataManager.shared.newMsg!)
//            .navigationBarTitle(Text("secret_msg".localized()), displayMode: .inline)
        }
    }
    
    var createDecryptForm: some View {
        DataManager.shared.discardNewMsg()
        DataManager.shared.prepareNewMsg(type: 2)
        return NavigationView {
            DecryptView(
                model: DataManager.shared.newMsg!)
            .navigationBarTitle(Text("secret_msg".localized()), displayMode: .inline)
        }
    }
}

extension Int: Identifiable {
    public var id: Int {
        return self
    }
}


struct MsgNavView_Previews: PreviewProvider {
    static var previews: some View {
        MsgNavView()
    }
}
