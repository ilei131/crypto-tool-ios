//
//  PicCell.swift
//  jmzs
//
//  Created by ilei on 2022/11/8.
//

import SwiftUI
import CoreData

struct PicCell: View {
    @ObservedObject var item: Pic
    @Environment(\.managedObjectContext) var context
    @State private var showAlert = false

    var body: some View {
        VStack(alignment: .center) {
            Image("folder_blue").resizable().scaledToFit()
//            HStack(alignment: .center) {
//                Text("\(item.pics?.count ?? 0)")
//                    .font(.title)
//                    .bold()
//                    .lineLimit(1)
//                    .foregroundColor(Color("AccentColor"))
//                Spacer()
//                VStack() {
//                    Image(systemName: "photo")
//                        .font(.system(size: 24, weight: .regular))
//                        .foregroundColor(Color(hexadecimal: "5366df"))
//                }
//            }
            Text(item.title ?? "")
                .font(.system(size: 15))
                .lineLimit(1)
                .foregroundColor(Color("titleColor"))
                .padding(.top, 1)
            Text(itemFormateString(count: item.pics?.count ?? 0))
                .font(.system(size: 12))
                .lineLimit(1)
                .foregroundColor(Color(hexadecimal: "8a8a8a"))
        }
        .padding()
//        .cornerRadius(6)
//        .shadow(radius: 0.2)
        .overlay(DeleteButton(onDelete: removeRows), alignment:.topTrailing)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("tip".localized()),
                  message: Text("delete_sure".localized()),
                  primaryButton: .default(
                    Text("ok".localized()),
                    action: clearData
                  ),
                  secondaryButton: .destructive(
                    Text("cancel".localized())
                  )
            )
        }
    }
    
    func removeRows() {
        showAlert = true
    }
    
    func clearData() {
        withAnimation {
            context.delete(item)
            context.quickSave()
        }
    }
    
    func itemFormateString(count: Int) -> String {
        if (count == 1) {
            return "\(count) \("item".localized())"
        }
        return "\(count) \("items".localized())"
    }
}

struct DeleteButton: View {
    @Environment(\.editMode) var editMode
    let onDelete: () -> ()

    var body: some View {
        VStack {
            if self.editMode?.wrappedValue == .active {
                Button(action: {
                    self.onDelete()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .accentColor(Color("AccentColor"))
                        .imageScale(.large)
                }
            }
        }
    }
}
