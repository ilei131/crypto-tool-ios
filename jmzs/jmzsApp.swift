//
//  jmzsApp.swift
//  jmzs
//
//  Created by ilei on 2022/11/7.
//

import SwiftUI

@main
struct jmzsApp: App {

    var body: some Scene {
        WindowGroup {
            let context = DataManager.shared.viewContext
            if DataManager.shared.enableFaceID {
                AuthView(viewModel: AuthViewModel())
                    .environment(\.managedObjectContext, context)
            } else {
                HomeView()
                    .environment(\.managedObjectContext, context)
            }
        }
    }
}
