//
//  MoreNavView.swift
//  jmzs
//
//  Created by ilei on 2022/11/7.
//

import SwiftUI
import StoreKit
import Foundation

struct MoreNavView: View {
    @State private var showAlert = false
    @State private var type: Int?
    @ObservedObject var dataManager: DataManager
    @State private var showShareSheet = false
    
    var body: some View {
        return NavigationView {
            VStack {
                let title = "more".localized()
                List {
                    Section(header: headerView) {
                        Button(action: {
                            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                                DispatchQueue.main.async {
                                    SKStoreReviewController.requestReview(in: scene)
                                }
                            }
                        }) {
                            MoreCell(icon:"star", title: "score".localized(), color: "fbc344")
                        }
                        Button(action: {
                            type = 1
                        }) {
                            MoreCell(icon:"lock.shield", title: "policy".localized(), color: "5366df")
                        }
                        Button(action: {
                            showAlert = true
                        }) {
                            MoreCell(icon:"trash", title: "trash".localized(), color: "e7605e")
                        }
                        HStack{
                            Image(systemName: "lock")
                                .resizable(true)
                                .scaledToFit()
                                .frame(CGSize(width: 24, height: 24))
                                .foregroundColor(Color(hexadecimal: "984ee4"))
                            if #available(iOS 14.0, *) {
                                Toggle("launch_pwd".localized(), isOn: $dataManager.validateWhenLaunch)
                                    .toggleStyle(SwitchToggleStyle(tint: Color(UIColor(named: "AccentColor")!)))
                            } else {
                                Toggle("launch_pwd".localized(), isOn: $dataManager.validateWhenLaunch)
                            }
                        }
                        HStack{
                            Image(systemName: "faceid")
                                .resizable(true)
                                .scaledToFit()
                                .frame(CGSize(width: 24, height: 24))
                                .foregroundColor(Color(hexadecimal: "56c37c"))
                            if #available(iOS 14.0, *) {
                                Toggle("enable face id".localized(), isOn: $dataManager.enableFaceID)
                                    .toggleStyle(SwitchToggleStyle(tint: Color(UIColor(named: "AccentColor")!)))
                            } else {
                                Toggle("enable face id".localized(), isOn: $dataManager.enableFaceID)
                            }
                        }
                    }
                }
                .navigationBarTitle(Text(title), displayMode:.inline)
                .navigationBarItems(trailing:
                    Menu {
                        Button(action: { type = 2 }, label: Label("scan qr code", systemImage: "qrcode.viewfinder"))
                        Button(action: {}, label: Label("make qr code", systemImage: "qrcode"))
                        Button(action: shareAction, label: Label("share this app", systemImage: "arrowshape.turn.up.forward"))
                    } label: {
                        icon: do {
                            Image(systemName: "plus")
                            .imageScale(.large)
                            .padding(EdgeInsets(top: 4, leading: 20, bottom: 4, trailing: 0))}
                    }
                )
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("tip".localized()),
                          message: Text("delete_tip".localized()),
                          primaryButton: .default(
                            Text("ok".localized()),
                            action: clearData
                          ),
                          secondaryButton: .destructive(
                            Text("cancel".localized())
                          )
                    )
                }
                .sheet(item:$type) { item in
                    switch item {
                        case 1:
                            createPolicyView
                        case 2:
                            createCodeScannerView
                    default:
                        EmptyView()
                    }
                }
            }
            .shareSheet(items: ["https://apps.apple.com/cn/app/加密助手/id6444359504"],
                        isPresented: $showShareSheet,
                        excludedActivityTypes:nil)
        }
    }
    
    func showMenu() {
        
    }
    
    func shareAction() {
        showShareSheet = true
    }
    
    var headerView: some View {
        HStack {
            Spacer()
            VStack(alignment: .center) {
                Image("icon_no_bg")
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                    .frame(CGSize(width: 150, height: 150))
                Text("Version 1.1")
                    .font(.system(size: 16))
            }
            Spacer()
        }
    }
    
    func clearData() {
        DataManager.shared.clearData()
    }
    
    var createPolicyView: some View {
        return NavigationView {
            PolicyView()
        }
    }
    
    var createCodeScannerView: some View {
        return EmptyView()
    }

}
