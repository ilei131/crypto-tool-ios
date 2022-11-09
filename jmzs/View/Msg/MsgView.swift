//
//  MsgView.swift
//  jmzs
//
//  Created by ilei on 2022/11/8.
//

import SwiftUI
import SwiftUIX
import CoreData

struct MsgView: View {
    @Environment(\.managedObjectContext) var context
    @State var isEditing: Bool = false
    @State var searchText: String = ""
    
    var body: some View {
        VStack {
            SearchBar("", text:$searchText, isEditing:$isEditing)
                .showsCancelButton(isEditing)
                .onCancel {
                    
                }
            if (searchText.isEmpty) {
                MsgListView().environment(\.managedObjectContext, self.context)
            } else {
                MsgListView.init(filter: searchText)
                    .environment(\.managedObjectContext, self.context)
            }
        }
    }
}

struct MsgView_Previews: PreviewProvider {
    static var previews: some View {
        MsgView()
    }
}
