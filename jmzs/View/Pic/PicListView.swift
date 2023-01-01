//
//  PicListView.swift
//  jmzs
//
//  Created by ilei on 2022/11/8.
//

import SwiftUI

struct PicListView: View {
    @Environment(\.managedObjectContext) var context
    var fetchRequest: FetchRequest<Pic>
    init(filter: String) {
        fetchRequest = FetchRequest<Pic>(entity: Pic.entity(), sortDescriptors: [
            NSSortDescriptor(keyPath: \Pic.createTime, ascending: false)
        ], predicate: NSPredicate(format: "title CONTAINS[cd] %@", filter))
    }

    init() {
        fetchRequest = FetchRequest<Pic>(entity: Pic.entity(), sortDescriptors: [
            NSSortDescriptor(keyPath: \Pic.createTime, ascending: false)
        ], predicate:nil)
    }
    
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        if fetchRequest.wrappedValue.count > 0 {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(fetchRequest.wrappedValue, id: \.self){ item in
                        NavigationLink(destination:
                                        PicDetailView(
                                            picEntity: DataManager.shared.attachPic(item: item),
                                            onUpdate: update,
                                            onCancel: cancel,
                                            enableUpdate: true
                                        )) {
                            PicCell(item: item)
                        }
                    }
                    .onDelete(perform: self.removeItem)
                }
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 10, trailing: 20))
            }
            .background(Color(.systemGroupedBackground))
        } else {
            EmptyTipView()
        }
//        if fetchRequest.wrappedValue.count > 0 {
//            List {
//                ForEach(fetchRequest.wrappedValue, id: \.self){ item in
//                    NavigationLink(destination:
//                                    PicDetailView(
//                                        picEntity: DataManager.shared.attachPic(item: item),
//                                        enableUpdate: true
//                                    )) {
//                        PicCell(item: item)
//                    }
//                }
//                .onDelete(perform: self.removeItem)
//            }
//        } else {
//            EmptyView()
//        }
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
