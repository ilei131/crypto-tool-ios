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
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                ZStack(alignment: .center) {
                    Image(systemName: "photo")
                        .font(.system(size: 20, weight: .regular))
                        .padding(12)
                        .foregroundColor(Color(hexadecimal: "5366df"))
                        .background(Circle().fill(Color(hexadecimal: "F1F1F1")))
                }
                Spacer()
                Text("\(item.pics?.count ?? 0)")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color("titleColor"))
            }
            Text(item.title ?? "")
                .bold()
                .multilineTextAlignment(.leading)
                .foregroundColor(Color(hexadecimal: "8a8a8a"))
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground).brightness(0))
        .clipShape(RoundedRectangle(cornerRadius: 12))
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
                        .accentColor(Color(UIColor(named: "AccentColor")!))
                        .imageScale(.large)
                }
                .offset(x: 10, y: -10)
            }
        }
    }
}
