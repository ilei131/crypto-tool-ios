//
//  MoreNavView.swift
//  jmzs
//
//  Created by ilei on 2022/11/7.
//

import SwiftUI
import StoreKit

struct MoreNavView: View {
    @State private var showAlert = false
    @State private var showSheet = false //
    @ObservedObject var dataManager: DataManager
    
    var body: some View {
        return NavigationView {
            VStack {
                let title = "more".localized()
                Form {
                    Section(header: headerView) {
                        Button(action: {
                            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                                DispatchQueue.main.async {
                                    SKStoreReviewController.requestReview(in: scene)
                                }
                            }
                        }) {
                            MoreCell(icon:"star", title: "score".localized())
                        }
                        Button(action: {
                            showSheet = true
                        }) {
                            MoreCell(icon:"lock.shield", title: "policy".localized())
                        }
                        Button(action: {
                            showAlert = true
                        }) {
                            MoreCell(icon:"trash", title: "trash".localized())
                        }
                        HStack{
                            Image(systemName: "lock")
                                .resizable(true)
                                .scaledToFit()
                                .frame(CGSize(width: 24, height: 24))
                                .foregroundColor(.black)
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
                                .foregroundColor(.black)
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
                .sheet(isPresented: $showSheet) {
                    createForm
                }
            }
        }
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
                Text("Version 1.0")
                    .font(.system(size: 16))
            }
            Spacer()
        }
    }
    
    func clearData() {
        DataManager.shared.clearData()
    }
    
    var createForm: some View {
        return NavigationView {
            PolicyView()
        }
    }
}

struct MoreNavView_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
    }
}
