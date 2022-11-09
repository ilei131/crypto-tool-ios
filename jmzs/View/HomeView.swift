//
//  HomeView.swift
//  jmzs
//
//  Created by ilei on 2022/11/7.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var dataManager = DataManager.shared
    @StateObject var vm = PicViewModel()

    init() {
        customBar()
    }
    
    var body: some View {
        if DataManager.shared.noMasterPwd() {
            NavigationView() {
                MasterPwdView()
            }
        } else if DataManager.shared.passwordsMatch() || !DataManager.shared.validateWhenLaunch {
                TabView {
                    PwdNavView()
                        .tabItem {
                            Image(systemName: "lock.shield")
                                .imageScale(.large)
                            Text("password".localized())
                        }
                    PicNavView()
                        .tabItem {
                            Image(systemName: "photo")
                                .imageScale(.large)
                            Text("photo".localized())
                        }
                    MsgNavView()
                        .tabItem {
                            Image(systemName: "ellipsis.bubble")
                                .imageScale(.large)
                            Text("letter".localized())
                    }
                    MoreNavView(dataManager: dataManager)
                        .tabItem {
                            Image(systemName: "gear")
                                .imageScale(.large)
                            Text("more".localized())
                    }
                }
                .overlay(
                    ZStack {
                        if vm.showImageViewer {
                            Color.black
                                .opacity(vm.bgOpacity)
                                .ignoresSafeArea()
                            BigPicView(filter: vm.selectedImageID)
                                
                        }
                    }
                )
                .environmentObject(vm)
        } else {
            ValidateView(pwd: $dataManager.pwd)
                .padding()
        }
    }
    
    func customBar() {
        let navApp = UINavigationBarAppearance.init()
        navApp.backgroundColor = UIColor.systemBackground
        navApp.shadowColor = UIColor.systemBackground
        UINavigationBar.appearance().standardAppearance = navApp
        UINavigationBar.appearance().backgroundColor = UIColor.systemBackground
        
        let barApp = UITabBarAppearance.init()
        barApp.configureWithOpaqueBackground()
        barApp.backgroundColor = UIColor.systemBackground
        UITabBar.appearance().standardAppearance = barApp
        UITabBar.appearance().backgroundColor = UIColor.systemBackground
        if #available(iOS 15.0, *) {
            UINavigationBar.appearance().scrollEdgeAppearance = navApp
            UITabBar.appearance().scrollEdgeAppearance = barApp
        }
    }
}
