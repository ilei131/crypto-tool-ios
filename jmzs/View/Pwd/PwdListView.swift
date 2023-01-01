//
//  PwdListView.swift
//  jmzs
//
//  Created by ilei on 2022/11/7.
//

import SwiftUI
import CoreData

struct PwdListView: View {
    @Environment(\.managedObjectContext) var context

    var fetchRequest: FetchRequest<Pwd>
    
    init(filter: String) {
        fetchRequest = FetchRequest<Pwd>(entity: Pwd.entity(), sortDescriptors: [
            NSSortDescriptor(keyPath: \Pwd.createTime, ascending: false)
        ], predicate: NSPredicate(format: "title CONTAINS[cd] %@ OR account CONTAINS[cd] %@ OR website CONTAINS[cd] %@", filter, filter, filter))
    }

    init() {
        fetchRequest = FetchRequest<Pwd>(entity: Pwd.entity(), sortDescriptors: [
            NSSortDescriptor(keyPath: \Pwd.createTime, ascending: false)
        ])
    }
    
    var body: some View {
        if fetchRequest.wrappedValue.count > 0 {
            List {
                ForEach(fetchRequest.wrappedValue, id: \.self){ item in
                    NavigationLink(destination:
                                    PwdDetailView(
                                        pwdEntity: DataManager.shared.attachPwd(item: item),
                                        onUpdate: update,
                                        onCancel: cancel,
                                        enableUpdate: true
                                    )) {
                        PwdCell(item: item)
                    }
                }
                .onDelete(perform: self.removeItem)
            }
        } else {
            EmptyTipView()
        }
    }
    
    func removeItem(at offsets: IndexSet) {
        for index in offsets {
            let data = fetchRequest.wrappedValue[index]
            context.delete(data)
        }
        context.quickSave()
    }
    
    func update() {}
    
    func cancel() {}
}


struct PwdListView_Previews: PreviewProvider {
    static var previews: some View {
        PwdListView()
    }
}
