//
//  MsgListView.swift
//  jmzs
//
//  Created by ilei on 2022/11/8.
//

import SwiftUI

struct MsgListView: View {
    @Environment(\.managedObjectContext) var context
    var fetchRequest: FetchRequest<Msg>
    init(filter: String) {
        fetchRequest = FetchRequest<Msg>(entity: Msg.entity(), sortDescriptors: [
            NSSortDescriptor(keyPath: \Msg.createTime, ascending: false)
        ], predicate: NSPredicate(format: "title CONTAINS[cd] %@", filter))
    }

    init() {
        fetchRequest = FetchRequest<Msg>(entity: Msg.entity(), sortDescriptors: [
            NSSortDescriptor(keyPath: \Msg.createTime, ascending: false)
        ], predicate:nil)
    }
    
    var body: some View {
        if fetchRequest.wrappedValue.count > 0 {
            List {
                ForEach(fetchRequest.wrappedValue, id: \.self){ item in
                    NavigationLink(destination:  MsgDetailView(
                        model: DataManager.shared.attachMsg(item: item)
                    )) {
                        MsgCell(item: item)
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

}

struct MsgListView_Previews: PreviewProvider {
    static var previews: some View {
        MsgListView()
    }
}
