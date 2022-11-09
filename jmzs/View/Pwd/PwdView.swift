//
//  PwdView.swift
//  jmzs
//
//  Created by ilei on 2022/11/7.
//

import SwiftUI
import SwiftUIX
import CoreData

struct PwdView: View {
    @Environment(\.managedObjectContext) var context

    @State var isEditing: Bool = false
    @State var searchText: String = ""
    var type = 1

    var body: some View {
        VStack {
            SearchBar("", text:$searchText, isEditing:$isEditing)
                .showsCancelButton(isEditing)
                .onCancel {
                    
                }
            if (searchText.isEmpty) {
                PwdListView().environment(\.managedObjectContext, self.context)
            } else {
                PwdListView.init(filter: searchText)
                    .environment(\.managedObjectContext, self.context)
            }
        }
    }
}

struct PwdView_Previews: PreviewProvider {
    static var previews: some View {
        PwdView()
    }
}
